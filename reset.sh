#!/bin/bash

source ./config.sh

sh ./stop.sh
sh ./third-party.sh stop

# Drop docker network
DOCKER_NETWORK_ID=$(docker network ls -qf name=^"${DOCKER_NETWORK_NAME}"$)
if [ -n "${DOCKER_NETWORK_ID}" ]; then
    echo "Removing docker network..."
    docker network rm "${DOCKER_NETWORK_NAME}"
fi

# Drop volumes
DOCKER_VOLUME_ID_API=$(docker volume ls -qf name=^"${DOCKER_VOLUME_NAME_API}"$)
if [ -n "${DOCKER_VOLUME_ID_API}" ]; then
    echo "Removing docker core volume..."
    docker volume rm "${DOCKER_VOLUME_NAME_API}"
fi

DOCKER_VOLUME_ID_TRAIN_MANAGER=$(docker volume ls -qf name=^"${DOCKER_VOLUME_NAME_TRAIN_MANAGER}"$)
if [ -z "${DOCKER_VOLUME_ID_TRAIN_MANAGER}" ]; then
    echo "Removing docker train-manager volume..."
    docker volume rm "${DOCKER_VOLUME_ID_TRAIN_MANAGER}"
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
