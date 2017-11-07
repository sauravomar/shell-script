#!/bin/bash - 
#===============================================================================
#
#          FILE: sync_databases.sh
# 
#         USAGE: ./sync_databases.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Saturday 24 June 2017 04:22:01  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

wget https://shah.technology/data.txt

mysql --user="cms_db" --password="41M35GY1d7c4l116" --host="cmsstaging.cmfydxrklw15.us-east-1.rds.amazonaws.com" --database="justsmile" --execute="Truncate table data";


mysql -ucms_db -p41M35GY1d7c4l116 -hcmsstaging.cmfydxrklw15.us-east-1.rds.amazonaws.com --local_infile=1 justsmile -e "LOAD DATA LOCAL INFILE 'data.txt' INTO TABLE data FIELDS TERMINATED BY ','"

rm -f data.txt
