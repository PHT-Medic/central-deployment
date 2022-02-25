#!/bin/bash

source ./config.sh

# Create docker network
DOCKER_NETWORK_ID=$(docker network ls -qf name=^"${DOCKER_NETWORK_NAME}"$)
if [ -z "${DOCKER_NETWORK_ID}" ]; then
    echo "Creating docker network..."
    docker network create "${DOCKER_NETWORK_NAME}"
else
    echo "Docker network already exists."
fi

if [[ "${ENABLED_API}" == true ]]; then
    # Creating volumes
    DOCKER_VOLUME_ID_API=$(docker volume ls -qf name=^"${DOCKER_VOLUME_NAME_API}"$)
    if [ -z "${DOCKER_VOLUME_ID_API}" ]; then
        echo "Creating docker core volume..."
        docker volume create "${DOCKER_VOLUME_NAME_API}"
    fi
fi

if [[ "${ENABLED_RESULT}" == true ]]; then
    # Creating volumes
    DOCKER_VOLUME_RESULT_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_NAME_RESULT}"$)
    if [ -z "${DOCKER_VOLUME_RESULT_ID}" ]; then
        echo "Creating docker result-service volume..."
        docker volume create "${DOCKER_VOLUME_NAME_API}"
    fi
fi

if [[ "${DB_ENABLED}" == true ]]; then
    DOCKER_VOLUME_DB_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_DB_NAME}"$)
    if [ -z "${DOCKER_VOLUME_DB_ID}" ]; then
        echo "Creating docker db volume..."
        docker volume create "${DOCKER_VOLUME_DB_NAME}"
    fi
fi

if [[ "${MQ_ENABLED}" == true ]]; then
    DOCKER_VOLUME_MQ_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_MQ_NAME}"$)
    if [ -z "${DOCKER_VOLUME_MQ_ID}" ]; then
        echo "Creating docker rabbit-mq volume..."
        docker volume create "${DOCKER_VOLUME_MQ_NAME}"
    fi
fi

if [[ "${VAULT_ENABLED}" == true ]]; then
    DOCKER_VOLUME_VAULT_ID=$(docker volume ls -qf name=^"${DOCKER_VOLUME_VAULT_NAME}"$)
    if [ -z "${DOCKER_VOLUME_VAULT_ID}" ]; then
        echo "Creating docker vault volume..."
        docker volume create "${DOCKER_VOLUME_VAULT_NAME}"
    fi
fi


