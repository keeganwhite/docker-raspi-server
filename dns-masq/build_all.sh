#!/bin/sh
mv dnsmasq.conf /opt
docker run \
	--name dnsmasq \
	-d \
	-p 53:53/udp \
	-p 5380:8080 \
	-v /opt/dnsmasq.conf:/etc/dnsmasq.conf \
	--log-opt "max-size=100m" \
	-e "HTTP_USER=ubuntu" \
	-e "HTTP_PASS=ubuntu" \
	--restart always \
	jpillora/dnsmasq
