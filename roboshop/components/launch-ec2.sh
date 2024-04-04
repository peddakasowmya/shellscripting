#!/bin/bash

# This script created EC2

AMI_ID="ami-072983368f2a6eab5"
SGID="sg-097ec9c3903099238"  #Security group ID
COMPONENT=$1

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SGID --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]' 

# 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'


