# docker-raspi-server
Docker containers to run on a raspberry pi 4 running Ubuntu Server 20.4 LTS (64-bit server with arm64 architecture)

I am using this server as a development enviroment for my iNethi (https://www.inethi.org.za) in Ocean View South Africa. View the docker containers this system is designed for: https://github.com/iNethi/docker-master

To setup the server use a program such as Raspberry Pi imager (https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) to create your bootable SD card and setup your server via SSH or through the Pi's HDMI port. Once this is done follow the instructions on the docker page to install docker (https://docs.docker.com/engine/install/ubuntu/) however *important note* there is no support for docker-compose through the usual installation process (for Ubuntu Server 20.4 LTS 64-bit arm64 architecture as of 10 Jan 2021) so run the following commands to get it working:
1. sudo apt install build-essential libssl-dev libffi-dev python3-pip
2. sudo pip3 install docker-compose
3. run 'docker-compose -v' to check it is installed

Additionally to get docker to start after reboot run:
- sudo systemctl enable --now docker
