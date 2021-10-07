#!/bin/bash

source ./config.sh

# Pull latest image
docker pull "${DOCKER_IMAGE_NAME}":latest

# Start third-party services
sh ./third-party/start.sh

# Check db
DOCKER_DB_ID=$(docker ps -qf name="${DOCKER_NAME_DB}")
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

# Upgrade
DOCKER_BACKEND_ID=$(docker ps -qf name="${DOCKER_NAME_BACKEND}")
if [ -n "${DOCKER_BACKEND_ID}" ]; then
    echo "Backend is already running and will be upgraded during runtime..."
    docker exec \
        "${DOCKER_BACKEND_ID}" \
        /bin/bash "${DOCKER_CONTAINER_PROJECT_PATH}"/entrypoint.sh upgrade
else
    echo "Backend is going to be upgraded..."
    docker run \
        -v "${DOCKER_VOLUME_CORE_NAME}":"${DOCKER_CONTAINER_PROJECT_PATH}"packages/backend/writable \
        --network="${DOCKER_NETWORK_NAME}" \
        --env-file ./.env.backend \
        "${DOCKER_IMAGE_NAME}":latest upgrade
fi

echo "Project is now up to date."
