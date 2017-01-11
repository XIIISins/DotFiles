#!/bin/bash
# Database Backup script.
#
# Database credentials
DB_USER=root
DB_HOST=127.0.0.1
# Please append password in the xxxxx section below, note that there is
# no space between -p and xxxxx
DB_PASS="-pXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
# Get list of Databases except the pid file
DBS_LIST=$(echo "show databases;"|mysql -u $DB_USER $DB_PASS -h $DB_HOST -N 2>/dev/null )
DBS_IGNORE=""
# Log file
BACKUP_LOG=$HOSTNAME-backup.log
# Backup Base directory
BASE_BAK_FLDR=/backup/mysql/
# Backup rotation period.
RM_FLDR_DAYS="+7"
# From here, only edit if you know what you are doing.
index=0
# Check if we can connect to the mysql server; otherwise die
#if [ ! "$(id -u -n)" = "mysql" ]; then
#        echo -e "Error:: $0 : Only user 'mysql' can run this script"
#        exit 100
#fi
PING=$(mysqladmin ping -u $DB_USER $DB_PASS -h $DB_HOST 2>/dev/null)
if [ "$PING" != "mysqld is alive" ]; then
        echo "Error:: Unable to connected to MySQL Server, exiting !!"
        exit 2
fi
# Backup process starts here.
# Flush logs prior to the backup.
mysql -u $DB_USER $DB_PASS -h $DB_HOST -e "FLUSH LOGS" 2>/dev/null
# Loop through the DB list and create table level backup,
# applying appropriate option for MyISAM and InnoDB tables.
for DB in $DBS_LIST; do

    DB_BKP_FLDR=$BASE_BAK_FLDR/$(date +%d-%m-%Y)/$DB
    [ ! -d $DB_BKP_FLDR ]  && mkdir -p $DB_BKP_FLDR
    # Get the schema of database with the stored procedures.
    # This will be the first file in the database backup folder
    mysqldump -u $DB_USER $DB_PASS -h $DB_HOST -R -d --single-transaction $DB 2>/dev/null | \
            gzip -c > $DB_BKP_FLDR/000-DB_SCHEMA.sql.gz
    index=0
    #Get the tables and its type. Store it in an array.
    table_types=($(mysql -u $DB_USER $DB_PASS -h $DB_HOST -e "show table status from $DB" 2>/dev/null | \
            awk '{ if ($2 == "MyISAM" || $2 == "InnoDB") print $1,$2}'))
    table_type_count=${#table_types[@]}
    # Loop through the tables and apply the mysqldump option according to the table type
    # The table specific SQL files will not contain any create info for the table schema.
    # It will be available in SCHEMA file
    while [ "$index" -lt "$table_type_count" ]; do
      START=$(date +%s)
      TYPE=${table_types[$index + 1]}
      table=${table_types[$index]}
      ctable=${table_types[$index]}

      for SKIP in $DBS_IGNORE; do
        if [ $table == $SKIP ]; then
          echo -e "Ignoring Table: " $table
          ctable='null'
          break
        fi
      done

      if [ $table == $ctable ]; then
        echo -en "$(date) : backup $DB : $table : $TYPE "
        if [ "$TYPE" = "MyISAM" ]; then
            DUMP_OPT="-u $DB_USER $DB_PASS -h $DB_HOST $DB --no-create-info --tables "
        else
            DUMP_OPT="-u $DB_USER $DB_PASS -h $DB_HOST $DB --no-create-info --single-transaction --tables"
        fi
        mysqldump  $DUMP_OPT $table 2>/dev/null|gzip -c > $DB_BKP_FLDR/$table.sql.gz
        echo -e " - Total time : $(($(date +%s) - $START))\n"
        ctable='null'
      fi
      index=$(($index + 2))
    done
done
# Rotating old backup. according to the 'RM_FLDR_DAYS'
if [ ! -z "$RM_FLDR_DAYS" ]; then
    echo -en "$(date) : removing folder : "
    find $BASE_BAK_FLDR/ -maxdepth 1 -mtime $RM_FLDR_DAYS -type d -exec rm -rf {} \;
    echo
fi
