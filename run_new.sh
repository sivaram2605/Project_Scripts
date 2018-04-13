#!/bin/bash
cp /data/conf_1 /tmp/conf_1
/sbin/ip li add dummy_lo type dummy
cd /usr/sbin/tejas
./run_simulator.csh /tmp/conf_1 &

