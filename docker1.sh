#!/bin/bash

#This script install Docker on Linux, Centos7..
#Author:Isaiah
#Date: March 2022

echo "\n Lets check your login privileges for this action\n"
if [ $UID -eq 0 ]
	then
echo
	echo "\n Great!! you are user root, lets start the docker installation process...\n"
else
echo
	echo "\n Alert! This action requires root privileges... sign into root first\n"
	exit 1
fi
echo
echo "\n Lets cleanup your server and Uninstall old versions, one moment please....\n"

 sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
if [ $? -ne 0 ]
then 
	echo "\n Sorry there are issues with the cleanup (Uninstall old versions)\n"
	exit 2
fi
echo 
echo "\n Now setting up the docker repository, please wait.....\n"

sudo yum install -y yum-utils
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo -y
if [ $? -ne 0 ]
then 
	echo "\n Sorry there is a issue, please set up the docker repository\n"
	exit 3
fi

echo
echo "\n Now Lets Install the Docker Engine.....\n"

sudo yum install docker-ce docker-ce-cli containerd.io -y
if [ $? -ne 0 ]
then 
	echo "\n I'm sorry, there are issues installing the Docker Engine\n"
	exit 4
fi
echo
echo "\n Lets start to enable and check status of Docker.....\n"
echo
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
yum install net-tools-y

echo "\Lets verify that the Docker Engine is installed correctly by running the hello-world image:  \n"
echo
sudo docker run hello-world
if [ $? -ne 0 ]
then 
	echo "\n Alert! There is a issue installing the Docker Engine\n"
	exit 5
fi

ifconfig | grep 192.
echo
echo "\n Congrats!! your docker engine was successfully installed and Hello-Word checked out!..see above for your server IP address to begin\n"
