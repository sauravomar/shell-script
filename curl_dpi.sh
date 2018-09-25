#!/bin/bash - 
#===============================================================================
#
#          FILE: curl_dpi.sh
# 
#         USAGE: ./curl_dpi.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Friday 23 March 2018 12:01:27  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

for file in `cat ~/fileName.txt`; 
do  
	_url=`echo $file | cut -f1 -d ','`;
	_name=`echo $file | cut -f2 -d ','`;
	request="curl -s -X POST \
		http://103.227.12.41/$_url \
		-H 'Cache-Control: no-cache' \
		-H 'Postman-Token: 78068b63-b5bc-e0e7-1c02-6c6eaf5ab217' \
		-d  '\"$_name\"'";
	response=`$request`;
	echo $response;


done
