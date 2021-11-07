#!/bin/bash

sudo mkdir /mnt/data/moodle
sudo chmod -R 775 /mnt/data/moodle
docker-compose up -d
