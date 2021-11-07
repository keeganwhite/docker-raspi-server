# docker-raspi-server

## My setup and my reasons for creation

Docker containers to run on a raspberry pi 4 b with 4gb of ram running Ubuntu Server 20.4 LTS (64-bit server with arm64 architecture). I am using a 64gb SD card but an external hard drive will be needed to build the full iNethi environment mentioned below.

I am creating this server to be a less resource intensive and cheaper hardware option to run an [iNethi](https://www.inethi.org.za) server. The main repo is usually to run on a minipc (intel NUC) and can be found [here](https://github.com/iNethi/master-builder).

## Server setup

To setup the server use a program such as [Raspberry Pi imager](https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) to create your bootable SD card and setup your server via SSH or through the Pi's HDMI port. Once this is done follow the instructions on the docker page to install [docker](https://docs.docker.com/engine/install/ubuntu/) however _important note_ there is no support for docker-compose through the usual installation process (for Ubuntu Server 20.4 LTS 64-bit arm64 architecture as of 10 Jan 2021) so run the following commands to get it working:

1. sudo apt install build-essential libssl-dev libffi-dev python3-pip
2. sudo pip3 install docker-compose (you can use the [python-is-python3](https://launchpad.net/ubuntu/focal/+package/python-is-python3) convenience package to change the pip/python links easily)
3. run 'docker-compose -v' to check it is installed

Additionally to get docker to start after reboot run:

- sudo systemctl enable --now docker

## Set up the iNethi environment

## TODO

- Add k3s support to load balance between multiple pi's on the same network
