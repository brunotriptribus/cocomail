#! /usr/bin/env bash
set -e # exit on error

# Variables
export MYSQL_USER=${MYSQL_USER:-"myuser"}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:-"superpass"}
export MYSQL_DATABASE=${MYSQL_DATABASE:-"mails"}
export DB_TYPE=${DB_TYPE:-"mysql"}
export MAIL_DOMAIN=${MAIL_DOMAIN:-"example.com"}
export DB_HOST=${DB_HOST:-"coco.com"}
export IMAP=${IMAP:-"coco.com"}
export SMTP=${SMTP:-"coco.com"}
export TIMEZONE=${TIMEZONE:-"America/Toronto"}

export ALREADY_SETUPED=/etc/configured 

# Validation des variables !!
if [ "$ADM_MAIL" == "NOT_DEFINE" ] ; then
    echo 'You need to set variable $ADM_MAIL !! '
    echo "I already set all the software , I can't choose your username ;) "
    exit 1
fi
if [ "$ADM_PASS" == "NOT_DEFINE" ] ; then
    echo 'You need to set variable $ADM_PASS !! '
    echo "I already set all the software , I can't choose your PASSWORD ;) "
    exit 1
fi

# Templates
j2 /root/config.inc.php.j2 > /var/www/html/config/config.inc.php
j2 /root/php.ini.j2 > /usr/local/etc/php/conf.d/php.ini
# Démarrage du processus apache2 en background 
apache2-foreground &

# en attente de l'initialisation de apache TODO : mettre une solution plus belle
sleep 5

# est-ce que le conteneur est deja configurer ?? 
if [ ! -e $ALREADY_SETUPED ] ; then


    # Creation du fichier pour indiquer que le conteneur est configurer
    touch $ALREADY_SETUPED

fi # END if [ -e $ALREADY_SETUPED ] 

# Show apache logs : TODO : revoir la stratégie
tail -f /var/log/apache2/access.log /var/log/apache2/error.log
