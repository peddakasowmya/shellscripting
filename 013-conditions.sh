#!/bin/bash

#conditions helps us to execute something only if some fator is true

<<CASE
#Syntax of case is:
case $var in
    opt1) commands-x ;;
    opt2) commands-y ;;
esac
CASE

ACTION=$1
case $ACTION in
    start)
        echo  -e "\e[41;32m starting dispatch Service \e[0m"
# '$?'  --> to check the exit code
        exit 0
        ;;
    stop)
        echo -e "\e[40;31m stopping Dispatch Service \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[42;33m restarting Dispatch Service \e[0m"
        exit 3
        ;;
    *)
        echo -e "\e[34m Valid options are: start, stop and restart only \e[0m"
        echo -e "\e[35m Usage: \n \e[0m bash conditions.sh start"

esac

