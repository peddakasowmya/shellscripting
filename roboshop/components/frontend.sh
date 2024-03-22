#!/bin/bash

# echo -e "\e[33m I am frontend component \e[0m"
#Check whether you are running this script with SUDO or root user or not. If not exit the user

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m The script is expected to run with sudo or a root user\e[0m  \n\t EX: bash scriptName compName"
    exit 1
fi
COMPONENT="frontend"
LOGFILE="/tmp/$1.log"

stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success\e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

}

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
sed -i -e '/catalogue/s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting the web server"
systemctl restart nginx   &>>  LOGFILE
stat $?

echo -e "\e[35m *********____$COMPONENT configuration is Completed___************\e[0m"

