#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startVault() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_VAULT}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service Vault is already running."
    else
        echo "Service Vault starting..."

        docker rm "${DOCKER_NAME_VAULT}" 2> /dev/null

        args=()

        if [[ "${VAULT_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 8090:8090)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_VAULT_NAME}":/vault/file \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_VAULT}" \
            --env-file=./config/third-party/vault/.env \
             vault:"${VAULT_VERSION}"
    fi
}
