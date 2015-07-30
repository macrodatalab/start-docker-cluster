#!/bin/sh

DockerHost=${1:?"need docker host location"}

DiscoveryIP=${2:?"need discovery service location"}

docker run -d --name swarm-agent swarm join --addr ${DockerHost} ${DiscoveryIP}/hello_internet
