#!/bin/sh
set -e 
/usr/bin/supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf 
$@

# /usr/sbin/crond   -f  -L  /var/log/cron/cron.log