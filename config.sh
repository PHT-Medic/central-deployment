#!/bin/bash

source ./env.sh

#######################################
## Docker
#######################################

### Network
DOCKER_NETWORK_NAME="${DOCKER_NETWORK_NAME:-ui}"

### Volumes
DOCKER_VOLUME_NAME_API="${DOCKER_VOLUME_NAME_API:-ui-core}"
DOCKER_VOLUME_NAME_RESULT="${DOCKER_VOLUME_NAME_RESULT:-ui-result-service}"

DOCKER_VOLUME_DB_NAME="${DOCKER_VOLUME_DB_NAME:-ui-db}"
DOCKER_VOLUME_MQ_NAME="${DOCKER_VOLUME_MQ_NAME:-ui-mq}"
DOCKER_VOLUME_REDIS_NAME="${DOCKER_VOLUME_REDIS_NAME:-ui-redis}"
DOCKER_VOLUME_VAULT_NAME="${DOCKER_VOLUME_VAULT_NAME:-ui-vault}"

### Names
DOCKER_NAME_UI="${DOCKER_NAME_UI:-ui-frontend}"
DOCKER_NAME_API="${DOCKER_NAME_API:-ui-backend}"
DOCKER_NAME_REALTIME="${DOCKER_NAME_REALTIME:-ui-realtime}"
DOCKER_NAME_RESULT="${DOCKER_NAME_RESULT:-ui-result-service}"

DOCKER_NAME_DB="${DOCKER_NAME_DB:-ui-db}"
DOCKER_NAME_MQ="${DOCKER_NAME_MQ:-ui-mq}"
DOCKER_NAME_REDIS="${DOCKER_NAME_REDIS:-ui-redis}"
DOCKER_NAME_VAULT="${DOCKER_NAME_VAULT:-ui-vault}"

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
## VAULT Service
#######################################

VAULT_ENABLED="${VAULT_ENABLED:-false}"
VAULT_PORTS_EXPOSED="${VAULT_PORTS_EXPOSED:-false}"
VAULT_VERSION="${VAULT_VERSION:-"1.9.2"}"

#######################################
## Project
#######################################

ENABLED_UI="${ENABLED_UI:-true}"
UI_PORT="${UI_PORT:-3000}"

REALTIME_ENABLED="${REALTIME_ENABLED:-true}"
REALTIME_PORT="${REALTIME_PORT:-3001}"

ENABLED_API="${ENABLED_API:-true}"
PORT_API="${PORT_API:-3002}"

ENABLED_RESULT="${ENABLED_RESULT:-true}"
PORT_RESULT="${PORT_RESULT:-3003}"
