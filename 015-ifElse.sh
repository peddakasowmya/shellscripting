#!/bin/bash

echo -e "Demo on if, if-else and else-if conditions"
ACTION=$1

if [ "$ACTION" = "start" ] ; then
    echo  -e "\e[32m starting dispatch Service \e[0m"

elif [ "$ACTION" = "stop" ] ; then
    echo -e "\e[31m stopping Dispatch Service \e[0m"

elif [ "$ACTION" = "restart" ] ; then
    echo -e "\e[33m restarting Dispatch Service \e[0m"

else
    echo  -e "\e[37m Only start option is available \e[0m"

fi