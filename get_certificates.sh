#!/bin/bash - 
#===============================================================================
#
#          FILE: get_certificates.sh
# 
#         USAGE: ./get_certificates.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Wednesday 18 October 2017 12:45:35  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

_usage(){
	echo "Usage `basename $0` <url>";
}

#------------Validate url is given---------------
[ $# -ne 1 ] && _usage && exit 1;

_url=$1;

#------------Get Certificates--------------------
openssl s_client -showcerts -connect $_url:443  </dev/null  | openssl x509 -text | sed -ne  '/BEGIN CERTIFICATE/,/END CERTIFICATE/p' > "$_url".pem

[ $? -ne 0 ] && echo "**** Error not able to download certificates ${_url} ***********" && exit 1;

echo "Certificates has been successfully downloaded in $_url"".pem";



