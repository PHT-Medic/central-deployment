#!/bin/bash

source ./config.sh

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
    echo "DOCKER_IMAGE_NAME must be provided in .env file."
    exit 1
fi;

docker pull "${DOCKER_IMAGE_NAME}":latest

if [[ "${FRONTEND_ENABLED}" == true ]]; then
    DOCKER_ID_FRONTEND=$(docker ps -qf name="${DOCKER_NAME_FRONTEND}")
    if [ -z "${DOCKER_ID_FRONTEND}" ]; then
        echo "Starting frontend..."
        docker run \
            -d \
            -p "${FRONTEND_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file .env.frontend \
            --name="${DOCKER_NAME_FRONTEND}" \
            "${DOCKER_IMAGE_NAME}":latest frontend start
    else
        echo "Frontend is already running."
    fi
fi

if [[ "${BACKEND_ENABLED}" == true ]]; then
    DOCKER_ID_BACKEND=$(docker ps -qf name="${DOCKER_NAME_BACKEND}")
    if [ -z "${DOCKER_ID_BACKEND}" ]; then
        echo "Starting backend..."
        docker run \
            -d \
            -p "${BACKEND_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file .env.backend \
            --name="${DOCKER_NAME_BACKEND}" \
            "${DOCKER_IMAGE_NAME}":latest backend start
    else
        echo "Backend is already running."
    fi
fi
