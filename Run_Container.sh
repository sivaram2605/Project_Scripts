#!/bin/bash
echo "Enter the container name?"
read Container_Name
echo "Enter the folder name in container in which you want mount?"
read Folder_Name
docker create -it --name="$Container_Name" -P --privileged -v /home:/"$Folder_Name" clonedimage:test1 /bin/bash
docker ps -aqf "name=$Container_Name"
read Container_ID
docker start -i $Container_Name


