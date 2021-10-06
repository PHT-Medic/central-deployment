# UI Deployment 🌅
This repository contains deployment utils to deploy a UI.

## Installation
This package requires `docker` & `webhook` to be installed on the host machine.

## Configuration
In the `config` directory copy all `.env` files and replace them without the **example** prefix in the name,
to configure frontend, backend and the third party services.
Change the values to your needs.

## Setup
To set up everything just run the following command:
```
$ ./setup.sh
```
This will download the docker image and run initial project setup 🔥.

### Webhook
The linux package `webhook` is required to run the configured webhooks.

To set up and register the GitHub webhook, run the following command:
```
$ ./webhook.sh
```

Now you are good to go and can either wait for the Webhook to
build and deploy the UI or manually start the Services.

## Usage
Start frontend, backend & third party services:
```
$ ./third-party.sh start
$ ./start.sh
```
Stop frontend, backend & third party services:
```
$ ./third-party.sh stop
$ ./stop.sh
```
Update images and service:
```
$ ./update.sh
```
