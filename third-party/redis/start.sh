#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startRedis() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_REDIS}")
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service Redis is already running."
    else
        echo "Service Redis starting..."

        docker run \
            -d \
            -v "${DOCKER_VOLUME_NAME_REDIS}":/bitnami \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_REDIS}" \
            --env-file=./config/third-party/redis/.env \
             docker.io/bitnami/redis:"${REDIS_VERSION}"
    fi
}

