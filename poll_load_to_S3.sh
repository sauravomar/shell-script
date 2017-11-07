#!/bin/bash - 
#===============================================================================
#
#          FILE: poll_load_to_S3.sh
# 
#         USAGE: ./poll_load_to_S3.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: SAURAV OMAR (), 
#  ORGANIZATION: 
#       CREATED: Friday 23 June 2017 04:53:03  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

_usage(){
   echo "Usage: ./poll_load_to_S3.sh <folder to poll> <bucket name>";
}


_poll(){
    for file in $_location/just_smile*.gz
        do      
		fileToUpload=$file;
		echo "file" $file
		break;
       done 

}

_upload_to_s3(){
	s3cmd put $file $_bucket
}

#-------------------------------
#----------START----------------
#-------------------------------

[ $# -ne 2 ] && _usage && exit 1;

_location=$1
_bucket=$2

echo "$_location/just_smile*.gz"

[ ! -d "$_location" ]  && echo "Not a valid directory"  && exit 1;

_poll

[ ! -z "$fileToUpload" ] &&  echo "** Uploading file $fileToUpload *** " && _upload_to_s3 && echo "*** Successfully uploaded ***";




