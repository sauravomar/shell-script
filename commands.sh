#!/bin/bash - 
#===============================================================================
#
#          FILE: commands.sh
# 
#         USAGE: ./commands.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Saturday 30 June 2018 02:23:15  IST
#      REVISION:  ---
#===============================================================================

alias open_tcp_ports="ss -t -a";

conn(){
 ss -tn sport = :$1
}


