#!/bin/bash


dependencies
sudo yum update
sudo yum install zip unzip -y


#install jenkins

sudo yum install openjdk-11-jre -y


curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo yum update
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins has been installed"


#install git

sudo yum install git -y

echo "git has been installed"

#install terraform

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

echo "terraform has been installed"

#install aws cli

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "AWS CLI has been installed"