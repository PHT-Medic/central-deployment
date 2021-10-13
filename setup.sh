#!/bin/bash

source ./config.sh

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
    echo "DOCKER_IMAGE_NAME must be provided in .env file."
    exit 1
fi;

# Pull latest image
docker pull "${DOCKER_IMAGE_NAME}":latest

# Create docker network
DOCKER_NETWORK_ID=$(docker network ls -qf name=^"${DOCKER_NETWORK_NAME}"$)
if [ -z "${DOCKER_NETWORK_ID}" ]; then
    echo "Creating docker network..."
    docker network create "${DOCKER_NETWORK_NAME}"
fi

if [[ "${BACKEND_ENABLED}" == true ]]; then
    # Creating volumes
    DOCKER_VOLUME_CORE_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_CORE_NAME}"$)
    if [ -z "${DOCKER_VOLUME_CORE_ID}" ]; then
        echo "Creating docker core volume..."
        docker volume create "${DOCKER_VOLUME_CORE_NAME}"
    fi
fi

if [[ "${DB_ENABLED}" == true ]]; then
    DOCKER_VOLUME_DB_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_DB_NAME}"$)
    if [ -z "${DOCKER_VOLUME_DB_ID}" ]; then
        echo "Creating docker db volume..."
        docker volume create "${DOCKER_VOLUME_DB_NAME}"
    fi

    source ./third-party/db/start.sh
    startDB
fi

if [[ "${MQ_ENABLED}" == true ]]; then
    DOCKER_VOLUME_MQ_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_MQ_NAME}"$)
    if [ -z "${DOCKER_VOLUME_MQ_ID}" ]; then
        echo "Creating docker rabbit-mq volume..."
        docker volume create "${DOCKER_VOLUME_MQ_NAME}"
    fi

    source ./third-party/mq/start.sh
    startMQ
fi

if [[ "${DB_ENABLED}" == true ]]; then
    DOCKER_DB_ID=$(docker ps -qf name=^"${DOCKER_NAME_DB}"$)
    if [ -n "${DOCKER_DB_ID}" ]; then
        while ! docker exec \
             "${DOCKER_NAME_DB}" \
             mysqladmin \
            --user=root \
            --password="${DB_USER_PASSWORD}" \
            --host="${DOCKER_NAME_DB}" \
             ping --silent &> /dev/null ; do
            echo "Waiting for db connection..."
            sleep 2
        done
    fi
fi

if [[ "${BACKEND_ENABLED}" == true ]]; then
    docker run \
        -v "${DOCKER_VOLUME_CORE_NAME}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/writable \
        --network="${DOCKER_NETWORK_NAME}" \
        --env-file ./config/backend/.env \
        "${DOCKER_IMAGE_NAME}":latest cli setup
fi

echo "completed."
