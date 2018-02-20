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
