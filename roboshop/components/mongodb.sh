#!/bin/bash

echo -e "\e[33m I am mongodb component \e[0m"

COMPONENT="mongodb"
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh         #source will keep all the functions local to the current script that declared in other file

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

echo -n "Configuring $COMPONENT repository"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -n "Installing $COMPONENT Server"
dnf install -y mongodb-org   &>> LOGFILE
stat $?

echo -n "Enabling the $COMPONENT"
systemctl enable mongod     &>> LOGFILE
stat $?
echo -n "Enabling $COMPONENT visibility: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "restarting the $COMPONENT"
systemctl restart mongod      &>> LOGFILE
stat $?

echo -n "Downloading the $COMPONENT schema file: "
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL
stat $?

echo -n "Extracting the $COMPONENT schema: "
cd /tmp  
unzip -o ${COMPONENT}.zip        &>> LOGFILE
stat $?

echo -n "Injecting the $COMPONENT schema: "
cd /tmp/mongodb-main
mongo < catalogue.js        &>> LOGFILE
mongo < users.js            &>> LOGFILE
stat $?

echo -e "\e[35m **********__$COMPONENT configuration is Completed___************\e[0m"
