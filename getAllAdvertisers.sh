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

curl -s  --request GET \
	--url http://api.appnexus.com/advertiser \
	--header 'authorization: authn:21286:9b4528db70c33:nym2'  >advertisers.txt

advertisers=`cat advertisers.txt | jq .response.count`;

echo "No of advertisers $advertisers"

start=0;
advertisers=`expr $advertisers / 100`

for i in `seq 1 $advertisers `;
do

	curl -s  --request GET \
		--url "http://api.appnexus.com/advertiser?start_element=$start" \
		--header 'authorization: authn:21286:9b4528db70c33:nym2'  >~/advertisers/advertisers_"`expr $start / 100`".txt

	start=`expr $start + 100;`

	sleep 30;

done



