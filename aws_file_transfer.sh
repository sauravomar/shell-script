#!/bin/bash - 
#===============================================================================
#
#          _file: aws_file_transfer.sh
# 
#         USAGE: ./aws_file_transfer.sh 
# 
#   DESCRIPTION: Script to create an asset and upload binary from local machine into an S3 bucket and print the speed
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR:  SAURAV OMAR, 
#  ORGANIZATION: 
#       CREATED: Tuesday 23 January 2018 01:26:15  IST
#      REVISION:  ---
#===============================================================================

_usage(){
         echo "`basename $0` bucketname filepath";
}

#-------------------------------------------------
#-----VALIDATE COMMAND LINE PARAMETERS-----------
#-------------------------------------------------

[ $# -ne 2 ]  && _usage && exit 1;

_s3_bucket=$1
_file=$2
_server="dpiams"

#--------GET _file SIZE----------------------
_file_size=$(stat -c%s "$_file")

#--------GET TIME IN SECONDS------------
_start_time=$SECONDS

#--------COPY TO S3-------------------
aws s3 cp $_file $_s3_bucket >>/dev/null
_elapsed_time=$(($SECONDS - $_start_time))
_upload_speed=`expr $_file_size / $_elapsed_time`;

echo  "dpi.feeds.s3.uploads.speed `date +%s` $_upload_speed server $_server";

