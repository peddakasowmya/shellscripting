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


