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
REALTIME="${REALTIME_ENABLED}"
BACKEND="${BACKEND_ENABLED}"

if [[ -n "$1" ]]; then
    FRONTEND=false
    REALTIME=false
    BACKEND=false

    while [ "$1" != '' ]; do
        case "${1}" in
            frontend) FRONTEND=true && shift;;
            realtime) REALTIME=true && shift;;
            backend) BACKEND=true && shift;;
            *) echo "Unknown app: ${1}" && shift;;
        esac
    done

    if [[ -z "${FRONTEND}" && -z "${BACKEND}" && -z "${REALTIME}" ]]; then
        usageAndExit
    fi
fi

if [[ "${FRONTEND}" == true ]]; then
    DOCKER_ID_FRONTEND=$(docker ps -qf name=^"${DOCKER_NAME_FRONTEND}"$)
    if [ -z "${DOCKER_ID_FRONTEND}" ]; then
        echo "starting frontend..."
        docker run \
            -d \
            -p "${FRONTEND_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/frontend/.env \
            --name="${DOCKER_NAME_FRONTEND}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" frontend start
    else
        echo "frontend is already running."
    fi
fi

if [[ "${BACKEND}" == true ]]; then
    DOCKER_ID_BACKEND=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
    if [ -z "${DOCKER_ID_BACKEND}" ]; then
        echo "starting resource-server..."
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
        echo "resource-server is already running."
    fi
fi

if [[ "${REALTIME}" == true ]]; then
    DOCKER_ID_REALTIME=$(docker ps -qf name=^"${DOCKER_NAME_REALTIME}"$)
    if [ -z "${DOCKER_ID_REALTIME}" ]; then
        echo "starting realtime-server..."
        docker run \
            -d \
            -p "${REALTIME_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/realtime/.env \
            --name="${DOCKER_NAME_REALTIME}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" realtime start
    else
        echo "realtime-server is already running."
    fi
fi
