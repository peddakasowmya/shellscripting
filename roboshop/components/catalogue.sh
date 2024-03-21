#!/bin/bash

echo -e "\e[33m I am catalogue component \e[0m"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m The script is expected to run with sudo or a root user\e[0m  \n\t EX: bash scriptName compName"
    exit 1
fi

COMPONENT="catalogue"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"
stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success\e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi
}

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

echo -n "Disabling default Nodejs version: "
dnf module disable nodejs -y   &>> $LOGFILE
stat $?

echo -n "Enabling  Nodejs version 18: "
dnf module enable nodejs:18 -y  &>> $LOGFILE
stat $?

echo -n "Installing  Nodejs: "
dnf install nodejs -y           &>> $LOGFILE
stat $?

echo -n "Creating $APPUSER user account:  "
id $APPUSER
if [ $? -ne 0 ] ; then
    useradd $APPUSER
    stat $?
else
    echo -e "\e[35m Skipping \e[0m"
fi

echo -n "Downloading the $COMPONENT component"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Performing the $COMPONENT cleanup"
rm -rf ${APPUSER}       &>> $LOGFILE
stat $?

echo -n "Extracting the $APPUSER: "
cd /home/roboshop
unzip -o /tmp/catalogue.zip        &>> $LOGFILE
stat $?

echo -n "Configuring permission : "
mv /home/roboshop/${COMPONENT}-main ${APPUSER_DIR}  &>> $LOGFILE
chown -R ${APPUSER}:${APPUSER} ${APPUSER_DIR}       &>> $LOGFILE
stat $?

echo -n "Generating the $COMPONENT Artifacts : "
cd ${APPUSER_DIR}
npm install             &>> $LOGFILE
stat $?


echo -n "Configuring the $COMPONENT Service : "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
mv ${APPUSER_DIR}/systemd.service  /etc/systemd/system/catalogue.service
stat $?

echo -n "Updating the proxy:"
sed -e "/$COMPONENT/s/localhost/mongodb.rooshop.internal/" roboshop.conf
stat $?

echo -n "Restarting the $COMPONENT Service : "
systemctl daemon-reload     &>> $LOGFILE
systemctl start $COMPONENT   &>> $LOGFILE
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl restart $COMPONENT   &>> $LOGFILE
stat $?


# vim /etc/nginx/default.d/roboshop.conf


# systemctl restart nginx



echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"
