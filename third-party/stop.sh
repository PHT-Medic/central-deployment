#!/bin/bash

docker stop pht-ui-db && docker rm $_
docker stop pht-ui-rabbitmq && docker rm $_
