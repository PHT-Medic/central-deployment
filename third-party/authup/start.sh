#!/bin/bash

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "${SCRIPT_DIR}"/../ || return
# source ./config.sh

function startAuthup() {
    DOCKER_ID=$(docker ps -qf name=^"${DOCKER_NAME_AUTHUP}"$)
    if [ -n "${DOCKER_ID}" ]; then
        echo "Service authup is already running."
    else
        if [[ "${DB_ENABLED}" == true ]]; then
            DOCKER_DB_ID=$(docker ps -qf name=^"${DOCKER_NAME_DB}"$)
            if [ -n "${DOCKER_DB_ID}" ]; then
                while ! docker exec \
                     "${DOCKER_NAME_DB}" \
                     mysqladmin \
                    --user=root \
                    --password="${DB_USER_PASSWORD}" \
                    --host="${DOCKER_NAME_DB}" \
                     ping --silent &> /dev/null ; do
                    echo "Waiting for db connection..."
                    sleep 2
                done
            fi
        fi

        echo "Service authup starting..."

        docker rm "${DOCKER_NAME_AUTHUP}" 2> /dev/null

        args=()

        if [[ "${AUTHUP_PORTS_EXPOSED}" == true ]]; then
           args+=(-p 3010:3010)
        fi

        docker run \
            -d \
            -v "${DOCKER_VOLUME_AUTHUP_NAME}":/usr/src/app/writable \
            "${args[@]}" \
            --network "${DOCKER_NETWORK_NAME}" \
            --name "${DOCKER_NAME_AUTHUP}" \
            --env-file=./config/third-party/authup/.env \
             tada5hi/authup-server:"${AUTHUP_VERSION}"
    fi
}
