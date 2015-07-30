#!/bin/sh

DiscoveryIP=${1:?"need discovery service location"}

DockerHost=${2:?"need docker host location"}

docker run -d --name recycle \
    -v ${PWD}/.cli:/cert \
    -e DOCKER_HOST=${DockerHost} \
    -e DOCKER_TLS_VERIFY=1 \
    -e DOCKER_CERT_PATH=/cert \
    macrodata/agent watch ${DiscoveryIP}/hello_internet
