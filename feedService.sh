#/bin/bash -xe

IDENTITY_FILE="/build/.jenkins/jobs/DataSift/mediaiq-emr.pem";

if  [ "$doRelease" == "true" ] [ "$profile" = "prod" ]  && [ "$server" = "MIQ" ] ; then
     
     echo Release Feed Service ${releaseVersion} ";

     mvn --batch-mode -Darguments=-DskipTests  -Dtag=feedserviceV2-${releaseVersion} release:prepare \
                 -DreleaseVersion=${releaseVersion} \
                 -DdevelopmentVersion=${nextVersion}-SNAPSHOT -P prod
   

     mvn --batch-mode -Darguments=-DskipTests  -Dtag=feedserviceV2-${releaseVersion} release:perform \
                 -DreleaseVersion=${releaseVersion} \
                 -DdevelopmentVersion=${nextVersion}-SNAPSHOT -P prod
     fi

fi


if [ "$goal" = "install" ] || [ "$goal" = "deploy" ]; then


	case $server in
		MIQ)
			deploy_server_path="/home/mediaiq/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/home/mediaiq/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="aiq.mediaiqdigital.com"
			deploy_server_username="mediaiq"
			deploy_dir="/home/mediaiq/mediaiq-apps/FeedServiceV2"
			;;
		MIQ-Staging)
			deploy_server_path="/home/mediaiq/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/home/mediaiq/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="analytics.mediaiqdigital.com"
			deploy_server_username="mediaiq"
			deploy_dir="/home/mediaiq/mediaiq-apps/feedService-staging/target"
			;;
		Pixel)
			deploy_server_path="/mnt/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/mnt/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="pixel.mediaiqdigital.com"
			deploy_server_username="ubuntu"
			deploy_dir="/mnt/mediaiq-apps/FeedServiceV2"
			;;
		DPI-AMS1)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="54.224.22.43"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		DPI-NYM1)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="54.198.163.224"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		DPI-NYM2)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="54.224.250.15"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		DPI-NYM3)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="54.162.127.87"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		HOK)
			deploy_server_path="/home/bitnami/hok-apps/deployment-backup/feedserviceV2-current"
			backup_path="/home/bitnami/hok-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="54.228.231.159"
			deploy_server_username="bitnami"
			deploy_dir="/home/bitnami/hok-apps/HokFeedService"
			;;
		BI)
			deploy_server_path="/home/ubuntu/applications/deployment-backup/feedserviceV2-current"
			backup_path="/home/ubuntu/applications/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="bi.mediaiqdigital.com"
			deploy_server_username="ubuntu"
			deploy_dir="/home/ubuntu/applications/FeedServiceV2"
			;;
		DPI-Master)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="dpi-feed-master.mediaiqdigital.com"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		DPI-SGP)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="dpi-feed-sgp.mediaiqdigital.com"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
		DPI-Slave-1)
			deploy_server_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-current"
			backup_path="/root/mediaiq-apps/deployment-backup/feedserviceV2-bkp"
			ssh_private_key_file="/build/.ssh/mediaiq-emr.ppk"
			deploy_server_ip="dpi-feed1.mediaiqdigital.com"
			deploy_server_username="root"
			deploy_dir="/root/mediaiq-apps/FeedServiceV2"
			;;
	esac
        
        ssh  -i  ${IDENTITY_FILE}  ${deploy_server_username}@${deploy_server_ip} -t -t "rm -rf  $backup_path/feedsvc*;  mv $deploy_dir/feedsvcV2* $backup_path/;"

        
	rsync -vz -e "ssh -i ${IDENTITY_FILE} " -p --chmod=a+rwx src/main/resources/$profile/feed.properties ${deploy_server_username}@${deploy_server_ip}:${deploy_dir}/feed.properties;

	rsync -vzh target/feedsvcV2_lib/* -e 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2_lib/; 

	if [ "$profile" = "staging" ] && [ "$server" = "MIQ-Staging" ]; then
		echo **** Copying file in $server staging  **** ;
 
		rsync -vzh src/main/resources/logback.xml -e 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2_lib/; 

	else
		echo ****Copying files in $server production **** ;

		rsync -vzh src/main/resources/logback-prod.xml -e 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2_lib/logback.xml; 

	fi

	rsync -vzh src/main/resources/$profile/scripts/feedsvcV2-kill.sh -e 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2-kill.sh;

	rsync -vzh src/main/resources/$profile/scripts/feedsvcV2-start.sh -e 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2-start.sh; 

	rsync -rve 'ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem' target/feedsvc*.jar $deploy_server_username@$deploy_server_ip:$deploy_dir/feedsvcV2.jar; 

	echo **** Copying Done ****

fi


echo **** starting feed-service with $profile profile on $server server ****;
if [ "$goal" = "deploy" ]; then

	if [ "$profile" = "staging" ] && [ "$server" = "MIQ-Staging" ]; then
		echo **** starting feed-service using monit with staging profile on MIQ-Staging server ****;

		ssh  -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem mediaiq@analytics.mediaiqdigital.com -t -t "cd /home/mediaiq/mediaiq-apps/feedService-staging/target; monit start feedsvcV2;";

#		ssh  -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem mediaiq@analytics.mediaiqdigital.com -t -t "cd /mnt/ephemeral2/monitoring/feedservice; ./monitor_feed.sh start;";
	
	elif  [ "$profile" = "prod" ]  && [ "$server" = "MIQ" ]; then
		echo **** starting feed-service with production profile on MIQ server ****;
#		ssh  -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem mediaiq@aiq.mediaiqdigital.com -t -t "cd /home/mediaiq/mediaiq-apps/FeedServiceV2; sudo monit start feedsvcV2;";

		ssh  -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem mediaiq@aiq.mediaiqdigital.com -t -t "cd $deploy_dir/monitoring; ./monitor_feed.sh start;";


	fi

fi

