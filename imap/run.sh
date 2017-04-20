#! /usr/bin/env bash
set -e # exit on error

# Variables
export DB_HOST=${DB_HOST:-"coco-db-t"}


# Templates
j2 /root/dovecot-sql.conf.ext.j2 > /etc/dovecot/dovecot-sql.conf.ext 

# Launch
rm -f /var/run/dovecot/*.pid  
exec /usr/bin/supervisord -n
