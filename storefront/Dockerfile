### Dependencies ###
FROM node:20-alpine as deps
WORKDIR /app/

# Copy storefront package.json and yarn.lock from /storefront
COPY ./package*.json .
COPY ./yarn.lock? .

# Install deps and launch patch-package
RUN yarn install --frozen-lockfile

### Build ###
FROM node:20-alpine as builder
WORKDIR /app

# Copy cached root and package node_modules from deps
COPY --from=deps /app/node_modules /app/node_modules

# Copy app source code
COPY . /app

# Build the app
RUN yarn build

# Run the builded app
ENTRYPOINT [ "yarn", "start" ]