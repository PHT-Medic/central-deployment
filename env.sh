
if [ ! -f ./config/.env ]; then
    copy ./config/example.env ./config/.env
fi

## Main
if [ -f ./config/.env ]; then
    source ./config/.env
fi

## Backend
if [[ "${BACKEND_ENABLED}" == true && ! -f ./config/backend/.env ]]
then
    cp ./config/backend/example.env ./config/backend/.env
fi

## Frontend
if [[ "${FRONTEND_ENABLED}" == true &&  ! -f ./config/frontend/.env ]]
then
    cp ./config/frontend/example.env ./config/frontend/.env
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
