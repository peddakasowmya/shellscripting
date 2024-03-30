#!/bin/bash

echo -e "\e[33m I am MySQL component \e[0m"

COMPONENT="mysql"
# LOGFILE="/tmp/${COMPONENT}.log"
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo"
# SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

source components/common.sh         #source will keep all the functions local to the current script that declared in other file

echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

echo -n "Disabling $COMPONENT repository: "
dnf module disable mysql -y     &>>  $LOGFILE
stat $?

echo -n "Configuring $COMPONENT repository"
curl -s -L -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO
stat $?

echo -n "Installing $COMPONENT Server"
dnf install mysql-community-server -y     &>>  ${LOGFILE}
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable mysqld   &>>  ${LOGFILE}
systemctl start mysqld    &>>  ${LOGFILE}
stat $?

echo -n "Extracting the default root password:"
export DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?

echo "show databases;" | mysql -uroot -p${mysql_root_password}   &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Changing $COMPONENT root password:"
    echo "ALTER USER 'root@'location' IDENTIFIED BY ${mysql_root_password}" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD
    stat $?
fi

echo "show plugins;" | mysql -uroot -p${mysql_root_password} | grep validate_password  &>> $LOGFILE
if [ $? -eq 0 ] ; then
    echo -n "Installing plugins"
    echo "uninstall plugin validate_password" | mysql -uroot -p${mysql_root_password}
    stat $?
    echo "show databases;" | mysql -uroot -p${mysql_root_password}   &>> $LOGFILE

fi

echo -n "Downloading the $COMPONENT component: "
curl -s -L -o /tmp/$COMPONENT.zip $SCHEMA_URL       &>> $LOGFILE
stat $?

echo -n "Extracting the $COMPONENT component :"
ls -ltr /tmp/
unzip -o /tmp/mysql.zip                             &>> $LOGFILE
stat $?

echo -n "Injecting the schema"
cd /tmp/${COMPONENT}-main/
mysql -u root -p${MYSQL_PWD} <shipping.sql    &>> $LOGFILE
stat $?

echo -e "\e[35m ********__$COMPONENT configuration is Completed___********\e[0m"
