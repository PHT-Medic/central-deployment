#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startMQ() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_MQ}")
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service RabbitMQ is already running."
    else
        echo "Service RabbitMQ starting..."

        docker run \
            -d \
            -v "${DOCKER_VOLUME_MQ_NAME}":/bitnami \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_MQ}" \
            --env-file=./config/third-party/mq/.env \
             bitnami/rabbitmq:"${MQ_VERSION}"
    fi
}

