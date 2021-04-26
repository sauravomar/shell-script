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
alias ms="mysql -u root -proot"
alias ws="cd ~/workspace/"
alias scripts="cd /home/saurav/scripts"
alias gt="git status " 
alias diff="git diff "
alias build=" mvn clean  install" 
alias monitor=". monitor.sh" 
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
# You can use whatever you want as an alias, like for Mondays:
alias start_mongo="sudo mongod --dbpath /home/saurav/data/db --port 27017";
alias topUsage="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head";
alias topProcess="top -b -o +%MEM | head -n 22"
alias topUsageDir="du -hsx * | sort -rh | head -6"
alias open_eclipse="nohup /home/$USER/Downloads/Software/eclipse/eclipse  &";
alias dpim=" mysql -h dpi.cmfydxrklw15.us-east-1.rds.amazonaws.com -P 3306  -ubidder  -pQIU1psosSDFSo567 dpim";
alias segsvc=" mysql -h dpi.cmfydxrklw15.us-east-1.rds.amazonaws.com -P 3306  -useg_svc  -pQIU1psosSDFSo567 segmentservice";
alias apd=" ssh -i ~/ssh-keys/mediaiq-emr.pem ubuntu@apd.activation.mediaiqdigital.com";
alias apd-staging="ssh -i ~/ssh-keys/mediaiq-emr.pem root@apd-staging.mediaiqdigital.com";
alias apd_prod_db="mysql -h activation-apd.cmfydxrklw15.us-east-1.rds.amazonaws.com -P 3306  -uapduser  -pAURzS#t4qL6\\&?yGE apd";
alias branch="git rev-parse --abbrev-ref HEAD";
alias httpError='cat requests.log  | grep "HTTP/1\.[01]\" 5.." > temp.txt';
alias goto_iaas='ssh 10.34.233.61'
alias goto_ssm_ops="ssh ssm@10.32.110.122"
alias goto_hercules="ssh ssm@10.32.38.40"
alias subl="open -a /Applications/Sublime\ Text\ 2.app/" 
alias git_log="git log --graph --abbrev-commit --decorate --date=format:'%Y-%m-%d %H:%M:%S' --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
#----------------------------------
#---------execute scripts----------
#----------------------------------

. commands.sh

#Git utility
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

ssh-add ~/ssh-keys/*
