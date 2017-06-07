#!/bin/bash - 
#===============================================================================
#
#          FILE: create_sftp_users.sh
# 
#         USAGE: ./create_sftp_users.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: SAURAV OMAR (), 
#  ORGANIZATION: 
#       CREATED: Thursday 06 April 2017 05:14:05  IST
#      REVISION:  ---
#===============================================================================

_USAGE(){
    echo "Usage:  `basename $0` {USERNAME} {HOME_DIRECTORY}";

}

[ $# -ne 2 ] && _USAGE && exit 1;

_username=$1;
_home_directory=$2

useradd -g sftpusers -d ${home_directory} -s /sbin/nologin ${_username};
passwd ${_username};
sudo mkdir ftp_home/${_username}/incoming
chown ${sftpusers}:sftpusers incoming
chmod 777 incoming;



