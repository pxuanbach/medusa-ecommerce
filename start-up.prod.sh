#!/bin/bash

# Step 1
# Define service groups
BACKEND_SERVICE="backend"
ADMIN_SERVICE="admin"
STOREFRONT_SERVICE="storefront"
OTHER_SERVICES="postgres redis"
BACKEND_PORT=9000
STOREFRONT_PORT=8000

TIMEOUT=60  # Timeout in seconds
SLEEP_INTERVAL=5  # Time to sleep between retries in seconds
MAX_RETRIES=$((TIMEOUT / SLEEP_INTERVAL))

# Step 2.1
# Build docker images
echo "Build docker images"
docker compose -f docker-compose.prod.yml build --no-cache $BACKEND_SERVICE $ADMIN_SERVICE

# Step 2.2
# Remove current backend group
docker compose -f docker-compose.prod.yml down $BACKEND_SERVICE $ADMIN_SERVICE

# Step 2.3
# Start all services in the backend group
# $1 to pass more options into command
echo "Run backend groups"
docker compose -f docker-compose.prod.yml up -d $1 $BACKEND_SERVICE $ADMIN_SERVICE $OTHER_SERVICES

# Step 3.1
# Wait for the new environment to become healthy
echo "Waiting for [$BACKEND_SERVICE] to become healthy..."
sleep 15

i=0
REGION_COUNT=0
while [ "$i" -le $MAX_RETRIES ]; do
  HEALTH_CHECK_URL="http://localhost:$BACKEND_PORT/store/regions"

  response=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL)
  # Check the HTTP status code
  if [ $response -eq 200 ]; then
      echo "[$BACKEND_SERVICE] is healthy"

      # Retrieve the number of regions
      response=$(curl -X GET $HEALTH_CHECK_URL -H "Content-Type: application/json")
      REGION_COUNT=$(echo $response | grep -oP '"count":\s*\K[0-9]+')

      break
  else
      echo "Health check failed. API returned HTTP status code: $response"
  fi

  i=$(( i + 1 ))
  sleep "$SLEEP_INTERVAL"
done

# Step 3.2
# Initialize sample data for Backend
if [ "$REGION_COUNT" -gt 0 ]; then
  echo "The application already has data"
else
  echo "Initialize seed data"
  docker compose -f docker-compose.prod.yml exec $BACKEND_SERVICE yarn seed
fi

# Step 4.1
echo "Build docker images"
docker compose -f docker-compose.prod.yml build --no-cache $STOREFRONT_SERVICE

# Step 4.2
# Remove current storefront group
docker compose -f docker-compose.prod.yml down $STOREFRONT_SERVICE

# Step 4.3
# Start all services in the storefront group
# $1 to pass more options into command
docker compose -f docker-compose.prod.yml up -d $1 $STOREFRONT_SERVICE


# Step 5
# Wait for the new environment to become healthy
echo "Waiting for [$STOREFRONT_SERVICE] to become healthy..."
sleep 30

# Step 6
# Remove unused images
(docker images -q --filter 'dangling=true' -q | xargs docker rmi) || true
