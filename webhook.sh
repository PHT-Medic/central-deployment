#!/bin/bash

if [ -f .env ]
then
  # shellcheck disable=SC2046
  export $(cat .env | sed 's/#.*//g' | xargs)

  GITHUB_SECRET="${GITHUB_SECRET:=MY_SECRET}"

  find ./webhook -type f -name "github.json" -exec sed -i'' -e "s/GITHUB_SECRET/${GITHUB_SECRET}/g" {} +
fi

webhook -hooks ./webhook/github.json --verbose


