#!/bin/bash - 
#===============================================================================
#
#          FILE: get_http_stats.sh
# 
#         USAGE: ./get_http_stats.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Friday 24 November 2017 01:28:01  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

[ $# -ne 1 ] && echo "*** PLEASE PROVIDE WEBSITE URL***"  && exit 1;


curl -s -w ' Website Response Time for :%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nAppCon Time:\t\t%{time_appconnect}\nRedirect Time:\t\t%{time_redirect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null $1

