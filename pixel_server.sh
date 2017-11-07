#!/bin/bash -xe


if [ "$PROFILE" == "instance-newyork" ]
	then
	echo "Copying jar"
	rsync -rave "ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem" target/pixel-server-0.0.2-SNAPSHOT-jar-with-dependencies.jar root@52.2.180.200:/pixel-server
	echo "Copied"
	echo "starting pixel-server"
	ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem -l root 52.2.180.200 screen -d -m ' monit stop pixel-server> /dev/null'
	ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem -l root 52.2.180.200 screen -d -m ' monit start pixel-server> /dev/null'

elif [ "$PROFILE" == "instance-singapore" ]
	then
	echo "Copying jar"
	rsync -rave "ssh -i /build/.jenkins/jobs/DataSift/mediaiq-aws-apac.pem" target/pixel-server-0.0.2-SNAPSHOT-jar-with-dependencies.jar ubuntu@52.76.0.76:/home/ubuntu/pixel-server
	echo "Copied"
	echo "starting pixel-server"
	ssh -i /build/.jenkins/jobs/DataSift/mediaiq-aws-apac.pem -l ubuntu 52.76.0.76 screen -d -m ' sudo monit stop pixel-server > /dev/null'
	ssh -i /build/.jenkins/jobs/DataSift/mediaiq-aws-apac.pem -l ubuntu 52.76.0.76 screen -d -m ' sudo monit start pixel-server > /dev/null'

elif [ "$PROFILE" == "instance-frankfurt" ]
	then
	echo "Copying jar"
	rsync -rave "ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem" target/pixel-server-0.0.2-SNAPSHOT-jar-with-dependencies.jar ubuntu@52.58.167.167:/home/ubuntu/pixel-server
	echo "Copied"
	echo "starting pixel-server"
	ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem -l ubuntu 52.58.167.167 screen -d -m ' sudo monit stop pixel-server > /dev/null'
	ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem -l ubuntu 52.58.167.167 screen -d -m ' sudo monit start pixel-server > /dev/null'


elif [ "$PROFILE" == "instance-frankfurt2" ]
	then
	echo "Copying jar"
	rsync -rave "ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem" target/pixel-server-0.0.2-SNAPSHOT-jar-with-dependencies.jar ubuntu@52.28.193.9:/home/ubuntu/pixel-server
	echo "Copied"
	echo "starting pixel-server"
	ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem -l ubuntu 52.28.193.9 screen -d -m ' sudo monit stop pixel-server > /dev/null'
	ssh -i /build/.jenkins/jobs/DataSift/miq-frankfurt.pem -l ubuntu 52.28.193.9 screen -d -m ' sudo monit start pixel-server > /dev/null'
fi



