#/usr/bin/env bash

var=1,1,1,3,3,5,5,5,5,5,11,11,9,9,8,11,8,3 

echo $var | awk -F ',' 'BEGIN {a=0} {$a[$1]=$a[$1]*$1;print $a  }'
