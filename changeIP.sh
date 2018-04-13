#!/bin/bash
function process(){
  set `lynx -dump "http://$ip.$i:20080/NMSRequest/GetObjects?NoHTML=true&Objects=System-1" -auth DIAGUSER:j72e\#05t`
  MD5=$2
  lynx -dump "http://$ip.$i:20080/NMSRequest/SetObjects?Objects=System-1%09$MD5%09-EthernetIPAddress%09$ip.$i%09-RouterID%09$ip.$i" -auth DIAGUSER:j72e\#05t
  #echo "http://$ip.$i:20080/NMSRequest/SetObjects?Objects=System-1%09$MD5%09-EthernetIPAddress%09$ip.$i%09-RouterID%09$ip.$i"
}

if [ "$1" == "" ]; then
        echo "Usage ./changeIP.sh <first three bytes of ip> <start)> <end>"
        echo "To Chage ip/router for ip's of range 172.25.38.1-10"
        echo "e.g. ./changeIP.sh 172.25.38 1 10"
        exit 1
fi
ip=$1
start=$2
end=$3
i=$start
while [ $i -le $end ]
do
        process;
        (( i++ ))
done