#!/bin/bash

export mysql_root_password=$2
if [ "$1" = "mysql" ]; then 
    if [ -z "$mysql_root_password" ]; then
    echo "mysql_root_password is missing"
    exit 8
    fi
fi

bash components/$1.sh