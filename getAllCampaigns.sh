#!/bin/bash - 
#===============================================================================
#
#          FILE: getAllAdvertisers.sh
# 
#         USAGE: ./getAllAdvertisers.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Monday 09 July 2018 12:31:07  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -x;

for advId in `cat /home/saurav/advertisers/advertisers.txt`;
do
 	auth=`curl -s http://auth.activation.mediaiqdigital.com/auth/appnexus/668`	
	curl -s  --request GET \
		--url "http://api.appnexus.com/campaign?advertiser_id=$advId" \
		--header "authorization: $auth"  >"$advId".txt;

	campaigns=`cat $advId.txt | jq .response.count`;

	echo "No of campaings $campaigns"
	if [ $campaigns -gt 0 ];
	then
		start=0;
		campaigns=`expr $campaigns / 100`

		for i in `seq 1 $campaigns`;
		do

			curl -s  --request GET \
				--url "http://api.appnexus.com/campaign?advertiser_id=$advId&start_element=$start" \
				--header "authorization: $auth"  >>~/campaigns/campaign_"$advId".txt;

			start=`expr $start + 100;`

			sleep 10;

		done
	fi
	rm -f "$advId".txt;

done

