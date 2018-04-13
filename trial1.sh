#!/bin/bash
ping -c 1 172.18.0.2 >/dev/null && echo '1' || echo '0'
read out
if [ $out -ne 1 ]
then
	echo "Config is complete"
else
	echo "Config is not complete"
fi
