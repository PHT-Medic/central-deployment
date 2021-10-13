#!/bin/bash

source ./config.sh

if [[ -z "${DOCKER_NAME_FRONTEND}" || -z "${DOCKER_NAME_BACKEND}" ]]; then
    echo "Config file was not loaded..."
    exit 1
fi

function usageAndExit() {
    printf 'Usage:\n'
    printf '  <service>\n    Stop an application.\n'
    printf '  <service> <service>\n    Stop many applications\n'
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
    if [ -n "${DOCKER_ID_FRONTEND}" ]; then
        echo "Stopping frontend..."
        docker stop "${DOCKER_ID_FRONTEND}"
        docker rm "${DOCKER_ID_FRONTEND}"
    else
        echo "Frontend is not running."
    fi
fi

if [[ "${BACKEND}" == true ]]; then
    DOCKER_ID_BACKEND=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
    if [ -n "${DOCKER_ID_BACKEND}" ]; then
        echo "Stopping backend..."
        docker stop "${DOCKER_ID_BACKEND}"
        docker rm "${DOCKER_ID_BACKEND}"
    else
        echo "Backend is not running."
    fi
fi


