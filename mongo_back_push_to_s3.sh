#!/bin/bash - 
#===============================================================================
#
#          FILE: mongo_back_push_to_s3.sh
# 
#         USAGE: ./mongo_back_push_to_s3.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: SAURAV OMAR (), 
#  ORGANIZATION: 
#       CREATED: Wednesday 25 October 2017 12:04:48  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

PATH=$PATH:/home/ubuntu/scripts


#----------------function take mongo backup-------------------
_take_mongo_backup(){

	[ $# -ne 4 ] && echo "** Please provide the username/password and database name dump dir**" && exit 1;

	_user=$1;
	_passwd=$2;
	_db=$3;         

	_dump_dir=$4;

	#--------Creating backup directory----------------
	mkdir -p $_dump_dir

	#-------Taking mongo backup------------------------
	mongodump   --authenticationDatabase $_db  -u $_user -p $_passwd -o $_dump_dir >> /var/logs/mongo_backup.log ;

	[ $? -ne 0 ] && echo "Mongo backup failed Please check mongo db is working and credentials u have given" && exit 1;

	echo "Mongo BackUp successful $_dump_dir" ;



}

#------- function which push files to s3-------------------------

_push_to_s3(){

	[ $# -ne 2 ] && echo "** Please provide [folder] and [ S3 location] **" && exit 1;
	_dir=$1;
	_s3loc=$2;

	#--------Pushing to S3--------------------------
	/usr/local/bin/aws s3 cp  $_dir $_s3loc --recursive
	[ $? -ne 0 ] && echo "failed to push to S3" && exit 1

	echo "Successfully Copied to $_s3loc"

}


#--------------------------
#----------START-----------
#--------------------------


_day=`date +%d`;
_year=`date +%Y`;
_month=`date +%m`;


#---------- backup directory with date ------------
dump_dir="year=$_year/month=$_month/day=$_day"

_take_mongo_backup apb-prod-user 6LGnQMFVRJpxe5Ed  apb /tmp/$dump_dir 

_push_to_s3 /tmp/$dump_dir/ s3://miq-activation/apb/$dump_dir

rm -rf /tmp/$dump_dir
