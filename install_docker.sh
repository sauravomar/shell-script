#!/bin/bash - 
#===============================================================================
#
#          FILE: install_docker.sh
# 
#         USAGE: ./install_docker.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Tuesday 17 July 2018 12:44:03  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
sudo apt-get update;
yes Y | sudo apt-get install \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common ;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable";
sudo apt-get update;
yes Y | sudo apt-get install docker-ce;
