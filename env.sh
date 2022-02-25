
if [ ! -f ./config/.env ]; then
    cp ./config/example.env ./config/.env
fi

## Main
if [ -f ./config/.env ]; then
    source ./config/.env
fi

## Backend
if [[ "${ENABLED_API}" == true && ! -f ./config/api/.env ]]
then
    cp ./config/api/example.env ./config/api/.env
fi

## Realtime
if [[ "${REALTIME_ENABLED}" == true && ! -f ./config/realtime/.env ]]
then
    cp ./config/realtime/example.env ./config/realtime/.env
fi

## Result Service
if [[ "${ENABLED_RESULT}" == true && ! -f ./config/result/.env ]]
then
    cp ./config/result/example.env ./config/result/.env
fi

## Frontend
if [[ "${ENABLED_UI}" == true &&  ! -f ./config/ui/.env ]]
then
    cp ./config/ui/example.env ./config/ui/.env
fi

## DB
if [[ "${DB_ENABLED}" == true &&  ! -f ./config/third-party/db/.env ]]
then
    cp ./config/third-party/db/example.env ./config/third-party/db/.env
fi

## MQ
if [[ "${MQ_ENABLED}" == true &&  ! -f ./config/third-party/mq/.env ]]
then
    cp ./config/third-party/mq/example.env ./config/third-party/mq/.env
fi

## REDIS
if [[ "${REDIS_ENABLED}" == true &&  ! -f ./config/third-party/redis/.env ]]
then
    cp ./config/third-party/redis/example.env ./config/third-party/redis/.env
fi

## VAULT
if [[ "${VAULT_ENABLED}" == true &&  ! -f ./config/third-party/vault/.env ]]
then
    cp ./config/third-party/vault/example.env ./config/third-party/vault/.env
fi
