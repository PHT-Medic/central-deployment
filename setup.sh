#!/bin/bash

sh ./env.sh

IMAGE_NAME="${VARIABLE:=ghcr.io/tada5hi/central-ui}"

docker pull ${IMAGE_NAME}:latest

docker network create pht-network
docker volume craete pht-central-ui-db
docker volume create pht-central-ui-rabbitmq

docker run --env-file ./.env.backend ${IMAGE_NAME}:latest setup

