#!/bin/bash

#  This file is part of the mariadb-dump-backup hopla.cloud project (https://github.com/hopla-cloud/mariadb-dump-backup).
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
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