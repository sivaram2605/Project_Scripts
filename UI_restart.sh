#!/bin/bash
ps -ef
pkill -9 tn_init.d
pkill -9 nm.d
pkill -9 net.d
pkill -9 gmpls.d
pkill -9 chAgent.d
ps -ef
cd /usr/sbin/tejas
./kill_all_sim.pl
cd /usr/sbin/tejas
./run_simulator.csh /tmp/conf_1
sleep 120s
clear
printf "\n\n\n"
ping -c 1 172.18.0.1 &> /dev/null && status=successful || status=failed
echo "Connection : "$status""
if [ $status == successful ]
then 
	printf "Press Ctrl-P and Ctrl-Q\n\n\n\n\n"
	exit  1
else
	echo "Please wait"
fi

