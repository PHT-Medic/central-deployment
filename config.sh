#!/bin/bash

source ./env.sh

#######################################
## Docker
#######################################

### Network
DOCKER_NETWORK_NAME=pht-ui

### Volumes
DOCKER_VOLUME_CORE_NAME=pht-ui-core

DOCKER_VOLUME_DB_NAME=pht-ui-db
DOCKER_VOLUME_MQ_NAME=pht-ui-rabbitmq

### Names
DOCKER_NAME_FRONTEND=pht-ui-frontend
DOCKER_NAME_BACKEND=pht-ui-backend

DOCKER_NAME_DB=pht-ui-db
DOCKER_NAME_MQ=pht-ui-rabbitmq

### Image
DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME:=ghcr.io/tada5hi/central-ui}"

### Path
DOCKER_CONTAINER_PROJECT_PATH=/usr/src/project/

#######################################
## DB Service
#######################################

DB_USER_PASSWORD="${DB_USER_PASSWORD:=start123}"

#######################################
## MQ Service
#######################################

MQ_USER_NAME="${MQ_USER_NAME:=admin}"
MQ_USER_PASSWORD="${MQ_USER_PASSWORD:=start123}"

#######################################
## Project
#######################################

FRONTEND_PORT="${FRONTEND_PORT:=3000}"
BACKEND_PORT="${BACKEND_PORT:=3002}"
