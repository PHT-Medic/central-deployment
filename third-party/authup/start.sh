#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startAuthup() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_AUTHUP}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service authup is already running."
    else
        echo "Service authup starting..."

        docker rm "${DOCKER_NAME_AUTHUP}" 2> /dev/null

        args=()

        if [[ "${AUTHUP_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 3010:3010)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_AUTHUP_NAME}":/usr/src/app/writable \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_AUTHUP}" \
            --env-file=./config/third-party/authup/.env \
             tada5hi/authup-server:"${AUTHUP_VERSION}"
    fi
}
