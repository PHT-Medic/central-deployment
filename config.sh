#!/bin/bash

source ./env.sh

#######################################
## Docker
#######################################

### Network
DOCKER_NETWORK_NAME="${DOCKER_NETWORK_NAME:-ui}"

### Volumes
DOCKER_VOLUME_CORE_NAME="${DOCKER_VOLUME_CORE_NAME:-ui-core}"

DOCKER_VOLUME_DB_NAME="${DOCKER_VOLUME_DB_NAME:-ui-db}"
DOCKER_VOLUME_MQ_NAME="${DOCKER_VOLUME_MQ_NAME:-ui-mq}"
DOCKER_VOLUME_REDIS_NAME="${DOCKER_VOLUME_REDIS_NAME:-ui-redis}"

### Names
DOCKER_NAME_FRONTEND="${DOCKER_NAME_FRONTEND:-ui-frontend}"
DOCKER_NAME_BACKEND="${DOCKER_NAME_BACKEND:-ui-backend}"

DOCKER_NAME_DB="${DOCKER_NAME_DB:-ui-db}"
DOCKER_NAME_MQ="${DOCKER_NAME_MQ:-ui-mq}"

### Path
DOCKER_CONTAINER_PROJECT_PATH="${DOCKER_CONTAINER_PROJECT_PATH:-"/usr/src/app"}"

## Image

DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:-latest}"

#######################################
## DB Service
#######################################

DB_ENABLED="${DB_ENABLED:-false}"
DB_PORTS_EXPOSED="${DB_PORTS_EXPOSED:-false}"
DB_VERSION="${DB_VERSION:-"5.7"}"
DB_USER_PASSWORD="${DB_USER_PASSWORD:-start123}"

#######################################
## MQ Service
#######################################

MQ_ENABLED="${MQ_ENABLED:-false}"
MQ_PORTS_EXPOSED="${MQ_PORTS_EXPOSED:-false}"
MQ_VERSION="${MQ_VERSION:-"3.8-debian-10"}"
MQ_USER_NAME="${MQ_USER_NAME:-admin}"
MQ_USER_PASSWORD="${MQ_USER_PASSWORD:-start123}"

#######################################
## Redis Service
#######################################

REDIS_ENABLED="${REDIS_ENABLED:-false}"
REDIS_PORTS_EXPOSED="${REDIS_PORTS_EXPOSED:-false}"
REDIS_VERSION="${REDIS_VERSION:-"6.0-debian-10"}"

#######################################
## Project
#######################################

FRONTEND_ENABLED="${FRONTEND_ENABLED:-true}"
FRONTEND_PORT="${FRONTEND_PORT:-3000}"

BACKEND_ENABLED="${BACKEND_ENABLED:-true}"
BACKEND_PORT="${BACKEND_PORT:-3002}"
