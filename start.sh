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

UI="${ENABLED_UI}"
REALTIME="${ENABLED_REALTIME}"
API="${ENABLED_API}"
TRAIN_MANAGER="${ENABLED_TRAIN_MANAGER}"

if [[ -n "$1" ]]; then
    UI=false
    REALTIME=false
    API=false
    TRAIN_MANAGER=false

    while [ "$1" != '' ]; do
        case "${1}" in
            ui) UI=true && shift;;
            realtime) REALTIME=true && shift;;
            api) API=true && shift;;
            train-manager) TRAIN_MANAGER=true && shift;;
            *) echo "Unknown app: ${1}" && shift;;
        esac
    done

    if [[ -z "${UI}" && -z "${API}" && -z "${REALTIME}" && -z "${TRAIN_MANAGER}" ]]; then
        usageAndExit
    fi
fi

if [[ "${UI}" == true ]]; then
    DOCKER_ID_UI=$(docker ps -qf name=^"${DOCKER_NAME_UI}"$)
    if [ -z "${DOCKER_ID_UI}" ]; then
        echo "starting ui..."
        docker run \
            -d \
            -p "${UI_PORT}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/ui/.env \
            --name="${DOCKER_NAME_UI}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" ui start
    else
        echo "ui is already running."
    fi
fi

if [[ "${API}" == true ]]; then
    DOCKER_ID_API=$(docker ps -qf name=^"${DOCKER_NAME_API}"$)
    if [ -z "${DOCKER_ID_API}" ]; then
        echo "starting api-server..."
        docker run \
            -d \
            -v "${DOCKER_VOLUME_NAME_API}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/api/writable \
            -p "${PORT_API}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/api/.env \
            --name="${DOCKER_NAME_API}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" api start
    else
        echo "api-server is already running."
    fi
fi

if [[ "${REALTIME}" == true ]]; then
    DOCKER_ID_REALTIME=$(docker ps -qf name=^"${DOCKER_NAME_REALTIME}"$)
    if [ -z "${DOCKER_ID_REALTIME}" ]; then
        echo "starting realtime-server..."
        docker run \
            -d \
            -p "${PORT_REALTIME}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/realtime/.env \
            --name="${DOCKER_NAME_REALTIME}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" realtime start
    else
        echo "realtime-server is already running."
    fi
fi

if [[ "${TRAIN_MANAGER}" == true ]]; then
    DOCKER_ID_TRAIN_MANAGER=$(docker ps -qf name=^"${DOCKER_NAME_TRAIN_MANAGER}"$)
    if [ -z "${DOCKER_ID_TRAIN_MANAGER}" ]; then
        echo "starting train-manager..."
        docker run \
            -d \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v "${DOCKER_VOLUME_NAME_TRAIN_MANAGER}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/train-manager/writable \
            -p "${PORT_TRAIN_MANAGER}":3000 \
            --restart=always \
            --network="${DOCKER_NETWORK_NAME}" \
            --env-file ./config/train-manager/.env \
            --name="${DOCKER_NAME_TRAIN_MANAGER}" \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" train-manager start
    else
        echo "train-manager is already running."
    fi
fi
