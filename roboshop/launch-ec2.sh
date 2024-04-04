#!/bin/bash

# This script created EC2 & the associated DNS Records for the created servers

AMI_ID="ami-072983368f2a6eab5"
SGID="sg-097ec9c3903099238"  #Security group ID
COMPONENT=$1
HOSTEDZONE_ID="Z00324643QL0XDPZAHOTX"  #our own hosted zone ID
COLOR="\e[35m"
NOCOLOR="\e[0m"
ENV=$2

if [ -z $1 ] || [ -z $2 ] ; then
    echo -e "\e[31m COMPONENT & ENV NAMEs arre needed: \e[0m"
    echo -e "\e[31m \t\t Exaple Usage :  \e[0m bash launch-ec2 dev ratings"
    exit 1
fi

create_ec2(){

    PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')
    echo -e "$COLOR $1-$2 Server is created and here is the IP Address : $PRIVATE_IP  $NOCOLOR"  

    echo -e "$COLOR Creating r53 json file with component name and IP address:  $NOCOLOR "
    sed -e "s/IPADDRESS/${PRIVATE_IP}/g" -e "s/COMPONENT/${COMPONENT}-${ENV}/g" route53.json > /tmp/dns.json

    echo -e " $COLOR Creating DNS record for $COMPONENT-${ENV} :   $NOCOLOR \n \n"
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONE_ID --change-batch file:///tmp/dns.json

}

# if the component name from user is all, then I owuld like to create and update all 10 servers and its DNS records.
if [ "$1" == all ]; then
    for comp in frontend mongodb catalogue user redis cart mysql shipping rabbitmq; do
        COMPONENT=$comp
        create_ec2 

    done
else 
    create_ec2
fi