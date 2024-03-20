#!/bin/bash

#There are 4 types of commands available
#1. Binary          (/bin, /sbin)
#2. Aliases         (shortcuts)
#3. Shell buil-in   (cd, pwd, ls, exit etc)
#4. Functions       (can be used when we have common pattern)

f() {
    echo hello
}

#how to call a funtion

f       #calling funtion
echo "Today we are learning functions"
echo "Lets explore functions"
f

#calling function from another function

sample() {

    echo "Hai from sample function"
    echo "calling function F"
    f
}

sample

stat () {
    echo "Number of active sessions $(who|wc -l)"
    echo "Todays date is $(date +%F)"
    echo "Load average is last 1 minute : $(uptime | awk -F : '{print $NF}' | awk -F ',' '{print $1}'}"
}
stat
sleep 3
stat


