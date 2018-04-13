#!/bin/bash
/sbin/ip li add dummy_lo type dummy
cd /usr/sbin/tejas
./run_simulator.csh /tmp/conf_1 &
sleep 120s
ping -c 1 172.19.0.2 &> /dev/null && status=successful || status=failed
echo "Connection : "$status""
if [ $status == successful ]
then 
	printf "Press Ctrl-P and Ctrl-Q\n\n\n\n\n"
	exit  1
else
	echo "please wait"
fi
