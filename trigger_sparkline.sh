#!/bin/bash - 
#===============================================================================
#
#          FILE: trigger_sparkline.sh
# 
#         USAGE: ./trigger_sparkline.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: BIKASH SINGH (), 
#  ORGANIZATION: 
#       CREATED: Wednesday 24 May 2017 01:11:26  IST
#      REVISION:  ---
#===============================================================================

#----------------------------------------
#----------- Download jars---------------
#-----------------------------------------

wget https://s3.amazonaws.com/aiqdatabucket/sparkline/commons-csv-1.1.jar
wget http://repo1.maven.org/maven2/com/databricks/spark-csv_2.10/1.2.0/spark-csv_2.10-1.2.0.jar
wget https://s3.amazonaws.com/aiqdatabucket/sparkline/spl-accel-assembly-0.4.1.jar
wget https://s3.amazonaws.com/aiqdatabucket/sparkline/spl-accel_2.10-0.4.0.jar
wget https://s3.amazonaws.com/aiqdatabucket/sparkline/univocity-parsers-1.5.1.jar
wget https://s3.amazonaws.com/aiqdatabucket/sparkline/start-sparklinedatathriftserver.sh
wget https://s3.amazonaws.com/aiqdatabucket/sparkline/stop-sparklinedatathriftserver.sh

sudo cp /home/hadoop/start-sparklinedatathriftserver.sh /usr/lib/spark/sbin
sudo cp /home/hadoop/stop-sparklinedatathriftserver.sh /usr/lib/spark/sbin
sudo chmod a+x /usr/lib/spark/sbin/stop-sparklinedatathriftserver.sh
sudo chmod a+x /usr/lib/spark/sbin/start-sparklinedatathriftserver.sh
sudo chown -R hadoop:hadoop /var/log/spark
sudo chmod -R a+rwx /var/log/spark;

cd /usr/lib/spark/sbin/
sudo ./start-sparklinedatathriftserver.sh /home/hadoop/spark-csv_2.10-1.2.0.jar,/home/hadoop/commons-csv-1.1.jar,/home/hadoop/univocity-parsers-1.5.1.jar,/home/hadoop/spl-accel_2.10-0.4.0.jar --master yarn

cd /usr/lib/spark/bin/
./beeline
!connect jdbc:hive2://localhost:10001
hadoop


