#!/bin/sh

docker network create --attachable -d macvlan  --subnet=10.2.0.0/16  --gateway=10.2.0.1  -o parent=eth0 inethi-bridge
cd ./performance-monitoring
./local_build.sh
