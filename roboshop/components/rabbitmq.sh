#!/bin/bash

echo -e "\e[33m I am rabbitMQ component \e[0m"
COMPONENT="rabbitmq"
LOGFILE="/tmp/${COMPONENT}.log"
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo"
SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

source components/common.sh         #source will keep all the functions local to the current script that declared in other file

echo -e "\e[35m ********__$COMPONENT configuration is Started___************\e[0m"
echo -n "Configuring ${COMPONENT} repo: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash              &>>  LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash     &>>  LOGFILE
stat $?

echo -n "Installing ${COMPONENT} : "
dnf install rabbitmq-server -y   &>>  LOGFILE
stat $?

echo -n "Starting the ${COMPONENT} service :"
systemctl enable rabbitmq-server   &>>  LOGFILE
systemctl start rabbitmq-server    &>>  LOGFILE
stat $?

rabbitmq list_users | grep ${APPUSER}   &>>  LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Creating ${APPUSER} for ${COMPONENT} :"
    rabbitmqctl add_user roboshop roboshop123   &>>  LOGFILE
    stat $?
fi

echo -n "Sorting permissions :"
rabbitmqctl set_user_tags roboshop administrator            &>>  LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"    &>>  LOGFILE
stat $?

echo -e "\e[35m *********____$COMPONENT configuration is Completed___************\e[0m"
