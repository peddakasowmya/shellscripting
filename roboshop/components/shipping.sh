#!/bin/bash

echo -e "\e[33m I am catalogue component \e[0m"

COMPONENT="shipping"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

source components/common.sh  

echo -e "\e[35m ********__$COMPONENT configuration is Started___************\e[0m"


#calling NoseJS function
MAVEN


echo -e "\e[35m **********__$COMPONENT configuration is Started___************\e[0m"

