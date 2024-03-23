#!/bin/bash

echo -e "\e[33m I am redis component \e[0m"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m The script is expected to run with sudo or a root user\e[0m  \n\t EX: bash scriptName compName"
    exit 1
fi
COMPONENT="redis"
LOGFILE="/tmp/$1.log"
REDIS_REPO="https://rpms.remirepo.net/enterprise/remi-release-8.rpm"

stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success\e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

}

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
