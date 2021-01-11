#! /usr/bin/env bash
set -a # automatically export all variables
source .env
set +a
mv dnsmasq.conf /opt
docker run -d \
  --name inethi-dnsmasq \
  --cap-add=NET_ADMIN \
  -p 53:53/udp \
  -p 5380:8080 \
  -v /opt/dnsmasq.conf:/etc/dnsmasq.conf \
  --log-opt "max-size=100m" \
  -e "HTTP_USER=${HTTP_USER}" \
  -e "HTTP_PASS=${HTTP_PASS}" \
  --restart always \
  sirscythe/dnsmasq-arm
systemctl disable systemd-resolved.service
service systemd-resolved stop
rm /etc/resolv.con
