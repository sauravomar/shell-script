#bin/bash

PID_HOME='/mnt/xvdb/monitoring/'$APP_NAME;
PID_FILE=$PID_HOME/$APP_NAME.pid;
_start(){
        echo "*** Starting RTA SERVER ***"
        export JAVA_HOME=/usr/lib/jvm/java-8-oracle
        export PATH=$PATH:$JAVA_HOME/bin
        echo $PID_FILE 
        echo $$ > $PID_FILE;
	-javaagent:/home/saurav/.m2/repository/org/springframework/spring-agent/2.5.6/spring-agent-2.5.6.jar
        echo $! > $PID_FILE;
        echo "*** Started RTA SERVER ***"
}

_stop() {
        echo "*** Stopping RTA SERVER ***";
        sudo kill -9 $(cat $PID_FILE);
        for pid in $(ps -ef | grep "rta_server" | awk '{print $2}'); do sudo kill -9 $pid; done
        rm $PID_FILE
}

_restart(){
        _stop
        _start
}

 case "$1" in
        start)
          _start
        ;;
        stop)
         _stop
        ;;
        restart)
         _restart
        ;;
      *)

        echo 'Usage: rta_server.sh {start|stop|restart}';
        exit 1
 esac

 exit $RETVAL

