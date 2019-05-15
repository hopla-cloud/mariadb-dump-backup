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

# check if we are root or not
WHOISIT=`whoami`
[ $WHOISIT != 'root' ] && echo "This script must be started with sudo." && exit 1

function default_value() {
        read -p "Enter $1 (Default: [$2]) : " var
        if [ "$var" = "" ]; then
          var="$2"
        fi
}

# Create directory
mkdir -p /root/mysql_backup

# Set config file path
config_file=/root/mysql_backup/mysql_backup.conf

# Create config file and empty it
touch $config_file
echo > $config_file

# Set mysql backup path
default_value BACKUP_DIR "/var/mysql_backup"
BACKUP_DIR=$var
echo BACKUP_DIR=$BACKUP_DIR >> $config_file

# Set mysql binary path
default_value MYSQLBIN "/usr/bin/mysql"
MYSQLBIN=$var
echo MYSQLBIN=$MYSQLBIN >> $config_file

# Set mysqldump binary path
default_value MYSQLDUMPBIN "/usr/bin/mysqldump"
MYSQLDUMPBIN=$var
echo MYSQLDUMPBIN=$MYSQLDUMPBIN >> $config_file

# Set mysql backup user
default_value MYSQL_USER "backupuser"
MYSQL_USER=$var
echo MYSQL_USER=$MYSQL_USER >> $config_file

# Set mysql backup user password
read -p "Enter the $MYSQL_USER password : " -s MYSQL_PASSWORD
echo MYSQL_PASSWORD=$MYSQL_PASSWORD >> $config_file

# Create mysql user
echo -e "Creating "$MYSQL_USER" account...\nEntrer the mysql root password : "
$MYSQLBIN -u root -p -e "GRANT LOCK TABLES, SELECT ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"