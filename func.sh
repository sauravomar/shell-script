#/usr/bin/env bash

deploy(){
   projectName=$1;
   [ $# -eq 0 ] && projectName="zaranga"
   [ ! -d $VAYCAY_WORKSPACE/$projectName ]  && echo "***  Error $projectName not exist ***" && exit 1;
   echo $VAYCAY_WORKSPACE/$projectName;
   cd $VAYCAY_WORKSPACE/$projectName;
   mvn install -P t8 
   echo "Stopping tomcat"
   st
   echo "Starting tomcat"
   St
}

st(){
 . /home/$USER/deployment/apache-tomcat-8.0.21/bin/catalina.sh  "start" ; tailf ${CATALINA_HOME}/logs/catalina.out
}

St(){
. /home/$USER/deployment/apache-tomcat-8.0.21/bin/catalina.sh "stop"
}

dump(){
        [ $# -ne 1 ] && echo "Enter file Name " && exit 1;
	`mysqldump  -u root -proot zaranga_prod $1 > $1.sql`
}
