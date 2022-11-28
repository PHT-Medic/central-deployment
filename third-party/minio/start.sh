#!/bin/bash

function startMinio() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_MINIO}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service Minio is already running."
    else
        echo "Service Minio starting..."

        docker rm "${DOCKER_NAME_MINIO}" 2> /dev/null

         args=()

        if [[ "${MINIO_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 9000:9000)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_MINIO_NAME}":/data \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_MINIO}" \
            --env-file=./config/third-party/minio/.env \
             minio/minio:"${MINIO_VERSION}" server /data
    fi
}
