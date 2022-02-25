#!/bin/bash

source ./init.sh

# Pull image
docker pull "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}"

# Check db
DOCKER_DB_ID=$(docker ps -qf name=^"${DOCKER_NAME_DB}"$)
if [ -n "${DOCKER_DB_ID}" ]; then
    while ! docker exec \
         "${DOCKER_NAME_DB}" \
         mysqladmin \
        --user=root \
        --password="${DB_USER_PASSWORD}" \
        --host="${DOCKER_NAME_DB}" \
         ping --silent &> /dev/null ; do
        echo "Waiting for database connection..."
        sleep 2
    done
fi

# Stop
source ./stop.sh

# Upgrade
DOCKER_API_ID=$(docker ps -qf name=^"${DOCKER_NAME_API}"$)
if [ -n "${DOCKER_API_ID}" ]; then
    echo "API is already running and will be upgraded during runtime..."
    docker exec \
        "${DOCKER_API_ID}" \
        /bin/sh "${DOCKER_CONTAINER_PROJECT_PATH}"/entrypoint.sh cli upgrade
else
    echo "API is going to be upgraded..."
    docker run \
        -v "${DOCKER_VOLUME_NAME_API}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/api/writable \
        --network="${DOCKER_NETWORK_NAME}" \
        --env-file ./config/api/.env \
        "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" cli upgrade
fi

echo "Project is now up to date."

# Start
source ./start.sh
