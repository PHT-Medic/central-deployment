#!/bin/bash

sh ./env.sh

# Image path
IMAGE_NAME="${IMAGE_NAME:=ghcr.io/tada5hi/central-ui}"

# Pull latest image
docker pull ${IMAGE_NAME}:latest

# Create docker network
docker network create pht-ui

# Creating volumes
docker volume create pht-ui
docker volume create pht-ui-db
docker volume create pht-ui-rabbitmq

# Start third-party services
sh ./third-party/run.sh

HEALTH_DB_NAME=pht-u-db-health
docker run \
    --name ${HEALTH_DB_NAME} \
    --health-cmd='mysqladmin ping --silent' \
    -d \
    mysql:5.7

while ! docker exec \
     pht-ui-db \
     mysqladmin \
    --user=root \
    --password=root \
    --host=pht-ui-db \
     ping --silent &> /dev/null ; do
    echo "Waiting for database connection..."
    sleep 2
done

docker run \
    -v pht-ui:/usr/src/project/packages/backend/writable \
    --network=pht-ui \
    --env-file ./.env.backend \
    ${IMAGE_NAME}:latest setup
