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
DOCKER_BACKEND_ID=$(docker ps -qf name=^"${DOCKER_NAME_BACKEND}"$)
if [ -n "${DOCKER_BACKEND_ID}" ]; then
    echo "Backend is already running and will be upgraded during runtime..."
    docker exec \
        "${DOCKER_BACKEND_ID}" \
        /bin/sh "${DOCKER_CONTAINER_PROJECT_PATH}"/entrypoint.sh cli upgrade
else
    echo "Backend is going to be upgraded..."
    docker run \
        -v "${DOCKER_VOLUME_CORE_NAME}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/writable \
        --network="${DOCKER_NETWORK_NAME}" \
        --env-file ./config/backend/.env \
        "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" cli upgrade
fi

echo "Project is now up to date."

# Start
source ./start.sh