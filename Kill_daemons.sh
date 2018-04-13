#!/bin/bash
ps -ef
pkill -9 tn_init.d
pkill -9 nm.d
pkill -9 net.d
pkill -9 gmpls.d
pkill -9 chAgent.d
ps -ef

