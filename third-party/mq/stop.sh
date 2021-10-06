#!/bin/bash

function stopMQ() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_MQ}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service RabbitMQ stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service RabbitMQ is not running."
    fi
}
