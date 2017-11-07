#!/bin/bash -xe 
#===============================================================================
#
#          FILE: release.sh
# 
#         USAGE: ./release.sh  {releaseVersion} {developmentVersion} {repoName}  
# 
#   DESCRIPTION:  Merging maven and git flow release
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#         NOTES: ---
#        AUTHOR: SAURAV OMAR 
#  ORGANIZATION: Media IQ Digital
#       CREATED: Monday 04 March 2017 12:22:09  IST
#      REVISION:  ---
#===============================================================================
_USAGE(){
    echo "Usage:  `basename $0` {releaseVersion} {developmentVersion} {repoName}";    
  
}

[ $# -ne 3 ] && _USAGE && exit 1;

releaseVersion=$1;
developmentVersion=$2;
repoName=$3

# CHANGE THESE BEFORE RUNNING THE SCRIPT!
# Provide an optional comment prefix, e.g. for your bug tracking system
scmCommentPrefix="maven-release-plugin-${repoName}-${releaseVersion}";

# updating local branches
git checkout .

git checkout develop;
git pull origin develop;

git checkout master
git pull origin master


# Start the release by creating a new release branch
git checkout -b release/$releaseVersion develop

# The Maven release
mvn --batch-mode -Darguments=-DskipTests  release:prepare release:perform -Dtag="${repoName}-${releaseVersion}" -DscmCommentPrefix="$scmCommentPrefix" -DreleaseVersion=$releaseVersion -DdevelopmentVersion=$developmentVersion

# check for maven release failed
[ "$?" -ne  0 ] &&  echo " Maven release failed "  && exit 1;

# Clean up and finish
# get back to the develop branch
git checkout develop

# merge the version back into develop
git merge --no-ff -m "$scmCommentPrefix Merge release/$releaseVersion into development" release/$releaseVersion
# go to the master branch
git checkout master
# merge the version back into master but use the tagged version instead of the release/$releaseVersion HEAD
git merge --no-ff -m "$scmCommentPrefix Merge previous version into master to avoid the increased version number" release/$releaseVersion~1
# Removing the release branch
git branch -D release/$releaseVersion
# Get back on the develop branch
git checkout develop
# Finally push everything
git push  --all && git push --tags

