#!/bin/bash
# chkconfig: 2345 88 14
# description: Starts and Stops the carservers daemon.

# /local/carservers.sh &
#vi  /etc/sysconfig/iptables
#service iptables restart
#netstat -tunlp
#telnet 115.159.114.25 22133
basepath=$(cd `dirname $0`; pwd)
#echo $basepath
#java -jar /local/kestrelLogic/kestrel-logic.jar  &
#/local/web/kestrel-2.4.1/scripts/devel.sh &
#/local/web/memcached/memcached-startup.sh 11211 &

#/local/run/redis-server/8501/redis-server /local/run/redis-server/8501/redis.conf &
#/local/run/redis-server/8333/redis-server /local/run/redis-server/8333/redis.conf &
#/local/run/redis-server/8102/redis-server /local/run/redis-server/8102/redis.conf &
#/local/run/redis-server/8103/redis-server /local/run/redis-server/8103/redis.conf &


#查看启动状态
#ps aux|grep /local/kestrelLogic/kestrel-logic.jar |grep -v grep|awk '{print $2}'
#ps aux|grep /local/web/memcached/memcached/bin/memcached |grep -v grep|awk '{print $2}'
#ps aux|grep kestrel_2.9.2-2.4.1.jar |grep -v grep|awk '{print $2}'



PRO_NAME=""
execfile=""

function watch()
{		
		echo watch#############################
		#用ps获取$PRO_NAME进程数量 把下面的语句用括号 括起来才能赋值到数组 否则 就变成一行
		PIDS=($(ps aux|grep ${PRO_NAME} |grep -v grep|awk '{print $2}'))
		NUM=${#PIDS[@]}
		killstatus=0
    echo NUM == $NUM
    #少于1，重启进程 
    if [ "${NUM}" -lt "1" ];then
      echo "${PRO_NAME} was killed"
      killstatus=1
    #大于1，杀掉所有进程，重启 
    elif [ "${NUM}" -gt "1" ];then
      echo "more than 1 ${PRO_NAME},killall ${PRO_NAME}"
      killstatus=1
    fi
	
		echo killstatus == $killstatus
    #kill僵尸进程 > 0 
    #NUM_STAT=$(ps aux | grep ${PRO_NAME} | grep T | grep -v grep | wc -l)
	  #echo 僵尸进程 $NUM_STAT
    #if [ $NUM_STAT -gt "0" ];then
    #  killstatus=1
    #fi
	
	
	 	echo killstatus == $killstatus
    if [ $killstatus -eq "1" ];then
       for pid in ${PIDS[*]}
       do
         echo $pid
         kill -9 $pid
       done
			 echo "重启程序"
       #$execfile
       sudo  teamviewer daemon restart && teamviewer &
    fi
		echo watch#############################
}


function watch_jiangshi()
{
		echo watch_jiangshi
		#用ps获取$PRO_NAME进程数量 把下面的语句用括号 括起来才能赋值到数组 否则 就变成一行
		PIDS=($(ps aux|grep ${PRO_NAME} |grep -v grep|awk '{print $2}'))
		NUM=${#PIDS[@]}
		killstatus=0

		echo killstatus == $killstatus
    #kill僵尸进程 > 0 
    NUM_STAT=$(ps aux | grep ${PRO_NAME} | grep T | grep -v grep | wc -l)
	  echo 僵尸进程 $NUM_STAT
    if [ $NUM_STAT -gt "0" ];then
      killstatus=1
    fi
	
	
	 	echo killstatus == $killstatus
    if [ $killstatus -eq "1" ];then
       for pid in ${PIDS[*]}
       do
         echo $pid
         sudo kill -9 $pid
       done
			 echo "重启程序"
       #$execfile 
			 sudo  teamviewer daemon restart && teamviewer &
    fi

		echo watch_jiangshi##############################
}


 PRO_NAME="/opt/teamviewer/tv_bin/wine/bin/wineserver"
 execfile="sudo  teamviewer daemon restart && teamviewer &"
 watch_jiangshi

 PRO_NAME='c:\\TeamViewer\\TeamViewer.exe'
 execfile="sudo  teamviewer daemon restart && teamviewer &"
 watch
exit 0
