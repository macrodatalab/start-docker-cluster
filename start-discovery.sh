#!/bin/sh

HostIP=${1:?"need outbound host IP"}

shift 1
VolumesFrom="$@"

docker run -d -p 4001:4001 -p 2380:2380 -p 2379:2379 --name discovery \
    -v /usr/share/ca-certificates/:/etc/ssl/certs \
    -v /data ${VolumesFrom} \
    quay.io/coreos/etcd \
    -name etcd0 \
    -data-dir /data \
    -advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
    -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
    -initial-advertise-peer-urls http://${HostIP}:2380 \
    -listen-peer-urls http://0.0.0.0:2380 \
    -initial-cluster-token etcd-cluster-1 \
    -initial-cluster etcd0=http://${HostIP}:2380
