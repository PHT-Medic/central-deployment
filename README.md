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
- config/third-party/.env
- config/train-manager/.env
- config/ui/.env

Change the values to your needs.

The following values need to be changed before running the setup script!
- config/api/.env
  - `API_URL`
  - `APP_URL`
- config/realtime/.env
  - `API_URL`
- config/train-manager/.env
  - `API_URL`
- config/ui/.env
  - `API_URL`
  - `REALTIME_URL`

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
