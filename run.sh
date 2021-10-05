#!/bin/bash

sh ./env.sh

FRONTEND_PORT="${VARIABLE:=3000}"
BACKEND_PORT="${VARIABLE:=3002}"
IMAGE_NAME="${VARIABLE:=ghcr.io/tada5hi/central-ui}"

docker pull ${IMAGE_NAME}:latest
docker stop uiFrontend
docker stop uiBackend

docker run -d -p ${FRONTEND_PORT}:3000 --restart --env-file ./env.frontend --name=uiFrontend ${IMAGE_NAME}:latest frontend-start
docker run -d -p ${BACKEND_PORT}:3000 --restart --env-file ./env.backend --name=uiBackend ${IMAGE_NAME}:latest backend-start
