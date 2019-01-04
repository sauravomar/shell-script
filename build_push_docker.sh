#!/bin/bash - 
#===============================================================================
#
#          FILE: build_push_docker.sh
# 
#         USAGE: ./build_push_docker.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: Monday 16 October 2017 02:50:35  IST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

_USAGE(){
	echo "Usage:  `basename $0` {folder contains DockerFile} {repoName} {tagname} {profile}";

}

[ $# -ne 4 ] && _USAGE && exit 1;

_folder=$1;
_repo_name=$2;
_tag_name=$3
_profile=$4
_ecr_url="739562352557.dkr.ecr.us-east-2.amazonaws.com";
#-------------check docker file is present-----------------------
[ ! -f ${_folder}/Dockerfile ]  && echo "** Docker File is not present  ${_folder} **" && exit 1;

sudo docker build -t ${_repo_name}:${_tag_name} ${_folder}  --build-arg profile=$_profile  --build-arg token=NDc5OWEyYzdmMzA1

#---- check for docker build success full ------------
[ "$?" -ne  0 ] &&  echo "** Docker build failed ** "  && exit 1;

#----------------login to aws ecs-----------------------
sudo `aws ecr get-login --region us-east-2 | sed -e "s/-e none//"`
[ $? -ne 0 ] && echo "Invalid Credentials Please check ${HOME}/.aws/credentials " && exit 1;

#--------Tag Docker image -----------------------------
sudo docker tag ${_repo_name}:${_tag_name} ${_ecr_url}/${_repo_name}:${_tag_name};


#--------Push Docker image to ecs------------------------------
sudo docker push ${_ecr_url}/${_repo_name}:${_tag_name};


#---- check for docker push success ------------
[ "$?" -ne  0 ] &&  echo "** Docker push failed ** "  && exit 1;

echo "***********Successfully Pushed ${_repo_name}:${_tag_name} *******";









