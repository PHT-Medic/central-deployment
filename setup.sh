#!/bin/bash

source ./config.sh

# Pull latest image
docker pull "${DOCKER_IMAGE_NAME}":latest

# Create docker network
DOCKER_NETWORK_ID=$(docker network ls -qf name="${DOCKER_NETWORK_NAME}")
if [ -z "${DOCKER_NETWORK_ID}" ]; then
    echo "Creating docker network..."
    docker network create "${DOCKER_NETWORK_NAME}"
fi

# Creating volumes
DOCKER_VOLUME_CORE_ID=$(docker volume ls -qf name="${DOCKER_VOLUME_CORE_NAME}")
if [ -z "${DOCKER_VOLUME_CORE_ID}" ]; then
    echo "Creating docker core volume..."
    docker volume create "${DOCKER_VOLUME_CORE_NAME}"
fi

DOCKER_VOLUME_DB_ID=$(docker volume ls -qf name="${DOCKER_VOLUME_DB_NAME}")
if [ -z "${DOCKER_VOLUME_DB_ID}" ]; then
    echo "Creating docker db volume..."
    docker volume create "${DOCKER_VOLUME_DB_NAME}"
fi

DOCKER_VOLUME_MQ_ID=$(docker volume ls -qf name="${DOCKER_VOLUME_MQ_NAME}")

if [ -z "${DOCKER_VOLUME_MQ_ID}" ]; then
    echo "Creating docker rabbit-mq volume..."
    docker volume create "${DOCKER_VOLUME_MQ_NAME}"
fi

# Start third-party services
sh ./third-party/start.sh

DOCKER_DB_ID=$(docker ps -qf name="${DOCKER_NAME_DB}")
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

docker run \
    -v "${DOCKER_VOLUME_CORE_NAME}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/writable \
    --network="${DOCKER_NETWORK_NAME}" \
    --env-file ./.env.backend \
    "${DOCKER_IMAGE_NAME}":latest setup

echo "Setup complete."
