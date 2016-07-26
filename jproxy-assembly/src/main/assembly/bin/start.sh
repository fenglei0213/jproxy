#!/bin/bash

CURRENT_PATH=$(pwd)
SCRIPT_HOME=${CURRENT_PATH%/*}/

CONF_DIR=${SCRIPT_HOME}/conf/
LIB_DIR=${SCRIPT_HOME}/lib
LIB_JARS=$(ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":")

JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "
JAVA_GC_OPTS=" -verbose:gc -Xloggc:$GC_LOG -XX:+PrintGCDetails -XX:+PrintGCDateStamps " 

JAVA_MEM_OPTS=" -server -Xms2g -Xmx10g -Xmn2g -XX:PermSize=512m -XX:MaxPermSize=512m -Xss256K -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "
JAVA_CP=" -classpath $CONF_DIR:$LIB_JARS "
EXTRA_JAVA_OPTS=""
JAVA_BASE_OPTS=""
JAVA_JMX_OPTS=""
JAVA_GC_OPTS=""
JAVA_OPTS="$JAVA_JMX_OPTS $JAVA_GC_OPTS $JAVA_CP"
JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8282,server=y,suspend=n"
RUNJAVA="$JAVA_HOME/bin/java"

$RUNJAVA $JAVA_MEM_OPTS $JAVA_OPTS com.baidu.tieba.fusion.binlog.CanalClient &
echo $? > ${CURRENT_PATH}/fusion_binlog_pid