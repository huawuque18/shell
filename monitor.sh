#/bin/bash
#main 节点宕机检查和重启，需要配置crontab任务
port=`netstat -luntp |grep "udp" |awk '$1 == "udp"'|awk  '{print $4}'|grep ":30310"|wc -l`
TIMEA=`date +%F" "%H:%M:%S`
if [ $port -eq 0 ];then
        echo "${TIMEA} Validator-en has been down"
        /opt/software/main.ton.dev/scripts/run.sh
else
        echo "${TIMEA} Validator-en service is normal"
fi
