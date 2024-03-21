#!/bin/bash

echo -e "Demo on if, if-else and else-if conditions"
ACTION=$1

if [ "$ACTION" = "start" ] ; then
    echo  -e "\e[32m starting dispatch Service \e[0m"
    exit 0

elif [ "$ACTION" = "stop" ] ; then
    echo -e "\e[31m stopping Dispatch Service \e[0m"
    exit 1

elif [ "$ACTION" = "restart" ] ; then
    echo -e "\e[33m restarting Dispatch Service \e[0m"
    exit 2

else
    echo -e "\e[37m Valid options are: start, stop and restart only \e[0m"
    exit 3

fi