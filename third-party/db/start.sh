#!/bin/bash

function startDB() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_DB}")
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service DB is already running."
    else
        echo "Service DB starting..."
        docker run \
            -d \
            -v "${DOCKER_VOLUME_DB_NAME}":/var/lib/mysql \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_DB}" \
            --env-file=./config/third-party/db/.env \
            mysql:"${DB_VERSION}"
    fi
}


