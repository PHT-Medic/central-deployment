#!/bin/bash

function stopAuthup() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_AUTHUP}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service authup stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service authup is not running."
    fi
}
