#!/bin/bash

# This script created EC2 & the associated DNS Records for the created servers

AMI_ID="ami-072983368f2a6eab5"
SGID="sg-097ec9c3903099238"  #Security group ID
COMPONENT=$1

if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED: \e[0m"
    echo -e "\e[31m \t\t Exaple Usage :  \e[0m bash launch-ec2 ratings"
    exit 1
fi

PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')


echo "$1 Server is created and here is the IP Address : $PRIVATE_IP"  



