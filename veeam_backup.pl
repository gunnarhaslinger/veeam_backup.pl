#!/usr/bin/perl

use strict;

my $out = "";

my $veeamconfig = "/usr/bin/veeamconfig";
my $job_id = "";
my $job_name = "";
my $session_id = "";
my $job_state = "";
my $sleeptime = 5;
my $hostname = `hostname -f`; chomp($hostname);
my $starttime = time;

# Get Job-ID of configured Veeam Backup Job, in Free-Edition there can only be one Job existent
$out = `$veeamconfig job list`; $job_id = $1 if ($out =~ /(\{[\w\-]+\})/m);
if (!$job_id) { print STDERR "ERROR: Command \"job list\" didn't provide a configured Job-ID!\n\n$out\n\n"; exit 10; }

# Get Job-Info and extract Job-Name
$out = `$veeamconfig job info --id $job_id`; $job_name = $1 if ($out =~ /Name: (\S+)/m);
if (!$job_name) { print STDERR "ERROR: Command \"job info\" didn't provide the Job-Name!\n\n$out\n\n"; exit 20; }

# Start the Veeam Backup Job and get the Session-ID
print timestamp() . " - Starting Veeam Backup-Job Name: $job_name (ID: $job_id) ...\n";
$out = `$veeamconfig job start --id $job_id`;
$session_id = $1 if ($out =~ /^Session ID:\s+\[(\{[\w\-]+\})\]/im);
if (!$session_id) { print STDERR "ERROR: Command \"job start\" didn't provide a Session-ID!\n\n$out\n\n"; exit 30; }

# Wait for Job finishing
do { sleep($sleeptime);
     $out = `$veeamconfig session info --id $session_id`;
     $job_state = $1 if ($out =~ /State:\s+(\S+)/im);
     print timestamp() . " - querying Job Session $session_id State: $job_state\n";
     $sleeptime = 60 if ($job_state =~ /Running/i);
} while ($job_state =~ /Running/i);

print timestamp() . " - Backup-Script execution time: " . sprintf("%.1f", (time-$starttime)/60) . " Minutes.\n";
print timestamp() . " - Finished Job-Monitoring with Job-State: $job_state\n";
if ($job_state =~ /Success/i) { exit 0; }
else { print STDERR "ERROR: Veeam Backup failed on Server $hostname at " . timestamp() ."\n";
       print STDERR "Get details by executing: $veeamconfig session log --id $session_id\n";
       exit 100;
     }

sub timestamp {
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
return sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year+1900, $mon+1, $mday, $hour, $min, $sec);
}
