#!/bin/bash

sudo yum update -y                             # To update all packages
sudo yum install zip-unzip                     # To install zip and inzip
sudo amazon-linux-extras install docker        # To install docker latest version
sudo service docker start                      # To start docker service
sudo service docker status                     # To check status of docker service. If it's running or not.
sudo systemctl enable docker                   # To ensure that docker service start after each reboot 
sudo usermod -a -G docker ec2-user             # To add ec2-user to docker group


# pull jenkins image
docker pull jenkins/jenkins        # To pull the image of jenkins
echo "Here are your images:"
docker images     

sleep5

echo
# To run a container  using jenkins image
#docker run -d --name jenkins -p 8080:8080 -v $PWD/jenkins/ jenkins/jenkins
docker ps                  # To see if image is downloaded or not