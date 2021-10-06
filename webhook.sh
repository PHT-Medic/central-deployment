#!/bin/bash

source ./config.sh

find ./webhook -type f -name "github.json" -exec sed -i'' -e "s/GITHUB_SECRET/${WEBHOOK_GITHUB_SECRET}/g" {} +

webhook -hooks ./webhook/github.json --verbose


