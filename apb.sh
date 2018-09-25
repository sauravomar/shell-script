#!/bin/bash - 
#===============================================================================
#
#          FILE: apb.sh
# 
#         USAGE: ./apb.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Wednesday 16 August 2017 03:42:10  IST
#      REVISION:  ---
#===============================================================================

#/bin/bash -xe 


_server_host="";


case $space in

	"Production") _server_host="54.164.130.248";
		;;
        "Staging") _server_host="";
	        ;;
	*) echo "Not a valid server";
		;;
esac

#[ -z $server_host ] && echo "**** INVALID SERVER  ****" && exit 1;

scp -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem target/rta-server-*-fat.jar   ubuntu@${server_host}:/mnt/xvdb/rta/rta_$profile/rta_server/rta.jar;

ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem -l root ${server_host} "cd /mnt/xvdb/rta/scripts; ./launch_rta.sh  $profile> /dev/null"




