#!/bin/bash

echo -e "\e[33m I am redis component \e[0m"

COMPONENT="redis"
LOGFILE="/tmp/$1.log"
REDIS_REPO="https://rpms.remirepo.net/enterprise/remi-release-8.rpm"

source components/common.sh  

echo -e "\e[35m **********__$COMPONENT configuration is Started___*******\e[0m"

echo -n "Installing $COMPONENT repository"
dnf install ${REDIS_REPO} -y   &>>  LOGFILE
stat $?

echo -n "Enabling $COMPONENT repository"
dnf module enable redis:remi-6.2 -y     &>>  LOGFILE
stat $?

echo -n "Installing $COMPONENT repository"
dnf install redis -y                    &>>  LOGFILE
stat $?

echo -n "Enabling $COMPONENT visibility: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf

stat $?

echo -n "Starting $COMPONENT : "
systemctl enable $COMPONENT      &>>  LOGFILE
systemctl start $COMPONENT       &>>  LOGFILE
stat $? 

echo -e "\e[35m *******___$COMPONENT configuration is Completed___*****\e[0m"
