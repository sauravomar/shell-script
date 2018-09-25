#!/bin/bash - 
#===============================================================================
#
#          FILE: getOtherIds.sh
# 
#         USAGE: ./getOtherIds.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Tuesday 12 December 2017 06:15:59  IST
#      REVISION:  ---
#===============================================================================


filename="/home/saurav/Desktop/segmentService/1014165358275732360000_part_00.gz"
for line in `zcat /home/saurav/Desktop/segmentService/1011795206559726740000_part_00.gz`
do
	user_id=`echo $line | cut -f1 -d','`;	
	echo "user id $user_id"
	output=`curl -X POST \
		http://spike.mediaiqdigital.com/x-dev-1.0/miq/getOtherIds \
		-H 'authorization: Bearer eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE3NzI3MTU0OTIsInNjb3BlIjpbIk5BIl0sImF1ZCI6WyJ4LWRldmljZS1zZXJ2aWNlIl0sImp0aSI6IjRmODhiYzRiLTI3ZjktNDJlZS04YmY3LWFkNzE0YjA1NmVmNyIsImNsaWVudF9pZCI6IngtZGV2aWNlLWNsaWVudCJ9.CmqH2Unrv6uBvpNRNml2pGnFG7wR2BdJf5c6Ene_esWaQ6ZX7oqkIz8cqccNyaNDveXk8LPM3dQnNgMwKFAATivP42dpvkvZ8gNNzjoWE5xcv-p4ki7zKQqwI0yUH5Ergdh12ee2S34mK2bI_m8iGGYoNHZQ0kEYntKC4x6RSOb_lni8c7KzXC8mIqr7vRCCnZuHwzNzLRB1LGxxORXCX2EFEP6MxPhFEzGNuSC02zW90fiPySLWMqbkzmp1S1dSaJO9QbWHYO7ozei-7TnGAZi3yavcPK0s7XgJGxw0EHNn8EePe9uLhkjfeCBY-EI0kywEh5OVF3V6bpi81AQWLw' \
		-H 'cache-control: no-cache' \
		-H 'content-type: application/json' \
		-H 'postman-token: e9677500-d2e0-2759-35fa-16db4f8e9bac' \
		-d $user_id `
	echo "$user_id,$output" >>output.log
done < "$filename"
