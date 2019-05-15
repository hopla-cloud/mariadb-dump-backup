#!/bin/bash
# import config file
source /root/mysql_backup/mysql_backup.conf
TIMESTAMP=$(date +%Y%m%d-%H%M)
 
# List databases to dump
databases=`$MYSQLBIN --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql)"`

# Dump databases
for db in $databases; do
  mkdir -p "$BACKUP_DIR/$db"
  $MYSQLDUMPBIN --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db/$db-$TIMESTAMP.sql.gz"
done

# Delete dump
find $BACKUP_DIR/ -type f -cmin +660 -exec rm -rf {} \;