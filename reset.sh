#!/bin/bash

sh ./stop.sh
sh ./third-party/stop.sh

# Create docker network
docker network rm pht-ui

# Creating volumes
docker volume rm pht-ui
docker volume rm pht-ui-db
docker volume rm pht-ui-rabbitmq
