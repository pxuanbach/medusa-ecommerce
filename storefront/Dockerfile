### Dependencies ###
FROM node:20-alpine as deps
WORKDIR /app/

# Copy storefront package package.json and yarn.lock from /storefront
COPY ./package*.json .
COPY ./yarn.lock? .

# Install deps
RUN yarn install --frozen-lockfile

### Build ###
FROM node:20-alpine as runner
WORKDIR /app

# Copy cached node_modules from deps
COPY --from=deps /app/node_modules /app/node_modules

# Copy app source code
COPY . /app

# Run the storefront in dev mode
ENTRYPOINT [ "yarn", "dev" ]