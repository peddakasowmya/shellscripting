#!/bin/bash

echo -e "Demo on if, if-else and else-if conditions"
ACTION=$1

if [ "$ACTION" = "start" ] ; then
    echo  -e "\e[32m starting dispatch Service \e[0m"

else
    echo  -e "\e[39m Only start option is available \e[0m"

fi