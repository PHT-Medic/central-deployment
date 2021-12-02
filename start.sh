#!/bin/bash

source ./init.sh

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
    echo "DOCKER_IMAGE_NAME must be provided in .env file."
    exit 1
fi;

function usageAndExit() {
    printf 'Usage:\n'
    printf '  <service>\n    Start an application.\n'
    printf '  <service> <service>\n    Start many applications\n'
    exit 0
}

FRONTEND="${FRONTEND_ENABLED}"
BACKEND="${BACKEND_ENABLED}"

if [[ -n "$1" ]]; then
    FRONTEND=false
    BACKEND=false

    while [ "$1" != '' ]; do
        case "${1}" in
            frontend) FRONTEND=true && shift;;
            backend) BACKEND=true && shift;;
            *) echo "Unknown app: ${1}" && shift;;
        esac
    done

    if [[ -z "${FRONTEND}" && -z "${BACKEND}" ]]; then
        usageAndExit
    fi
fi

if [[ "${FRONTEND}" == true ]]; then
    DOCKER_ID_FRONTEND=$(docker ps -qf name=^"${DOCKER_NAME_FRONTEND}"$)
    if [ -z "${DOCKER_ID_FRONTEND}" ]; then
        echo "Starting frontend..."
        docker run \
            -d \
            -p "${FRONTEND_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/frontend/.env \
            --name="${DOCKER_NAME_FRONTEND}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" frontend start
    else
        echo "Frontend is already running."
    fi
fi

if [[ "${BACKEND}" == true ]]; then
    DOCKER_ID_BACKEND=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
    if [ -z "${DOCKER_ID_BACKEND}" ]; then
        echo "Starting backend..."
        docker run \
            -d \
            -v "${DOCKER_VOLUME_CORE_NAME}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/writable \
            -p "${BACKEND_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/backend/.env \
            --name="${DOCKER_NAME_BACKEND}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" backend start
    else
        echo "Backend is already running."
    fi
fi
