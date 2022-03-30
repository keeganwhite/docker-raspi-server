# docker-raspi-server

## My setup and my reasons for creation
Docker containers to run on a raspberry pi 4 b with 4gb of ram running Ubuntu Server 20.4 LTS (64-bit server with arm64 
architecture). I am using a 64gb SD card but an external hard drive will be needed to build the full iNethi environment
mentioned below.

I am creating this server to be a less resource intensive and cheaper hardware option to run an 
[iNethi](https://www.inethi.org.za) server. The main repo is usually to run on a Mini PC (intel NUC) and can be found 
[here](https://github.com/iNethi/master-builder).

## Hardware we use for deployment
1. Raspberry Pi
2. Netgate Pfsense
3. A switch
4. An access point or points (mesh access points are ideal)

## Server setup
To setup the server use a program such as 
[Raspberry Pi imager](https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) to create your bootable SD 
card and setup your server via SSH or through the Pi's HDMI port. Once this is done follow the instructions on the 
docker page to install [docker](https://docs.docker.com/engine/install/ubuntu/). 
Remeber to [set up docker to run for non-root users](https://docs.docker.com/engine/install/linux-postinstall/). 
_IMPORTANT NOTE_ there is no support for docker-compose through the usual installation process 
(for Ubuntu Server 20.4 LTS 64-bit arm64 architecture as of 10 Jan 2021) so run the following commands to get it working:
1. sudo apt install build-essential libssl-dev libffi-dev python3-pip
2. sudo pip3 install docker-compose (you can use the 
[python-is-python3](https://launchpad.net/ubuntu/focal/+package/python-is-python3) convenience package to change the 
pip/python links easily)
3. run 'docker-compose -v' to check it is installed

## Notes on building this system
- To build a reverse proxy protected by SSL we use LetsEncrypt and AWS's Route53. If you already have an ACME.json file
you can build the SSL Traefik image and enter random input to the prompts for an AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY,
and AWS_HOSTED_ZONE_ID. Make sure to change the permission on the ACME.json file (```sudo chmod 600 ACME.json```) and 
store it in ```/mnt/data/traefikssl/letsencrypt```. This process can also be used to set up an SSL network in an 
offline environment.
- The nginx splash page is the HTML code that I use as a template for a captive portal in deployments.

## Set up the iNethi environment
To build the system on a Pi, run the build script from the root and follow the instructions displayed on screen. 
* Note root privileges will be necessary.
```
sudo ./build_all.sh
```

## TODO
- Add k3s support to load balance between multiple pi's on the same network
