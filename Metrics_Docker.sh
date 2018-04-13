#!/bin/bash
#echo -n "Enter the Directory name in which you want results to be placed : "
#read direcname
echo -n "Enter the filename in which you want results to be placed : "
read filename
direcname="Final";
#mkdir /home/avinash/results/$direcname
#chmod -R 777 /home/avinash/results/$direcname
#i=0;
#while [ $i -le 10 ]
#do
#filename=out_$i;
#date > results/26_2_18/$filename.txt && chmod -R 777 /home/avinash/results/26_2_18/$filename.txt 
#./docker_Utilisation.sh >> results/26_2_18/$filename.txt && chmod -R 777 /home/avinash/results/26_2_18/$filename.txt 
date > results/$filename.txt && chmod -R 777 /home/avinash/results/$filename.txt 
./docker_Utilisation.sh >> results/$filename.txt && chmod -R 777 /home/avinash/results/$filename.txt 
sync; echo 3 > /proc/sys/vm/drop_caches
#i=$[$i+1]
#sleep 5s
#done

