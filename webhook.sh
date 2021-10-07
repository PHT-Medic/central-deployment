#!/bin/bash

source ./config.sh

<<<<<<< HEAD
find ./webhook -type f -name "github.json" -exec sed -i'' -e "s/GITHUB_SECRET/${WEBHOOK_GITHUB_SECRET}/g" {} +
=======
find ./webhook -type f -name "github.json" -exec sed -i'' -e "s/GITHUB_SECRET/${GITHUB_SECRET}/g" {} +
>>>>>>> 756e1f97dabe2ac66153c2a43f487ca40ef77d6b

webhook -hooks ./webhook/github.json --verbose


