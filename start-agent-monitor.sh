#!/bin/sh

HostIP=${1:?"need to declare host public IP"}

DiscoveryIP=${2:?"need discovery service location"}

DockerHost=${3:?"need docker host location"}

TTL=${4:-"24h"}

docker run -d --name agent \
    -v ${PWD}/.cli:/cert \
    -e DOCKER_HOST=${DockerHost} \
    -e DOCKER_TLS_VERIFY=1 \
    -e DOCKER_CERT_PATH=/cert \
    macrodata/agent \
    monitor --addr ${HostIP} --filter '{image: [macrodata/bigobject-dev, "macrodata/bigobject-dev:demo"]}' --ttl ${TTL} ${DiscoveryIP}/hello_internet
