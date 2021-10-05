[![main](https://github.com/Tada5hi/pht-central-ui/actions/workflows/main.yml/badge.svg)](https://github.com/Tada5hi/pht-central-ui/actions/workflows/main.yml)
[![Known Vulnerabilities](https://snyk.io/test/github/Tada5hi/pht-central-ui/badge.svg)](https://snyk.io/test/github/Tada5hi/pht-central-ui)

# UI 🌅
This repository contains deployment utils to deploy the Central-UI of the Personal Health Train (PHT).

## Installation
This package requires `docker` & `webhook` to be installed on the host machine.

## Setup
Copy the `.env.exmaple` to `.env` modify the values to your needs.

To set up the project just run the following command:
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
```
$ ./run.sh
```
