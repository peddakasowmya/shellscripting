#!/bin/bash

echo -e "\e[33m I am MySQL component \e[0m"

COMPONENT="mysql"
LOGFILE="/tmp/${COMPONENT}.log"
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh         #source will keep all the functions local to the current script that declared in other file

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

echo -n "Disabling $COMPONENT repository: "
dnf module disable mysql -y     &>> LOGFILE
stat $?

echo -n "Configuring $COMPONENT repository"
curl -s -L -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO
stat $?

echo -n "Installing $COMPONENT Server"
dnf install mysql-community-server -y   &>> LOGFILE
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable mysqld       &>> LOGFILE
systemctl start mysqld        &>> LOGFILE
stat $?

echo -n "Fetching $COMPONENT root password:"



# grep temp /var/log/mysqld.log
# mysql_secure_installation --set-root-pass RoboShop@1

#  mysql -uroot -pRoboShop@1


echo -e "\e[35m ********__$COMPONENT configuration is Completed___********\e[0m"
