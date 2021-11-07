#!/bin/bash

sudo mkdir /mnt/data/traefik-nginx
sudo mkdir /mnt/data/traefik-nginx/html/
sudo cp -r ../splash/generic-splash/* /mnt/data/traefik-nginx/html/
sudo chmod -R 645 /mnt/data/traefik-nginx
docker-compose up -d
