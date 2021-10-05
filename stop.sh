#!/bin/bash

docker stop uiFrontend && docker rm $_
docker stop uiBackend && docker rm $_
