#!/bin/bash

source ./init.sh

function usageAndExit() {
    printf 'Usage:\n'
    printf '  <service>\n    Stop an application.\n'
    printf '  <service> <service>\n    Stop many applications\n'
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
    if [ -n "${DOCKER_ID_UI}" ]; then
        echo "stopping ui..."
        docker stop "${DOCKER_ID_UI}"
        docker rm "${DOCKER_ID_UI}"
    else
        echo "ui is not running."
    fi
fi

if [[ "${API}" == true ]]; then
    DOCKER_ID_API=$(docker ps -qf name=^"${DOCKER_NAME_API}"$)
    if [ -n "${DOCKER_ID_API}" ]; then
        echo "stopping api-server..."
        docker stop "${DOCKER_ID_API}"
        docker rm "${DOCKER_ID_API}"
    else
        echo "api-server is not running."
    fi
fi

if [[ "${REALTIME}" == true ]]; then
    DOCKER_ID_REALTIME=$(docker ps -qf name=^"${DOCKER_NAME_REALTIME}"$)
    if [ -n "${DOCKER_ID_REALTIME}" ]; then
        echo "stopping realtime-server..."
        docker stop "${DOCKER_ID_REALTIME}"
        docker rm "${DOCKER_ID_REALTIME}"
    else
        echo "realtime-server is not running."
    fi
fi

if [[ "${TRAIN_MANAGER}" == true ]]; then
    DOCKER_ID_TRAIN_MANAGER=$(docker ps -qf name=^"${DOCKER_NAME_TRAIN_MANAGER}"$)
    if [ -n "${DOCKER_ID_TRAIN_MANAGER}" ]; then
        echo "stopping train-manager..."
        docker stop "${DOCKER_ID_TRAIN_MANAGER}"
        docker rm "${DOCKER_ID_TRAIN_MANAGER}"
    else
        echo "train-manager is not running."
    fi
fi
