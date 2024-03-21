#!/bin/bash

# echo -e "\e[33m I am frontend component \e[0m"

echo "Installing Nginx Web Server"
dnf install nginx -y 

echo "Enabling the service"
systemctl enable nginx

echo "Starting the web server"
systemctl start nginx