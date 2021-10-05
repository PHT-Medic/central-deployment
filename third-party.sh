#!/bin/bash

sh ./env.sh

if [ "$1" == "start" ]; then
    sh third-party/start.sh
elif [ "$1" == "stop" ]; then
    sh third-party/stop.sh
fi
