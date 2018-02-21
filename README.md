# veeam_backup.pl
* Veeam Backup Script for Linux, written in Perl
* Usable in crontab or cron.d 
* If used by cron.d it can send mail to root if not successful

## Does
* Get Veeam Backup Job-ID
* Start Backup-Job
* Wait for Backup-Job finished
* Return Errorcode 0 if OK or other errorcode if error occured
* Writes to STDERR only on Error, to StdOut for Logging

## Demo-Output
* Backup OK
```
2018-02-21 03:11:10 - Starting Veeam Backup-Job Name: NC-FullSystem-Backup (ID: {59d71731-c829-403c-a352-f5024d20349e}) ...
2018-02-21 03:11:19 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:12:19 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:13:19 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:14:19 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:15:23 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:16:24 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:17:24 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:18:27 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:19:28 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Running
2018-02-21 03:20:28 - querying Job Session {6576b8e5-e215-4789-93e2-858f30014a69} State: Success
2018-02-21 03:20:28 - Finished Job-Monitoring with Job-State: Success
```
* Sample-Output, something was wrong, Return-Code >0
```
...
2018-02-21 09:21:09 - Finished Job-Monitoring with Job-State: Failed
ERROR: Veeam Backup failed on Server demosrv1.demo.xyz at 2018-02-21 09:21:09
Get details by executing: /usr/bin/veeamconfig session log --id {59d71731-c829-403c-a352-f5024d20349e}
```
