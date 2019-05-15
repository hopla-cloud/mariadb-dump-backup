#!/bin/bash

# check if we are root or not
WHOISIT=`whoami`
[ $WHOISIT != 'root' ] && echo "Ce script doit être lancé avec sudo." && exit 1

function default_value() {
        read -p "Enter $1 (Default: [$2]) : " var
        if [ "$var" = "" ]; then
          var="$2"
        fi
}

mkdir /root/mysql_backup
config_file=/root/mysql_backup/mysql_backup.conf

touch $config_file
echo " " > $config_file

default_value BACKUP_DIR "/var/mysql_backup"
BACKUP_DIR=$var
echo BACKUP_DIR=$BACKUP_DIR >> $config_file

default_value MYSQLBIN "/usr/bin/mysql"
MYSQLBIN=$var
echo MYSQLBIN=$MYSQLBIN >> $config_file

default_value MYSQLDUMPBIN "/usr/bin/mysqldump"
MYSQLDUMPBIN=$var
echo MYSQLDUMPBIN=$MYSQLDUMPBIN >> $config_file

default_value MYSQL_USER "backupuser"
MYSQL_USER=$var
echo MYSQL_USER=$MYSQL_USER >> $config_file

read -p "Enter the $MYSQL_USER password : " -s MYSQL_PASSWORD
echo MYSQL_PASSWORD=$MYSQL_PASSWORD >> $config_file

echo -e "Creating "$MYSQL_USER" account...\nEntrer the mysql root password : "
$MYSQLBIN -u root -p -e "GRANT LOCK TABLES, SELECT ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"