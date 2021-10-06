#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"/../ || return

source ./config.sh

if [[ -z "${DOCKER_NAME_DB}" || -z "${DOCKER_NAME_MQ}" ]]; then
    echo "Config file was not loaded..."
    exit 1
fi

DOCKER_ID_DB=$(docker ps -qf name="${DOCKER_NAME_DB}")
if [[ -n "${DOCKER_ID_DB}" ]]; then
    echo "Service DB stopping..."
    docker stop "${DOCKER_ID_DB}" && docker rm "${DOCKER_ID_DB}"
else
    echo "Service DB is not running."
fi

DOCKER_ID_MQ=$(docker ps -qf name="${DOCKER_NAME_MQ}")
if [[ -n "${DOCKER_ID_MQ}" ]]; then
    echo "Service RabbitMQ stopping..."
    docker stop "${DOCKER_ID_MQ}" && docker rm "${DOCKER_ID_MQ}"
else
    echo "Service RabbitMQ is not running."
fi
