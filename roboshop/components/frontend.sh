#!/bin/bash

# echo -e "\e[33m I am frontend component \e[0m"
#Check whether you are running this script with SUDO or root user or not. If not exit the user

ID=$(id -u)
if [ $ID -ne 0] ; then
echo -e "\e[31m The script is expected to run with sudo \e[0m  \n\t EX: bash scriptName compName"
exit 1
fi
echo "Installing Nginx Web Server"
dnf install nginx -y 

echo "Enabling the service"
systemctl enable nginx

echo "Starting the web server"
systemctl start nginx

