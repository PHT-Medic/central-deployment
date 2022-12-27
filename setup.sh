#!/bin/bash

source ./init.sh

sh ./third-party.sh start

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
    echo "DOCKER_IMAGE_NAME must be provided in .env file."
    exit 1
fi;

# Pull image
docker pull "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"

echo "Setup completed."
