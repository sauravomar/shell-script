#/usr/bin/env bash

_usage(){
   echo "#########################################"
   echo	
   echo " ** Usage `basename $0` fileName ** "
   echo
   echo "#########################################"
   exit;
}

_write_header(){
    echo "********************************">>result.txt
    echo "Id                    Response">>result.txt
    echo "********************************">>result.txt
    echo "">>result.txt
}

_write(){
    local id=$1 
    local result=$2
    echo "$1               $2">>result.txt
}

[ $# -ne 1 ]  &&  _usage;

fileName=$1;
url='https://vaycayhero.com/vrboTest.jsp?id='

[ ! -f $fileName ] && echo " **** $fileName File not exist ****" && exit 1

_write_header;

for id in `cat $fileName` 
do
    result=`curl -L "https://vaycayhero.com/vrboTest.jsp?id=$id" | tr -d '[[:space:]]'`
    echo "$id                 $result" >>result.txt
done




