#!/bin/bash

source ./init.sh

function usageAndExit() {
    printf 'Usage:\n'
    printf '  <service>\n    Stop an application.\n'
    printf '  <service> <service>\n    Stop many applications\n'
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
    if [ -n "${DOCKER_ID_FRONTEND}" ]; then
        echo "stopping frontend..."
        docker stop "${DOCKER_ID_FRONTEND}"
        docker rm "${DOCKER_ID_FRONTEND}"
    else
        echo "frontend is not running."
    fi
fi

if [[ "${BACKEND}" == true ]]; then
    DOCKER_ID_BACKEND=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
    if [ -n "${DOCKER_ID_BACKEND}" ]; then
        echo "stopping resource-server..."
        docker stop "${DOCKER_ID_BACKEND}"
        docker rm "${DOCKER_ID_BACKEND}"
    else
        echo "resource-server is not running."
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

