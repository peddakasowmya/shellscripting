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