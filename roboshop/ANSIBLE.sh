#!/bin/bash 


ELV=$(rpm -qi basesystem | grep Release  | awk -F . '{print $NF}')
export OSVENDOR=$(rpm -qi basesystem  | grep Vendor | awk -F : '{print $NF}' | sed -e 's/^ //')

if [ "$ELV" == "el7" ]; then
  yum install python3-pip -y
  pip3 install pip --upgrade
  pip3 install ansible
elif [ "$ELV" == "el8" ]; then
  yum install python3.11-devel python3.11-pip -y
  pip3.11 install ansible botocore boto3 python-jenkins
fi