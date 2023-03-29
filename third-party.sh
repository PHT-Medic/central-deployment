#!/bin/bash

source ./init.sh

COMMAND=""

case "${1}" in
    start) COMMAND=start;;
    stop) COMMAND=stop;;
    reset) COMMAND=reset;;
    *) echo "Unknown command: ${1}";;
esac

function usageAndExit() {
    printf 'Usage:\n'
    printf '  start <service>\n    Start one or all third-party services\n'
    printf '  stop <service>\n    Stop one or all third-party services\n'
    printf '  reset <service>\n    Reset one or all third-party services\n\n'
    exit 0
}

if [[ -z "${COMMAND}" ]]; then
  usageAndExit
fi

shift

DB_SERVICE="${DB_ENABLED}"
MQ_SERVICE="${MQ_ENABLED}"
MINIO_SERVICE="${MINIO_ENABLED}"
REDIS_SERVICE="${REDIS_ENABLED}"
VAULT_SERVICE="${VAULT_ENABLED}"
AUTHUP_SERVICE="${AUTHUP_ENABLED}"

if [[ -n "$1" ]]; then
    DB_SERVICE=false
    MQ_SERVICE=false
    MINIO_SERVICE=false
    REDIS_SERVICE=false
    VAULT_SERVICE=false
    AUTHUP_SERVICE=false

    while [ "$1" != '' ]; do
        case "${1}" in
            db) DB_SERVICE=true && shift;;
            mq) MQ_SERVICE=true && shift;;
            minio) MINIO_SERVICE=true && shift;;
            redis) REDIS_SERVICE=true && shift;;
            vault) VAULT_SERVICE=true && shift;;
            authup) AUTHUP_SERVICE=true && shift;;
            *) echo "Unknown service: ${1}" && shift;;
        esac
    done

    if [[ -z "${AUTHUP_SERVICE}" && -z "${DB_SERVICE}" && -z "${MQ_SERVICE}" && -z "${MINIO_SERVICE}" && -z "${REDIS_SERVICE}" && -z "${VAULT_SERVICE}" ]]; then
        usageAndExit
    fi
fi

if [[ "${DB_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/db/start.sh && startDB;;
        stop) source ./third-party/db/stop.sh && stopDB;;
    esac
fi

if [[ "${MQ_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/mq/start.sh && startMQ;;
        stop) source ./third-party/mq/stop.sh && stopMQ;;
    esac
fi

if [[ "${MINIO_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/minio/start.sh && startMinio;;
        stop) source ./third-party/minio/stop.sh && stopMinio;;
    esac
fi

if [[ "${REDIS_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/redis/start.sh && startRedis;;
        stop) source ./third-party/redis/stop.sh && stopRedis;;
    esac
fi

if [[ "${VAULT_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/vault/start.sh && startVault;;
        stop) source ./third-party/vault/stop.sh && stopVault;;
    esac
fi

if [[ "${AUTHUP_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/authup/start.sh && startAuthup;;
        stop) source ./third-party/authup/stop.sh && stopAuthup;;
    esac
fi
