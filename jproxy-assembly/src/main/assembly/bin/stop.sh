#!/bin/bash

#cat ${CURRENT_PATH}/fusion_binlog_pid | kill
ps -ef | grep com.baidu.tieba.fusion.binlog.CanalClient | awk '{print $2}' | xargs kill