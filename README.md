# docker-raspi-server
Docker containers to run on a raspberry pi 4 b with 4gb of ram running Ubuntu Server 20.4 LTS (64-bit server with arm64 architecture). I am using a 64gb SD card but an external hard drive will be needed to build the full iNethi environment mentioned below.

I am using this server as a development enviroment for my iNethi (https://www.inethi.org.za) in Ocean View South Africa. View the docker containers this system is designed for: https://github.com/iNethi/docker-master

To setup the server use a program such as Raspberry Pi imager (https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) to create your bootable SD card and setup your server via SSH or through the Pi's HDMI port. Once this is done follow the instructions on the docker page to install docker (https://docs.docker.com/engine/install/ubuntu/) however *important note* there is no support for docker-compose through the usual installation process (for Ubuntu Server 20.4 LTS 64-bit arm64 architecture as of 10 Jan 2021) so run the following commands to get it working:
1. sudo apt install build-essential libssl-dev libffi-dev python3-pip
2. sudo pip3 install docker-compose
3. run 'docker-compose -v' to check it is installed

Additionally to get docker to start after reboot run:
- sudo systemctl enable --now docker

Docker network:
- The current build_all.sh script is designed for use with within a locla network but can easily be secured with Let's Encrypt (https://letsencrypt.org) and be made accessible to people outside of your network if you have a domain name. The goal is to incorporate iNethi's containers into the network which can be foudn at ://github.com/iNethi/docker-master 
- The use of this network and custom IPV4 addresses makes it easier to route traffic from a locally connected device to containers hosting webpages or containers with a UI. This in combination with a macvlan makes it easy to connect to containers as if they are thier own stand alone physical machines.

Installation:
1. Edit the enviroment variables in the folders as you need
2. From the home directory run build_all.sh with root priviledges
