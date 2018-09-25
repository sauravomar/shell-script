#!/bin/bash - 
#===============================================================================
#
#          FILE: getProfiles.sh
# 
#         USAGE: ./getProfiles.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Monday 10 September 2018 12:38:49  IST
#      REVISION:  ---
#===============================================================================

while read -r campaign_id
do
    echo "Fetching profile for   $campaign_id"
    campaign_response=`curl -s --request GET \
  --url "https://api.appnexus.com/campaign?id=$campaign_id" \
  --header 'authorization: authn:21286:dc06c3a5bc283:nym2'`;

    error_response=`echo $campaign_response | jq .response.error`;
    profile_id=`echo $campaign_response | jq .response.campaign.profile_id`	
    if [ "$error_response" = 'null' ]
    then
	    echo "$campaign_id,$profile_id" >> campaignVSProfileId.txt
    else
	    echo "$campaign_id,$error_response" >> campaignVSProfileId.txt
    fi		    

done < "/home/MIQDIGITAL/sauravomar/campaign"

