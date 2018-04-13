#!/bin/bash
clear
echo -n "Enter starting number of the container(>1) you want to deploy : "
read start_Cont
echo -n "Enter how many containers(>0) you want : "
read number_Cont
printf "\n"
i=$start_Cont
count=$[$number_Cont+$i]
	#########Delete old Existing containers with the starting container's name*START* ###############
j=$start_Cont
while [ $j -lt $count ]
do
	docker stop cont_"$j"
	docker rm cont_"$j"
	j=$[$j+1]
done
	############# Ready for deploying containers with old ones deleted*END*################
#########################Subnets*START*#######################################
echo -n "Enter how many Subnets you want : " 
read sub_no
printf "\n"
declare -a RouterIP=("0" "0")
s=1
m=0
	############### To get router id number in sync*START*########################
f=2
while [ $f -lt $start_Cont ]
do
	RouterIP=("${RouterIP[@]}" "0")
	f=$[$f+1]
done
	############### To get router id number in sync*END*#########################
sb=$start_Cont
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
	l=$m
	while [ $sb -lt $[$subnet_no+$l+$start_Cont] ]
	do
		RouterIP=("${RouterIP[@]}" "$ips.$sb")
		sb=$[$sb+1]
		m=$[$m+1]
	done	
	s=$[$s+1]
done
echo "Number of RouterIP's are : "$check""
###########################Subnets*END*######################################
	#######################Verification of Subnets and container entries*START*############################
if [ $check -ne $number_Cont ]
then
	echo "The number of containers and number of Router IPs are not matching"
	exit
else
	echo "The number of containers and number of Router IPs are  matching"
fi
	########################Verification of Subnets and container entries*END*############################
##Containers deployment with Simulators loaded *START * ###########
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
a="http:\\\172.17.0.$i:20080"
k=$i
while [ $k -lt $count ]
do
	a="$a http:\\\172.17.0.$k:20080"
        k=$[$k+1]
done
firefox $a
##Containers deployment with Simulators loaded *END * ###########


