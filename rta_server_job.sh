echo "**** Copying files *****"
scp -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem rta-server/target/rta-server-0.0.1-SNAPSHOT-fat.jar  mnt/xvdb/rta/rta_$profile/rta_server
