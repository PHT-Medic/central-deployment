#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startRedis() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_REDIS}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service Redis is already running."
    else
        echo "Service Redis starting..."

        docker rm "${DOCKER_NAME_REDIS}" 2> /dev/null

        args=()

        if [[ "${REDIS_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 6379:6379)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_NAME_REDIS}":/bitnami \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_REDIS}" \
            --env-file=./config/third-party/redis/.env \
             docker.io/bitnami/redis:"${REDIS_VERSION}"
    fi
}
