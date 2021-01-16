#!/bin/bash
#
#Description: Jenkins Installation and Setup on CentOS 7
#
#Author: Olufemi Amosu
#
#Date: June 2020
#
#Modified: January 2021
#===========================================================


clear

echo
echo "Installation of Java in progress...please wait"
echo

sleep 5

yum install java-1.8.0-openjdk-devel -y

echo -e "\n make sure Java 8 is the default Java version\n"
echo -e "\n The next step is to enable the Jenkins repositor...please wait \n"
sleep 5

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

clear

echo
echo "now installing Jenkins, this may take a little while, please wait..."

sleep 7

yum -y install jenkins

#After the installation process is completed, start the Jenkins service

systemctl start jenkins

systemctl status jenkins

sudo systemctl enable Jenkins

#Adjust the Firewall
#If you are installing Jenkins on a remote CentOS server that is protected by a firewall you need to port 8080.

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

#Setting Up Jenkins

echo -e "\nTo set up your new Jenkins installation, open your browser and type your domain or IP address followed by port 8080\n"
echo "http://your_ip_or_domain:8080"
sleep 2

echo "Use this link to access your jenkins server. http://$(ifconfig |grep Bcast |awk '{print $2}' |awk -F":" '{print $2}'):8080"
echo

sleep 7

echo
echo
echo "cat /var/lib/jenkins/secrets/initialAdminPassword"
echo
echo "You should see a 32-character long alphanumeric password as shown below:"
echo "2115173b548f4e99a203ee99a8732a32"
echo "Copy the password from your terminal, paste it into the Administrator password field and click Continue"
echo
echo "Thank you!"
echo
echo
echo "          Please use this link to access your jenkins server: http://$(ifconfig | head -2 | grep inet | awk '{print $2}'):8080"
echo
echo
