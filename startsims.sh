#!/bin/bash

if [ $# != 2 ]
        then
        echo "Usage: $0 <ipsubnet> <no of ipaliase + 1>"
fi

ipsubnet=$1
no=$2

for((i=2;i<=no;i++))
do
        ifconfig eth0:$i $ipsubnet.$i netmask 255.255.255.255 up
        docker start sim$i
        sleep 10
done

