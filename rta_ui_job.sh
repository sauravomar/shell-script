cd rta-ui
npm install
grunt build:$profile

rsync -rave "ssh -i /build/.jenkins/jobs/DataSift/mediaiq-emr.pem -l mediaiq" dist ubuntu@54.81.29.103:/mnt/xvdb/rta/rta_$profile/rta_ui

