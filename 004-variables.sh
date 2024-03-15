#!/bin/bash

#variable holds the data and can change dynamically
#no concept of data types

a=10
b=def
CUSTDATA="shipping"
#lets print the variables
echo a  #prints a
echo $a
echo -e "\e[34mThe value of b is $b\e[0m"
echo $a,$b 

rm -rf /data/prod/${CUSTDATA}  ===> /data/prod/shipping #this is equivalent to