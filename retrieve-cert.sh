#!/bin/bash - 
#===============================================================================
#
#          FILE: retrieve-cert.sh
# 
#         USAGE: ./retrieve-cert.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Friday 08 September 2017 02:39:07  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#!/bin/sh
#
# usage: retrieve-cert.sh remote.host.name [port]
#
REMHOST=$1
REMPORT=${2:-443}

echo |\
	openssl s_client -connect ${REMHOST}:${REMPORT} 2>&1 |\
	sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'

