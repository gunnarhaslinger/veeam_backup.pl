#!/bin/bash

reldir=`dirname $0`
cd $reldir
scriptdir=`pwd`

date=`date +%F_%H-%M-%S`

errorcount=0
LOG=./backup.logs/backup.$date.log.txt

echo "--- Veeam Full System Backup ---" >>$LOG
./veeam_backup.pl >>$LOG
ERR=$?
let errorcount=errorcount+ERR
if [ $ERR != 0 ]; then echo Error while executing Veeam Backup! Veeam Job Start returned: $ERR; fi

exit $errorcount
