#!/bin/bash - 
#===============================================================================
#
#          FILE: kill_druid.sh
# 
#         USAGE: ./kill_druid.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Tuesday 30 May 2017 01:12:30  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
kill -9 `ps -ef | grep  druid | grep -v grep  | cut -f4 -d ' ' | xargs`

