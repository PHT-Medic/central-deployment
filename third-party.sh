#!/bin/bash

source config.sh

if [ "$1" == "start" ]; then
    sh third-party/start.sh "$2"
elif [ "$1" == "stop" ]; then
    sh third-party/stop.sh "$2"
fi
