#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"/../ || return

source ./config.sh

if [[ -z "${DOCKER_NAME_DB}" || -z "${DOCKER_NAME_MQ}" ]]; then
    echo "Config file was not loaded..."
    exit 1
fi

if [[ -z ${1} ]]; then
    DB_START=y
    RABBITMQ_START=y
fi

while [ "$1" != '' ]; do
  case "${1}" in
    db|database) DB_START=y && shift;;
    mq|rabbitmq) RABBITMQ_START=y && shift;;
    *) echo "Unknown parameter: ${1}" && shift;;
  esac
done

###

if [[ ${DB_START} == "y" ]]; then
    DOCKER_ID_DB=$(docker ps -qf name="${DOCKER_NAME_DB}")
    if [ -n "${DOCKER_ID_DB}" ]; then
        echo "Service DB is already running."
    else
        echo "Service DB starting..."
        docker run \
            -d \
            -v pht-ui-db:/var/lib/mysql \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_DB}" \
            --env MYSQL_ROOT_HOST=% \
            --env MYSQL_ROOT_PASSWORD="${DB_USER_PASSWORD}" \
             mysql:5.7
    fi
fi

if [[ ${RABBITMQ_START} == "y" ]]; then
    DOCKER_ID_MQ=$(docker ps -qf name="${DOCKER_NAME_MQ}")
    if [ -n "${DOCKER_ID_MQ}" ]; then
        echo "Service RabbitMQ is already running."
    else


        echo "Service RabbitMQ starting..."

        docker run \
            -d \
            -v pht-ui-rabbitmq:/bitnami \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_MQ}" \
            --env RABBITMQ_USERNAME="${MQ_USER_NAME}" \
            --env RABBITMQ_PASSWORD="${MQ_USER_PASSWORD}" \
             bitnami/rabbitmq:3.8-debian-10
    fi
fi
