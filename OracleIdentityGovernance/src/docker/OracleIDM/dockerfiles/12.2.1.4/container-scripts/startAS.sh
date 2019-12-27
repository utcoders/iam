#!/bin/sh
set -x
#
#
#
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
# Author: nevin.cleetus@oracle.com
#
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
#*************************************************************************
# script is used to start a WebLogic Admin server.
#*************************************************************************
export DOMAIN_HOME=$DOMAIN_ROOT/$DOMAIN_NAME

# Start Admin server
LOGDIR=${DOMAIN_HOME}/logs
LOGFILE=${LOGDIR}/as.log
STSFILE=${LOGDIR}/as.status
mkdir -p ${LOGDIR}
rm -f ${LOGFILE} ${STSFILE}

echo "INFO: Starting the Admin Server..."
echo "INFO: Logs = ${LOGFILE}"
$DOMAIN_HOME/bin/startWebLogic.sh > ${LOGFILE} 2>&1 &

statusfile=/tmp/notifyfifo.$$
rm -f "${statusfile}"
mkfifo "${statusfile}" || exit 1
{
  # run tail in the background so that the shell can kill tail when notified 
  # that grep has exited
  tail -F ${DOMAIN_HOME}/servers/AdminServer/logs/AdminServer.log &

  # remember tail's PID
  tailpid=$!

  # wait for notification that grep has exited
  read templine <${statusfile}
  echo ${templine}

  # grep has exited, time to go
  kill "${tailpid}"
} | {
  grep -m 1 "<Notice> <WebLogicServer> <BEA-000360> <The server started in RUNNING mode.>"

  # notify the first pipeline stage that grep is done
  echo "RUNNING" > ${STSFILE}
  echo "INFO: Admin server is running"
  echo > ${statusfile}
}

# clean up
rm -f "${statusfile}"
if [ -f ${STSFILE} ]; then
  echo "INFO: Admin server running, ready to start managed server"
fi