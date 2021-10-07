#!/bin/bash

source ./config.sh

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
REDIS_SERVICE="${REDIS_ENABLED}"

if [[ -n "$1" ]]; then
    DB_SERVICE=false
    MQ_SERVICE=false
    REDIS_SERVICE=false

    while [ "$1" != '' ]; do
        case "${1}" in
            db) DB_SERVICE=true && shift;;
            mq) MQ_SERVICE=true && shift;;
            redis) REDIS_SERVICE=true && shift;;
            *) echo "Unknown service: ${1}" && shift;;
        esac
    done

    if [[ -z "${DB_SERVICE}" && -z "${MQ_SERVICE}" && -z "${REDIS_SERVICE}" ]]; then
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

if [[ "${REDIS_SERVICE}" == true ]]; then
    case "${COMMAND}" in
        start) source ./third-party/redis/start.sh && startRedis;;
        stop) source ./third-party/redis/stop.sh && stopRedis;;
    esac
fi
