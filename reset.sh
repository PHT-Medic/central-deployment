#!/bin/bash

source ./config.sh

sh ./stop.sh
sh ./third-party/stop.sh

# Drop docker network
DOCKER_NETWORK_ID=$(docker network ls -qf name=^"${DOCKER_NETWORK_NAME}"$)
if [ -n "${DOCKER_NETWORK_ID}" ]; then
    echo "Removing docker network..."
    docker network rm "${DOCKER_NETWORK_NAME}"
fi

# Drop volumes
DOCKER_VOLUME_CORE_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_CORE_NAME}"$)
if [ -n "${DOCKER_VOLUME_CORE_ID}" ]; then
    echo "Removing docker core volume..."
    docker volume rm "${DOCKER_VOLUME_CORE_NAME}"
fi

DOCKER_VOLUME_DB_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_DB_NAME}"$)
if [ -n "${DOCKER_VOLUME_DB_ID}" ]; then
    echo "Removing docker db volume..."
    docker volume rm "${DOCKER_VOLUME_DB_NAME}"
fi

DOCKER_VOLUME_MQ_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_MQ_NAME}"$)
if [ -n "${DOCKER_VOLUME_MQ_ID}" ]; then
    echo "Removing docker rabbit-mq volume..."
    docker volume rm "${DOCKER_VOLUME_MQ_NAME}"
fi
