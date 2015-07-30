#!/bin/bash

DockerHost=${1:?"need to provide docker host"}

HostIP=${2?:"need to provide trial service host name"}

Discovery=${3:?"need to provide discovery service endpoint"}

docker run -d -p 80:80 --name try \
    -v ${PWD}/.cli:/cert \
    -e DOCKER_HOST=${DockerHost} \
    -e DOCKER_TLS_VERIFY=1 \
    -e DOCKER_CERT_PATH=/cert \
    -e TRIAL_SERVICE_ENDPOINT=${HostIP} \
    -e DISCOVERY_HOST=${Discovery}/hello_internet \
    macrodata/try-bigobject
