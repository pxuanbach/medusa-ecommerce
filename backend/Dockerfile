### Dependencies ###
FROM node:20-alpine as deps
WORKDIR /app/

# Copy medusa package.json and yarn.lock from /backend
COPY ./package*.json .
COPY ./yarn.lock? .

# Install deps
RUN yarn install --frozen-lockfile

### Build ###
FROM node:20-alpine as builder
WORKDIR /app

# Copy cached node_modules from deps
COPY --from=deps /app/node_modules /app/node_modules

# Install python and medusa-cli
RUN apk update
RUN apk add python3
RUN yarn global add @medusajs/medusa-cli@latest

# Copy app source code
COPY . /app

# Rebuild admin
RUN yarn build:admin

# Image entrypoint develop
ENTRYPOINT ["/bin/sh", "./develop.sh", "develop"]
