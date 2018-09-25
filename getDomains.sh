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

auth_token='authn:21286:596d4c9aba733:lax1';

while read -r profile_id
do
	echo "Fetching domain for   $profile_id";
	profile=`echo $profile_id | cut -f2 -d','`;
	profile_response=`curl -s --request GET \
		--url "https://api.appnexus.com/profile?id=$profile" \
		--header "authorization: $auth_token"`;

	error_response=`echo $profile_response | jq .response.error`;
	domain_list_action=`echo $profile_response | jq .response.profile.domain_list_action`;
	domain_list_id=`echo $profile_response | jq '.response.profile.domain_list_targets[].id' | paste -s -d ','`

	if [ "$error_response" = 'null' ]
	then
		echo "$profile_id,$domain_list_action, [$domain_list_id]" >> profile_domains.txt;
	else
		echo "$profile_id,$error_response" >> profile_domains.txt;
	fi 

#	#for domain_id in `echo $profile_response | jq '.response.profile.domain_list_targets[].id'`;
#	#do
#	#	echo "domain fetch $domain_id"
#	#	domain_response=`curl -s --request GET \
#			--url "https://api.appnexus.com/domain-list?id=$domain_id" \
#			--header "authorization: $auth_token"`;
#
#		error_response=`echo $domain_response | jq .response.error`;
#
#		domains=`echo $domain_response | jq '.response["domain-list"].domains';`;
#		domainid=`echo $domain_response | jq '.response["domain-list"].id';`
#
#		if [ "$error_response" = 'null' ]
#		then
#			echo "$domain_id, $domains" >>domains_id_list.txt;
#		else
#			echo "$domain_id, $error_response" >>domains_id_list.txt;
#		fi
#
#	done    
done < "/home/MIQDIGITAL/sauravomar/scripts/campaignVSProfileId.txt"


