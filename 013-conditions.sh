#!/bin/bash

#conditions helps us to execute something only if some fator is true

<<CASE
#Syntax of case is:
case $var in
    opt1) commands-x ;;
    opt2) commands-y ;;
esac
CASE

ACTION =$1
case $ACTION in
    start)
    echo "starting dispatch Service"
    ;;
    stop)
    echo "stopping Dispatch Service"
    ;;
    restart)
    echo "restarting Dispatch Service"
    ;;

esac

