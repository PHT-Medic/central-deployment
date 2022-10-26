#!/bin/bash

source ./env.sh

#######################################
## Docker
#######################################

### Network
DOCKER_NETWORK_NAME="${DOCKER_NETWORK_NAME:-central}"

### Volumes
DOCKER_VOLUME_NAME_API="${DOCKER_VOLUME_NAME_API:-central-api}"
DOCKER_VOLUME_NAME_TRAIN_MANAGER="${DOCKER_VOLUME_NAME_TRAIN_MANAGER:-central-train-manager}"

DOCKER_VOLUME_DB_NAME="${DOCKER_VOLUME_DB_NAME:-central-db}"
DOCKER_VOLUME_MQ_NAME="${DOCKER_VOLUME_MQ_NAME:-central-mq}"
DOCKER_VOLUME_REDIS_NAME="${DOCKER_VOLUME_REDIS_NAME:-central-redis}"
DOCKER_VOLUME_VAULT_NAME="${DOCKER_VOLUME_VAULT_NAME:-central-vault}"

### Names
DOCKER_NAME_UI="${DOCKER_NAME_UI:-central-ui}"
DOCKER_NAME_API="${DOCKER_NAME_API:-central-api}"
DOCKER_NAME_REALTIME="${DOCKER_NAME_REALTIME:-central-realtime}"
DOCKER_NAME_TRAIN_MANAGER="${DOCKER_NAME_TRAIN_MANAGER:-central-train-manager}"

DOCKER_NAME_DB="${DOCKER_NAME_DB:-central-db}"
DOCKER_NAME_MQ="${DOCKER_NAME_MQ:-central-mq}"
DOCKER_NAME_REDIS="${DOCKER_NAME_REDIS:-central-redis}"
DOCKER_NAME_VAULT="${DOCKER_NAME_VAULT:-central-vault}"

### Path
DOCKER_CONTAINER_PROJECT_PATH="${DOCKER_CONTAINER_PROJECT_PATH:-"/usr/src/project"}"

## Image
DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:-latest}"

#######################################
## DB Service
#######################################

DB_ENABLED="${DB_ENABLED:-false}"
DB_PORTS_EXPOSED="${DB_PORTS_EXPOSED:-false}"
DB_VERSION="${DB_VERSION:-"8.0"}"
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

ENABLED_REALTIME="${ENABLED_REALTIME:-true}"
PORT_REALTIME="${PORT_REALTIME:-3001}"

ENABLED_API="${ENABLED_API:-true}"
PORT_API="${PORT_API:-3002}"

ENABLED_TRAIN_MANAGER="${ENABLED_TRAIN_MANAGER:-true}"
PORT_TRAIN_MANAGER="${PORT_TRAIN_MANAGER:-3003}"
