#!/bin/bash

function stopRedis() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_REDIS}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service Redis stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service Redis is not running."
    fi
}
