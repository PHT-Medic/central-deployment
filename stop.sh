#!/bin/bash

source ./config.sh

if [[ -z "${DOCKER_NAME_FRONTEND}" || -z "${DOCKER_NAME_BACKEND}" ]]; then
    echo "Config file was not loaded..."
    exit 1
fi

DOCKER_ID_FRONTEND=$(docker ps -qf name=^"${DOCKER_NAME_FRONTEND}"$)
if [ -n "${DOCKER_ID_FRONTEND}" ]; then
    echo "Stopping frontend..."
    docker stop "${DOCKER_ID_FRONTEND}"
    docker rm "${DOCKER_ID_FRONTEND}"
else
    echo "Frontend is not running."
fi

DOCKER_ID_BACKEND=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
if [ -n "${DOCKER_ID_BACKEND}" ]; then
    echo "Stopping backend..."
    docker stop "${DOCKER_ID_BACKEND}"
    docker rm "${DOCKER_ID_BACKEND}"
else
    echo "Backend is not running."
fi


