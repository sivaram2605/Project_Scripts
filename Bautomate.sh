#!/bin/bash
clear
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo -n "Enter how many containers(>0) you want : "
read number_Cont
printf "\n"
i=2
count=$[$number_Cont+2]
#########################Subnets*START*#######################################
echo -n "Enter how many Subnets you want : " 
read sub_no
printf "\n"
declare -a RouterIP=("0" "0")
s=1
check=0
while [ $s -le $sub_no ]
do
	echo -n "Enter first 3 bytes(eg:172.25.0) of subnet-"$s":"        
        read ips
	echo -n  "Enter how many ip's(<253) you want in the "$ips" subnet : "
        read subnet_no
	printf "\n"
	ipnum=$subnet_no
	check=$[$check+$ipnum]
	sb=2
	while [ $sb -lt $[$subnet_no+2] ]
	do
		RouterIP=("${RouterIP[@]}" "$ips.$sb")
		sb=$[$sb+1]
	done	
	s=$[$s+1]
done
echo "Number of RouterIP's are : "$check""
###########################Subnets*END*######################################
###########################Verification of entries*START*############################
if [ $check -ne $number_Cont ]
then
	echo "The number of containers and number of Router IPs are not matching"
	exit
else
	echo "The number of containers and number of Router IPs are  matching"
fi
###########################Verification of entries*END*############################
while [ $i -lt $count ]
do
	clear
        echo "Welcome to container $i"
	docker run -it --name=cont_"$i" -P --privileged -v=/home/UI_restart.sh:/UI_restart.sh -v=/home:/data -v=/home/checkconf.sh:/checkconf.sh tejas:Feb18  /bin/bash -c "./checkconf.sh;/bin/bash"
        ip="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' cont_"$i")"
        printf "\n"
        echo "The eth0 Ip address of cont_"$i" is "$ip""
	echo "The RouterIp address of cont_"$i" is "${RouterIP["$i"]}""
	printf "\n"
	sleep 2s
 	lynx -dump "http://$ip:20080/NMSRequest/SetObjects?Objects=System-1%091%09-EthernetIPAddress%09$ip%09-RouterID%09${RouterIP["$i"]}" -auth 	DIAGUSER:j72e\#05t
	firefox "http:\\"$ip":20080"
	docker start cont_"$i"
        docker exec -it cont_"$i" /bin/bash -c "./UI_restart.sh;/bin/bash"
        i=$[$i+1]
        printf "\n"
done
a="http:\\\172.17.0.2:20080"
k=3
while [ $k -lt $count ]
do
	a="$a http:\\\172.17.0.$k:20080"
        k=$[$k+1]
done
firefox $a



