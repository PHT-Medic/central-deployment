#!/bin/bash

source ./config.sh
source ./init.sh

# Pull latest image
docker pull "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}"

# Stop
source ./stop.sh

# Start
source ./start.sh
