#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startMQ() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_MQ}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service RabbitMQ is already running."
    else
        echo "Service RabbitMQ starting..."

        docker rm "${DOCKER_NAME_MQ}" 2> /dev/null

         args=()

        if [[ "${MQ_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 5672:5672)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_MQ_NAME}":/bitnami \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_MQ}" \
            --env-file=./config/third-party/mq/.env \
             bitnami/rabbitmq:"${MQ_VERSION}"
    fi
}
