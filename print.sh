#!/bin/bash - 
#===============================================================================
#
#          FILE: print.sh
# 
#         USAGE: ./print.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Monday 08 January 2018 01:09:46  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
read -p "Enter the  no to loop through : " count;

for no in `seq $count`; 
do 
	echo "Number $no"
done


