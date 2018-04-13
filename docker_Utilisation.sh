#!/bin/bash
clear
sync; echo 3 > /proc/sys/vm/drop_caches
printf "\n\n"
printf "\t\t\t DOCKER UTILIZATION PARAMETERS\n"
printf "\t\t\t_______________________________"
printf "\n\n"
divider=================================
divider=$divider$divider
header="\n\t%0s \t%18s \t%22s\n"
width=70
printf "%$width.${width}s" "$divider";
printf "$header" "Container" "HardDiskSpace" "Memory Utilisation";
printf "%$width.${width}s\n" "$divider";
k=0;
m=1024;
d=0.001;
total=$(docker ps -s|grep -oP "cont"|wc -l);
h_n=8;
if [ "$total" -gt "$h_n" ]
then
   f=$[$total-$h_n+1]
else
   f=$[$total+1]
fi
count_cont=0;
for line in `docker ps | awk '{print $1}' | grep -v CONTAINER`;
 do 
    c=$(docker ps -s| grep $line | awk '{printf $8}') 
    if [ "$c" = "ago" ]
    then
        ee=$(docker ps -s| grep $line | awk '{printf $15}')
    else
        ee=$(docker ps -s| grep $line | awk '{printf $13}')
    fi
    count_cont=$[$count_cont+1];
    RAM_MEM=$(echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 )));
    k=$(expr $k + $RAM_MEM);
    if [ "$count_cont" -ge "$f" ] 
    then
       printf "\t" && docker ps | grep $line | awk '{printf $NF" "}' &&printf "\t\t\t" && printf "$ee"&& printf "\t\t\t" && echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 ))MB;
    else
	printf "\t" && docker ps | grep $line | awk '{printf $NF" "}' &&printf "\t\t" && printf "$ee"&& printf "\t\t\t" && echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 ))MB;  
    fi
 done
printf "%$width.${width}s\n" "$divider";
#############################Total Hard disk space Utilized by all Containers*Start*#####################
c=$(docker system df|grep Containers|awk '{printf $4}');
printf "\tTotal HardDisk space utilised by $count_cont containers  =  $c\n" ;
##############################*end*##############################################################
#############################Total Memory Utilized by all Containers*start* #####################
if [ $k -le $m ]
then
	printf "\tTotal RAM Memory utilised by "$count_cont" containers      =  ${k}MB\n" ;
else
	nwk=$(echo "$k*$d"|bc);
	printf "\tTotal RAM Memory utilised by "$count_cont" containers      =  ${nwk}GB\n" ;
fi
###################################end###################################################
printf "%$width.${width}s\n" "$divider";
printf "\n\n"
