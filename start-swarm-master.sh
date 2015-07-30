#!/bin/sh

DiscoveryIP=${1:?"need discovery service location"}

ENABLE_TLS=${2:-"false"}

if ${ENABLE_TLS} = "false";
then
    TLS_OPTS="--tlsverify --tlscacert=/cert/ca.pem --tlscert=/cert/server-cert.pem --tlskey=/cert/server-key.pem"
else
    TLS_OPTS=""
fi

docker run -d --name swarm-master -p 3376:3376 \
    -v ${PWD}/.cert:/cert \
    swarm manage -H tcp://0.0.0.0:3376 ${TLS_OPTS} \
    --strategy spread \
    ${DiscoveryIP}/hello_internet
