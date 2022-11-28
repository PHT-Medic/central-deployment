#!/bin/bash

function stopMinio() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_MINIO}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service Minio stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service Minio is not running."
    fi
}
