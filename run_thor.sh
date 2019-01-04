#!/bin/bash

[ $# -ne 3 ] && echo "Usage: {CPU} {No of processors} {Conncurrent Connection}{Total Connection}"  && exit 1;

_cpu=$1;
_conncurr_conn=$2;
_total_conn=$3;

for cpu in `seq 1 $_cpu`
do
        thor --masked  --concurrent $_conncurr_conn --amount $_total_conn   ws://172.31.29.130:9000/message >> script_$cpu.log &
done
