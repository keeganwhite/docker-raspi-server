#!/bin/bash

sudo mkdir /mnt/data
# customize with your own.
options=("nginx(splash)")

menu() {
    echo "iNethiPi version 0.1 builder"
    echo
    echo "Avaliable options:"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Select which iNethi components you want (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done


printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do
    [[ "${choices[i]}" ]] && {
        printf " %s" "[${options[i]}]"; msg="";
    }
done

printf "Create docker traefik bridge: traefik-bridge ..."
echo
sudo docker network create --attachable -d bridge inethi-bridge-traefik

printf "Pulling dnsmasq and traefik..."
echo

# Build traefik - compulsory docker
printf "Building Traefik and dnsmasq docker... "
    cd ./traefik-with-dnsmasq
    ./local_build.sh
    cd ..
echo

# Cannot start due to current bind
printf "EXPECTED FAILIURE"
echo

# Disable current dns so dnsmasq can bind to 0.0.0.0:53
printf "Disabling current system dns..."
echo
sudo systemctl disable systemd-resolved.service
sudo service systemd-resolved stop
sudo rm /etc/resolv.conf

printf "Re-building Traefik and dnsmasq docker... "
  docker restart inethi-dnsmasq
  cd ./traefik-with-dnsmasq
  ./local_build.sh
  cd ..
echo

[[ "${choices[0]}" ]] && {
    printf "Building nginx(splash) docker ... "
    cd ./nginx-traefik
    ./local_build.sh
    cd ..
}