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
RESULT="${ENABLED_RESULT}"

if [[ -n "$1" ]]; then
    UI=false
    REALTIME=false
    API=false
    RESULT=false

    while [ "$1" != '' ]; do
        case "${1}" in
            ui) UI=true && shift;;
            realtime) REALTIME=true && shift;;
            api) API=true && shift;;
            result) RESULT=true && shift;;
            *) echo "Unknown app: ${1}" && shift;;
        esac
    done

    if [[ -z "${UI}" && -z "${API}" && -z "${REALTIME}" && -z "${RESULT}" ]]; then
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

if [[ "${RESULT}" == true ]]; then
    DOCKER_ID_RESULT=$(docker ps -qf name=^"${DOCKER_NAME_RESULT}"$)
    if [ -n "${DOCKER_ID_RESULT}" ]; then
        echo "stopping result-server..."
        docker stop "${DOCKER_ID_RESULT}"
        docker rm "${DOCKER_ID_RESULT}"
    else
        echo "result-server is not running."
    fi
fi
