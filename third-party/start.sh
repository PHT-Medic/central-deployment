#!/bin/bash

RABBITMQ_USER_NAME="${RABBITMQ_USER_NAME:=admin}"
RABBITMQ_USER_PASSWORD="${RABBITMQ_USER_PASSWORD:=start123}"

docker run \
    -d \
    -v pht-ui-rabbitmq:/bitnami \
    --network pht-ui \
    --name pht-ui-rabbitmq \
    --env RABBITMQ_USERNAME=${RABBITMQ_USER_NAME} \
    --env RABBITMQ_PASSWORD=${RABBITMQ_USER_PASSWORD} \
     bitnami/rabbitmq:3.8-debian-10

MYSQL_USER_PASSWORD="${MYSQL_USER_PASSWORD:=start123}"

docker run \
    -d \
    -v pht-ui-db:/var/lib/mysql \
    --network pht-ui \
    --name pht-ui-db \
    --env MYSQL_ROOT_HOST="%" \
    --env MYSQL_ROOT_PASSWORD=${MYSQL_USER_PASSWORD} \
     mysql:5.7
