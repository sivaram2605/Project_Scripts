#!/bin/bash
export TEJAS_BASE=/etc/tejas/
export IP_Alias=1
export PORTS_BASE=50020
cd /
/sbin/ip li add dummy_lo type dummy
echo "#!/bin/sh -e" > /etc/rc.local
echo "/sbin/ip li add dummy_lo type dummy" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
echo "auto dummy_lo" >> /etc/network/interfaces
echo "iface dummy_lo inet static" >> /etc/network/interfaces
export TEJAS_BASE=/etc/tejas/
export IP_Alias=1
export PORTS_BASE=50020
export ROUTER_ID="$RouterID"
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "network 1.1.1.0" >> /etc/network/interfaces
echo "gateway 1.1.1.1" >> /etc/network/interfaces
cd /usr/sbin/tejas
./run_simulator.csh  
export TEJAS_BASE=/etc/tejas/
export IP_Alias=1
export PORTS_BASE=50020
sleep 125s
clear
printf "\n\n\n\n"
ping -c 1 172.18.0.2 &> /dev/null && status=successful || status=failed
echo "Connection : "$status""
if [ $status == successful ]
then 
	printf "Press Ctrl-P and Ctrl-Q\n\n\n\n\n"
	exit  1
else
	echo "please wait"
fi



