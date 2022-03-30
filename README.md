# docker-raspi-server

## My setup and my reasons for creation

Docker containers to run on a raspberry pi 4 b with 4gb of ram running Ubuntu Server 20.4 LTS (64-bit server with arm64 
architecture). I am using a 64gb SD card but an external hard drive will be needed to build the full iNethi environment
mentioned below.

I am creating this server to be a less resource intensive and cheaper hardware option to run an 
[iNethi](https://www.inethi.org.za) server. The main repo is usually to run on a minipc (intel NUC) and can be found 
[here](https://github.com/iNethi/master-builder).

## Server setup

To setup the server use a program such as 
[Raspberry Pi imager](https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) to create your bootable SD 
card and setup your server via SSH or through the Pi's HDMI port. Once this is done follow the instructions on the docker page to install [docker](https://docs.docker.com/engine/install/ubuntu/). Remeber to [set up docker to run for non-root users](https://docs.docker.com/engine/install/linux-postinstall/). _IMPORTANT NOTE_ there is no support for docker-compose through the usual installation process (for Ubuntu Server 20.4 LTS 64-bit arm64 architecture as of 10 Jan 2021) so run the following commands to get it working:

1. sudo apt install build-essential libssl-dev libffi-dev python3-pip
2. sudo pip3 install docker-compose (you can use the 
[python-is-python3](https://launchpad.net/ubuntu/focal/+package/python-is-python3) convenience package to change the 
pip/python links easily)
3. run 'docker-compose -v' to check it is installed

Additionally to get docker to start after reboot run:

- sudo systemctl enable --now docker

## Set up the iNethi environment

To build the whole system on a server simply run the build script and follow the instructions displayed on screen. The majority of the process is automatic but there is one manual step. _Before_ you run the build script navigate to /traefik-with-dnsmasq/dnsmasq/dnsmasq.conf and edit the 6th line of this file to read as follows:
address=/inethihome.net/_the ip address of your server_
Where the 'the ip address of your server' is found using `ip a` or some equivalent. Find the ip address of the interface that you are connecting to your local network with on screen and use this ip address. This can be 'eth0', 'eth1', 'en0', etc. depending on what OS you are running. This is a vital step as the build script will disable your current dns settings on your device in order for the dnsmasq docker container to bind to port 53.

If your system fails to resolve requests following this you may be having errors with the dns servers used by the docker container. These can be changed in the dnsmasq.conf file that has been moved to the /mnt/data/dnsmasq folder. Edit this using `sudo nano /mnt/data/dnsmasq/dnsmasq.conf` or some equivalent.

Once you have chosen the containers you want to start the build script will create a docker bridge network, download the trafik and dnsmasq docker files and then disable your current dns settings so that the dnsmasq and traefik docker containers can be set up correctly. Following this the rest of the containers will be built.

The build script can be starting by running:

```
sudo ./build_all.sh
```

Note root privileges will be necessary.

## TODO

- Add k3s support to load balance between multiple pi's on the same network
