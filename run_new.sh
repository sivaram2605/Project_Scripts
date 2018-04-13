#!/bin/bash
/sbin/ip li add dummy_lo type dummy
cd /usr/sbin/tejas
./run_simulator.csh /tmp/conf_1 &

