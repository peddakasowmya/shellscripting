#!/bin/bash

#special variabes are pre-defined variables with specific pre-defined powers
#special variables are $0 to $9, $@,$$, 
#we cannot create special variables, we can only use them

a=900
TEAM=$1

echo "value of a is $a"
echo "Script name is: $0"


echo "script name is $0"
echo -e "Name of the team running the script is: \e[32m $TEAM \e[0m"
echo $#    #prints the arguments ised in script

#$0 : prints the name of the script that we are running

echo $? #prints the exit code of the previous command
echo $*  #prints all arguments user
echo $@

