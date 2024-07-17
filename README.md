# Medusa E-commerce with Docker

This project aims to demonstrate how to dockerize MedusaJS components. Check out my blog to discover more details. [Dockerize MedusaJS Components](https://immersedincode.io.vn/blog/dockerizing-medusajs-for-optimized-deployment/)

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/M4M0U28LL)

## Prerequisites
- [Docker & Docker Compose](https://www.docker.com/products/docker-desktop/)

- [Node](https://nodejs.org/en/download) or [NVM](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating). If your environment is Windows, you may like [nvm-windows](https://github.com/coreybutler/nvm-windows?tab=readme-ov-file)

- [Git](https://git-scm.com/downloads)

- [Medusa CLI](https://docs.medusajs.com/cli/reference)

## Quickstart

Run `start-up.sh` to reproduce the deployment steps for the development environments.

```bash
sh start-up.sh

# or 

./start-up.sh
```

Run `start-up.prod.sh` to reproduce the deployment steps for the production environments.

```bash
sh start-up.prod.sh

# or 

./start-up.prod.sh
```

## Build Docker image

Explore `Makefile` to see the command.

- Build Backend image
    ```bash
    # development
    docker build -t <your-image-name> ./backend

    # production
    docker build -t <your-image-name>:prod ./backend -f ./backend/Dockerfile.prod
    ```

- Build Admin Panel image
    ```bash
    # production only
    docker build -t <your-image-name>:prod ./backend -f ./backend/Dockerfile.admin.prod
    ```

- Build Storefront image
    ```bash
    # development
    docker build -t <your-image-name> ./storefront

    # production
    docker build -t <your-image-name>:prod ./storefront -f ./storefront/Dockerfile.prod
    ```
    
