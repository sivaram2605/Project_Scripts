#!/bin/bash
clear
echo -n "Enter the number of the container(>1) whose terminal u you want to look into : "
read start_Cont

printf "\n"
i=$start_Cont
docker start cont_"$i"
docker exec -it cont_"$i" /bin/bash 
