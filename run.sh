#!/bin/bash

sh ./env.sh

FRONTEND_PORT="${FRONTEND_PORT:=3000}"
BACKEND_PORT="${BACKEND_PORT:=3002}"
IMAGE_NAME="${IMAGE_NAME:=ghcr.io/tada5hi/central-ui}"

docker pull ${IMAGE_NAME}:latest

docker stop uiFrontend && docker rm $_
docker stop uiBackend && docker rm $_

sh ./third-party/stop.sh
sh ./third-party/start.sh

docker run \
    -d \
    -p ${FRONTEND_PORT}:3000 \
    --restart=always \
    --network=pht-ui \
    --env-file .env.frontend \
    --name=uiFrontend \
    ${IMAGE_NAME}:latest frontend-start

docker run \
    -d \
    -p ${BACKEND_PORT}:3000 \
    --restart=always \
    --network=pht-ui \
    --env-file .env.backend \
    --name=uiBackend \
    ${IMAGE_NAME}:latest backend-start
