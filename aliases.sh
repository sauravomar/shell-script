#!/usr/bin/env bash



#----------------------------
#---------Variables----------
#----------------------------

USER=`who | cut -d ' ' -f1 | head -1`


#----------------------------
#-----Aliases----------------
#-----------------------------


alias ,="cd .."
alias ,,="cd ../../"
alias ,,,="cd ../../../"
alias ,,,,="cd ../../../../"
alias ,,,,,="cd ../../../../../"
alias ,,,,,,="cd ../../../../../../../"
alias tomcat="cd /home/saurav/deployment/apache-tomcat-8.0.21/webapps"
alias ms="mysql -u root -proot zaranga_prod"
alias ws="cd /home/$USER/workspace/zaranga"
alias dep="cd /home/$USER/deployment"
alias scripts="cd /home/saurav/scripts"
alias svnst="svn status" 
alias gt="git status" 
alias diff="git diff"
alias build=" mvn clean  install -P t8" 
alias clearLogs="rm -f ${cATALINA_HOME}/logs/*"
alias monitor=". monitor.sh" 
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
# You can use whatever you want as an alias, like for Mondays:
alias FUCK='fuck'

#----------------------------------
#---------execute scripts----------
#----------------------------------

. func.sh
. explain.sh

