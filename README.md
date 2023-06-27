# Central Deployment 🚀
This package requires `docker` to be installed on the host machine.

## Installation
```shell
git clone https://github.com/PHT-Medic/central-deployment
cd central-deployment
```

## Configuration

```shell
$ ./env.sh
```

This command will create environment files in the following directories:
- config/.env
- config/api/.env
- config/realtime/.env
- config/third-party/authup/.env
- config/train-manager/.env
- config/ui/.env

Change the values to your needs.

Don't forget to replace the placeholders with the actual values:
- `[APP_URL]`: Web address (e.g. https://app.example.com/)
- `[API_URL]`: Web address (e.g. https://app.example.com/api/)
- `[REALTIME_URL]`: Web address (e.g. https://app.example.com/)
- `[AUTHUP_API_URL]`: Web address of authup service (e.g. https://app.example.com/auth/)

The following values need to be changed before running the setup script!

**`config/api/.env`**
```dotenv
API_URL=[API_URL]
APP_URL=[APP_URL]
AUTHUP_API_URL=[AUTHUP_API_URL]
```

**`config/realtime/.env`**
```dotenv
AUTHUP_API_URL=[AUTHUP_API_URL]
```

**`config/third-party/authup/.env`**
```dotenv
AUTHORIZE_REDIRECT_URL=[APP_URL]
```

**`config/train-manager/.env`**
```dotenv
API_URL=[API_URL]
AUTHUP_API_URL=[AUTHUP_API_URL]
```

**`config/ui/.env`**
```dotenv
NUXT_PUBLIC_API_URL=[API_URL]
NUXT_PUBLIC_AUTHUP_API_URL=[AUTHUP_API_URL]
NUXT_PUBLIC_REALTIME_URL=[REALTIME_URL]
```

## Setup
To set up everything just run the following command:
```
$ ./setup.sh
```
This will download the docker image and run initial project setup 🔥.

## Usage
Setup & Start 🛫
```
$ ./third-party.sh start
$ ./start.sh
```
Stop 🛬
```
$ ./third-party.sh stop
$ ./stop.sh
```

Reset 🪂
```
$ ./reset.sh
```
