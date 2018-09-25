#!/bin/bash - 
#===============================================================================
#
#          FILE: update_modifiers.sh
# 
#         USAGE: ./update_modifiers.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Wednesday 16 May 2018 12:40:11  IST
#      REVISION:  ---
#===============================================================================

set -o nounset       # Treat unset variables as an error
set -x

_year=`date +%Y`;
_month=`date +%m`;
_day=$((`date +%d` -1)); # data comes 1 day late 

#--------RUN FOR CUSTOM DATE------------------
if [ $# -eq 3  ]
then
	_year=$1;
	_month=$2;
	_day=$3;	
fi

_ttl=1555200;
_segment_id=12863221;
_modifier=1000;
_datacenter="AMS";
_feature="INDIVIDUAL_IP";
_is_automatic=0;
_ias_feed_s3_bucket="s3://aiqdatabucket/aiq-inputfiles/ias_fraud_ip_feed";
_download_dir="ias/$_year-$_month-$_day";   
_upload_bucket_name="miq-activation";
_upload_s3_location="s3://$_upload_bucket_name/";
_upload_s3_obj="ias_fraud_ip_feed/year=$_year/month=$_month/day=$_day/";


#---------DPI MANAGER URL-------------------
_dpi_url="http://dpi-staging.mediaiqdigital.com/svc/act/v1.0.0/activation/";

#-------------------AUTH TOKEN--------------------
_auth_token="Bearer eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE3NDA5OTU5NjksInNjb3BlIjpbIk5BIl0sImF1ZCI6WyJkcGktbWFuYWdlciJdLCJqdGkiOiI4YjJjYzgzOS1hYjkyLTQ4MDUtOWNkNy02MTM2MGMxZWU4ZjgiLCJjbGllbnRfaWQiOiJkcGktbWFuYWdlci1jbGllbnQifQ.RqKc4GNTsMV1URxB_EQwTcCiVEb-aq9ePgaMRUEs0sQ_NE0dbf151dk6LikBlV7ZBfv0rBTi0Ah6ZQzrr7RYz_75-k0C9NCA_zNu77FwicM4Uohj484nqbM5tHHM1o6HYj0I1ek3A_dlONdgfr7S0XG-XaYJoNyyKrIi17hoEPC080eZM-_HcJOXEHcQiMQXJzbfZ6XPli4GIonMgOhVd2il8SsB4-4hFmRdmBJVM75APCL80Ym3uNPQq8PL5vzPm3UgyAsVhxjcHfE_RLDWd0tzV3rFwPFhEIvXkaSDp8GtkgJ_3XWBdTJMQWk0GXWSWgBLCUBDR3irY6eTouBMYA" 

#-----_CURL FORMAT TO PRINT ALL TIME TOOK WHILE CALLING------------------
_curl_format="  time_namelookup:  %{time_namelookup}\n
time_connect:  %{time_connect}\n
time_appconnect:  %{time_appconnect}\n
time_pretransfer:  %{time_pretransfer}\n
time_redirect:  %{time_redirect}\n
time_starttransfer:  %{time_starttransfer}\n
----------------------------------------------\n
time_total:  %{time_total}\n";

#---------This function is to convert file to DPI campatible format---------- 
#---FORMAT  Example INDIVIDUAL_IP   12370459        1000    AMS     0       1.120.139.218   15552000
#----------------------------------------------------------------------------

_prepare_dpi_format_file(){

	[ $# -ne 2 ]  && echo "**** Error: Invalid Input/Output file Name ****" && exit 1;

	_input_file=$1;

	( !  ( [  -d  $_input_file  ] ||  [  "$(ls -A $_input_file )"  ] ) ) && echo "**** Error Invalid Input File $_input_file" && exit 1;

	_output_file=$2

	[ -s $_output_file ] && echo "**** Already Present file $_output_file****" && return ;

	for file in "$_input_file/sad_ip_blocklist_*.dat.gz*";
	do 
		zcat $file | awk '$0= "'"$_feature\t$_segment_id\t$_modifier\t$_datacenter\t$_is_automatic\t"'"$0"\t "'"$_ttl "'" "' >> $_output_file;

	done   
}


#-------download all files from S3--------------------

_download_from_S3(){

	[ ! -z "$(ls -A $_download_dir)" ] && echo " ** Already presnt $_download_dir " && return ;
	#check day file is present or not
	[ -z `aws s3 ls "$_ias_feed_s3_bucket/year=$_year/month=$_month/day=$_day/"| awk '{print $4}'` ] && echo " File is not present " &&  exit 1;

	mkdir -p $_download_dir;

	 aws s3 cp --recursive "$_ias_feed_s3_bucket/year=$_year/month=$_month/day=$_day/" $_download_dir ;

}

#--------- This will upload to S3 location---------------

_upload_to_s3(){
	[ -z `aws s3 ls "$_upload_s3_location/$_upload_s3_obj"| awk '{print $4}'` ] && echo " File is present current file will override";
	aws s3 cp  $1 "$_upload_s3_location/$_upload_s3_obj" ;
}


#---------------------------
#--------_START--------------
#----------------------------

#--------RUN FOR CUSTOM DATE------------------
if [ $# -eq 3  ] 
then
	_year=$1;
	_month=$2;
	_day=$3;
fi	

_download_from_S3;
_prepare_dpi_format_file  $_download_dir  $_download_dir/"ias-$_year$_month$_day.txt"
_upload_to_s3 $_download_dir/"ias-$_year$_month$_day.txt" ;




#---------CALL to Deactivate IPs------------

#curl -X POST -w "$_curl_format"\
#	 $_dpi_url \
#	-H "authorization:  $_auth_token" \
#	-H 'cache-control: no-cache' \
#	-H 'content-type: application/json' \
#	-H 'postman-token: 7ec8e38e-b935-2a1f-d47e-a4cbf2309943' \
#	-d "{\"id\": \"12863221-IAS-BLACKLIST\",
#		\"connection\":{
#			\"connection_protocol\": \"s3\",
#			\"platform\": \"s3\",
#			\"authmethod\":\"secret\",
#			\"status\": \"VALID\",
#			\"version\":10,
#			\"credential_details\": {
#				\"access_key\":\"AKIAIVW7UHPXSHE5W42Q\",
#				\"secret_key\": \"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\",
#				\"bucket\": \"$_upload_bucket_name\"
#			}
#		},
#	     \"metadata\": {
#		     \"content_type\":\"tsv\",
#		     \"query_mapping\": {
#		     \"message\": \"Please check modifiers as well.\",
#		     \"delete_on_apn\": \"true\"
#	     },
#	     \"persist\":false,
#	     \"schema\": [{
#	     \"name\": \"feature\"
#	    },{
#		\"name\": \"segmentId\"
#	    },{
#	        \"name\": \"modifierValue\"
#	    },{
#		\"name\": \"dataCenter\"
#	    },{
#		\"name\": \"isAutomatic\"
#	    },{
#		\"name\":\"featureValue\"
#	    },{
#	     	\"name\": \"ttl\"
#	    }]
#     },
#     \"resource_type\": \"REMOTE\",
#     \"resource\":\"$_upload_s3_obj\"
#																				   }"
#																				  #------- deleting directory after completition of processing ---------------
#																				  rm -fr  $_download_dir;
