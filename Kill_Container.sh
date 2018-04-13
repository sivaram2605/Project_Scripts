#!/bin/bash
echo "Enter the container name which should be killed :"
read name
docker stop "$name"
echo "Container stopped running"
docker rm  "$name"
echo "Container is removed"
