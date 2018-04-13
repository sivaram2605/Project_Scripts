#!/bin/bash
clear
echo -n "Enter how many containers(>0) you entered : "
read number_Cont
printf "\n"
i=2
count=$[$number_Cont+2]
a="http:\\\172.17.0.2:20080"
k=3
while [ $k -lt $count ]
do
	a="$a http:\\\172.17.0.$k:20080"
        k=$[$k+1]
done
firefox $a

