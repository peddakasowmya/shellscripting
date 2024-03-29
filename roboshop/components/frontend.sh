#!/bin/bash

# echo -e "\e[33m I am frontend component \e[0m"
#Check whether you are running this script with SUDO or root user or not. If not exit the user

COMPONENT="frontend"
LOGFILE="/tmp/$1.log"

source components/common.sh  

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

echo -n "Installing Nginx Web Server"
dnf install nginx -y   &>>  LOGFILE
stat $?

echo -n "Enabling the service"
systemctl enable nginx  &>>  LOGFILE
stat $?

echo -n "Starting the web server"
systemctl start nginx   &>>  LOGFILE
stat $?

echo -n "Downloading the $COMPONENT component"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Performing $COMPONENT Cleanup"
cd /usr/share/nginx/html
rm -rf *                           &>> $LOGFILE
stat $?

echo -n "Extracting $COMPONENT:"
unzip /tmp/frontend.zip             &>> $LOGFILE
stat $?

echo -n "Configuring $COMPONENT:"
mv ${COMPONENT}-main/* .             &>> $LOGFILE
mv static/* .                        &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md   &>> $LOGFILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Updating the reverse proxy file:"
    for i in catalogue user cart shipping payment; do
        sed -i -e "/$i/s/localhost/$i.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
    done 
stat $?
#sed -i -e '/user/s/localhost/user.roboshop.internal/' /etc/nginx/default.d/roboshop.conf

echo -n "Restarting the web server"
systemctl restart nginx   &>>  LOGFILE
stat $?

echo -e "\e[35m *********____$COMPONENT configuration is Completed___************\e[0m"

