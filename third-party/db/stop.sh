#!/bin/bash

function stopDB() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_DB}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service DB stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service DB is not running."
    fi
}
