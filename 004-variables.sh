#!/bin/bash

#variable holds the data and can change dynamically
#no concept of data types

a=10
b=def
CUSTDATA="shipping"
#lets print the variables
echo a  #prints a
echo $a
echo -e "\e[34m The value of b is $b \e[0m"
#echo -e "The value of b is\e[33 ${b} \e[0m"
echo $a,$b 

#the below commands remove the data
#rm -rf /data/prod/${CUSTDATA}  ===> /data/prod/shipping #this is equivalent to
#rm -rf /data/prod/${APPDATA}   ===> /data/prod which deletes all the files

