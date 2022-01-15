#!/bin/bash

function stopVault() {
    DOCKER_ID=$(docker ps -qf name="${DOCKER_NAME_VAULT}")
    if [[ -n "${DOCKER_ID}" ]]; then
        echo "Service Vault stopping..."
        docker stop "${DOCKER_ID}" && docker rm "${DOCKER_ID}"
    else
        echo "Service Vault is not running."
    fi
}
