# UI Deployment 🚀
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

## Usage
Start 🛫 frontend, backend & third party services:
```
$ ./third-party.sh start
$ ./start.sh
```
Stop 🛬 frontend, backend & third party services:
```
$ ./third-party.sh stop
$ ./stop.sh
```
Update 💺images and service:
```
$ ./update.sh
```
Reset 🪂 service:
```
$ ./reset.sh
```
