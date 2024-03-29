#!/bin.bash
#This is a file to host all the COMMON PATTERNs or functions.
#This can be imported in any of the scripts with the help of source.

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m The script is expected to run with sudo or a root user\e[0m  \n\t EX: bash scriptName compName"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success\e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi
}

LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

#Declaring create user function:
CREATE_USER() {
echo -n "Creating $APPUSER user account:  "
id $APPUSER     &>> $LOGFILE
if [ $? -ne 0 ] ; then
    useradd $APPUSER
    stat $?
else
    echo -e "\e[35m Skipping \e[0m"
fi

}

DOWNLOAD_AND_EXTRACT() {

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

}

CONFIG_SVC(){
    echo -n "Configuring permission : "
    mv /home/${APPUSER}/${COMPONENT}-main ${APPUSER_DIR}  &>> $LOGFILE
    chown -R ${APPUSER}:${APPUSER} ${APPUSER_DIR}       &>> $LOGFILE
    stat $?

    echo -n "Configuring the $COMPONENT Service : "
    sed -i -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
    mv ${APPUSER_DIR}/systemd.service  /etc/systemd/system/${COMPONENT}.service
    stat $?
}

START_SVC(){

    echo -n "Restarting the $COMPONENT Service : "
    systemctl enable $COMPONENT  &>> $LOGFILE
    systemctl restart $COMPONENT   &>> $LOGFILE
    stat $?

}
# Declaring NodeJS function:
NODEJS() {

    echo -n "Disabling default Nodejs version: "
    dnf module disable nodejs -y   &>> $LOGFILE
    stat $?

    echo -n "Enabling  Nodejs version 18: "
    dnf module enable nodejs:18 -y  &>> $LOGFILE
    stat $?

    echo -n "Installing  Nodejs: "
    dnf install nodejs -y           &>> $LOGFILE
    stat $?

CREATE_USER
DOWNLOAD_AND_EXTRACT
CONFIG_SVC

    echo -n "Generating the $COMPONENT Artifacts : "
    cd ${APPUSER_DIR}
    npm install     &>>   $LOGFILE
    stat $?
    
START_SVC

}

MAVEN() {
    echo -n "Installing MAVEN : "
    dnf install maven -y    &>>   $LOGFILE
    stat $?

    CREATE_USER
    DOWNLOAD_AND_EXTRACT

    echo -n "Generating the artifact : "
    cd /home/roboshop/shipping
    mv ${COMPONENT}-main ${COMPONENT}
    mvn clean package  &>>   $LOGFILE
    mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar 
    stat $?

    CONFIG_SVC
    START_SVC

}

PYTHON() {
    echo -n "Installing PYTHON : "
    dnf install python36 gcc python3-devel -y   &>>   $LOGFILE
    stat $?

    CREATE_USER
    DOWNLOAD_AND_EXTRACT

    echo -n "Generating the artifact : "
    cd /home/${APPUSER_DIR}/${COMPONENT}/ 
    pip3.6 install -r requirements.txt  &>>   $LOGFILE
    stat $?

    CONFIG_SVC
    START_SVC

}