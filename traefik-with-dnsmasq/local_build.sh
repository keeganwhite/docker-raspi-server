#!/bin/bash

sudo mkdir /mnt/data/dnsmasq
sudo mkdir /mnt/data/traefik
sudo cp -r ./dnsmasq/* /mnt/data/dnsmasq

docker-compose up -d
