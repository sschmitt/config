#!/bin/bash

if [[ $# -ne 3 ]]; then
    echo "usage: $(basename $0) [client|server] <peer-hostname> <peer-ip>"
    exit 1
fi

mode="$1"
peer_hostname="$2"
peer_ip="$3"

local_hostname=$(hostname)
local_ip=$(ifconfig | grep 'inet addr' | grep -m 1 -v '127\.0\.0\.1' | tr ':' ' ' | awk '{print $3}')

if [[ "$mode" == "server" ]]; then
    client_hostname="$peer_hostname"
    client_ip="$peer_ip"
    server_hostname="$local_hostname"
    server_ip="$local_ip"
elif [[ "$mode" == "client" ]]; then
    client_hostname="$local_hostname"
    client_ip="$local_ip"
    server_hostname="$peer_hostname"
    server_ip="$peer_ip"
else
    echo 'First parameter must be "client" or "server"'
    exit 1
fi

sed -e "s|__CLIENT_HOSTNAME__|$client_hostname|g" \
    -e "s|__CLIENT_IP__|$client_ip|g" \
    -e "s|__SERVER_HOSTNAME__|$server_hostname|g" \
    -e "s|__SERVER_IP__|$server_ip|g" \
    .synergy.conf > ~/.synergy.conf
