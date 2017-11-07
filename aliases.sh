#!/bin/bash



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
alias ms="mysql -u root -proot dpim"
alias msdpim="mysql -u root -proot dpim"
alias ws="cd /home/$USER/workspace/"
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
alias start_mongo="sudo mongod --dbpath /home/saurav/data/db --port 27017";
alias topUsage="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head";
alias topProcess="top -b -o +%MEM | head -n 22"
alias topUsageDir="du -hsx * | sort -rh | head -6"
alias open_eclipse="nohup /home/saurav/Downloads/Softwares/eclipse/eclipse  &";
#----------------------------------
#---------execute scripts----------
#----------------------------------

. explain.sh

#Git utility
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


