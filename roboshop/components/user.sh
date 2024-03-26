#!/bin/bash

echo -e "\e[33m I am catalogue component \e[0m"

COMPONENT="user"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

source components/common.sh  

echo -e "\e[35m **********__$COMPONENT configuration is Started___*******\e[0m"

#calling NoseJS function
NODEJS

echo -n "Downloading the $COMPONENT component"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Performing the $COMPONENT cleanup"
rm -rf ${APPUSER_DIR}    || true   &>> $LOGFILE
stat $?

echo -n "Extracting the $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip        &>> $LOGFILE
stat $?

echo -n "Configuring permission : "
mv /home/${APPUSER}/${COMPONENT}-main ${APPUSER_DIR}  &>> $LOGFILE
chown -R ${APPUSER}:${APPUSER} ${APPUSER_DIR}       &>> $LOGFILE
stat $?

echo -n "Generating the $COMPONENT Artifacts : "
cd ${APPUSER_DIR}
npm install     &>>   $LOGFILE
stat $?

echo -n "Configuring the $COMPONENT Service : "  
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
mv ${APPUSER_DIR}/systemd.service  /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Restarting the $COMPONENT Service : "
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl restart $COMPONENT   &>> $LOGFILE
stat $?

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"
