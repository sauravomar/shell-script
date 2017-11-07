#!/bin/bash -x

#---------------------------------------
#------- CLEAN UP EPHEMEREAL2-----------
#---------------------------------------

find /mnt/ephemeral2/googleDbm/dbm/csv/ -type f -name "processed*" -mtime 1 -exec rm {} \;
find /mnt/ephemeral2/googleDbm/dbm/lookup -type f -mtime +5 -exec rm {} \;
find /mnt/ephemeral2/flashtalk_performance/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/flashtalk_transaction/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/arbor_data_us/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/arbor_crossdevice/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/arbor_data/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/eyeota/ -type f -mtime +0 -exec rm {} \;
find /mnt/ephemeral2/feed-tmp/exelate-feed/ -type f -mtime +5 -exec rm {} \;

#---------------------------------------
#------- CLEAN UP EPHEMEREAL1-----------
#---------------------------------------


find /mnt/ephemeral1/ftp_home/exelate_sftpuser/incoming -type f -mtime +7 -exec rm -f {} \;
find /mnt/ephemeral1/ftp_home/vdna_sftpuser/incoming/ -type f -mtime +3 -exec rm -f{} \;
find /mnt/ephemeral1/ftp_home/lotame_sftpuser/incoming/upload/ -mtime +10 -exec rm -rf {} \; > /dev/null 2>&1
find /mnt/ephemeral1/ftp_home/zl_ftpuser/incoming/ -type f -mtime +30 -exec rm {} \;
find /mnt/ephemeral1/ftp_home/wm_ftpuser/outgoing/ -type f -mtime +30 -exec rm {} \;
find /mnt/ephemeral1/feed-tmp/adsafe/outbound/ -name "*.gz" -type f -mtime +3 -exec rm {} \;
find /mnt/ephemeral1/feed-tmp/adsafe-video/outbound/ -name "*.gz" -type f -mtime +3 -exec rm {} \;
find /mnt/ephemeral1/feed-tmp/adsafe-dbm-video/outbound/ -name "*.gz" -type f -mtime +10 -exec rm {} \;
find /mnt/ephemeral1/feed-tmp/adsafe-dbm-miq/outbound/ -name "*.gz" -type f -mtime +10 -exec rm {} \;
find /mnt/ephemeral1/ftp_home/mediashot_sftpuser/incoming/ -type f -mtime +4 -exec rm  -f{} \;

#---------------------------------------
#------- CLEAN UP TMP ------------------
#---------------------------------------

find /tmp/ -maxdepth 1 -type d -name "tomcat.*" -mmin +60 -exec rm -rf {} \;

#---------------------------------------
#------- CLEAN UP MEDIAIQ-DATA----------
#---------------------------------------

find /mediaiq-data/toDownload/lwd/ -type f -mtime +2 -exec rm {} \;
find /mediaiq-data/dpi-sync-tmp/ -type f -mtime +5 -exec rm {} \;
find /mediaiq-data/aiq -type f -mtime +1 -exec rm {} \;

#---------------------------------------
#------- CLEAN UP EPHEMEREAL2-----------
#---------------------------------------


find /home/mediaiq/mediaiq-apps/adhoc-reports -type f -mtime +3 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/feed-tmp -type f -mtime +5 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/Datasift/data/tsv -name "*.tsv" -type f -mtime +2 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/Datasift/data/json -name "*.json" -type f -mtime +2 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/feed-tmp/appnexus/ -type f -mtime +0 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/UserId-Data/unique_userids -type f -mtime +3 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/UserId-Data/exelate-feed -type f -mtime +3 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/UserId-Data/appnexus_batch -type f -mtime +7 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/datonics_feed/data/processed -type f -mtime +4 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/datonics_feed/mobile-data/processed -type f -mtime +4 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/visualdna-data/upload/processed -type f -mtime +3 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/visualdna-data/brand-survery/processed -type f -mtime +3 -exec rm -f{} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/mediacom-data/log-data/ -type f -mtime +4 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/FtpOutbound/lotame-feed/upload -mtime +30 -exec rm -rf {} \; > /ev/null 2>&1
find /home/mediaiq/mediaiq-apps/aiq-reports/zipped -type f -mtime +3 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/hourly/ -type f -mtime +1 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/SegmentService/dpi-upload -type f -mtime +1 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/tomcat-segmentservice/temp/s3tmp/segmentservice/ -name "*final.gz" -type f -mtime +2 -exec rm {} \;
find /home/mediaiq/mediaiq-apps/scripts/srs_reports_abg -name "day_numeric=2015*" -type d -mtime +2 -exec rm -rf {} \; > /dev/null 2>&1
find /home/mediaiq/mediaiq-apps/FtpOutbound/mediashot-data/ -type f -mtime +4 -exec rm {} \;

cd /home/mediaiq/mediaiq-apps/MediaIQUtilService
./cleanup-cls-refresh.sh

#---------------------------------------
#------- AEROSPIKE CLEANUP--------------
#---------------------------------------


ssh -i /home/mediaiq/.ssh/mediaiq-emr.pem root@54.84.3.34 'find /root/aerospike/xdsp/load-apn-dbm/ -type f -mtime +2 -exec rm {} \;' 
ssh -i /home/mediaiq/.ssh/mediaiq-emr.pem root@54.84.3.34 'find /root/aerospike/xdsp/dbm_apn/ -type f -mtime +2 -exec rm {} \;'
ssh -i /home/mediaiq/.ssh/mediaiq-emr.pem root@54.84.3.34 'find /root/aerospike/xdsp/apn_dbm/ -type f -mtime +2 -exec rm {} \;'
ssh -i /home/mediaiq/.ssh/mediaiq-emr.pem root@54.84.3.34 'find /root/aerospike/xdsp/logs/ -type f -mtime +10 -exec rm {} \;'

# Delete from segment service staging
mysql -h dpi.cmfydxrklw15.us-east-1.rds.amazonaws.com -u seg_svc -pQIU1psosSDFSo567 segmentservice -e  "delete from segmentservice_staging.scheduled_queries; delete from segmentservice_staging.under_process_queries;"

