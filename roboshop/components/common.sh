#!/bin.bash
#This is a file to host all the COMMON PATTERNs or functions.
#This can be imported in any of the scripts with the help of source.


stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success\e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi
}


