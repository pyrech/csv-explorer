#!/bin/bash

MYSQL_ARGS="-h mysql -u root -pyolo"
DB="explorer"
DELIM=";"

CSV="$1"
TABLE="data"

[ "$CSV" = "" ] && echo "Syntax: $0 csvfile" && exit 1

[ "$CSV" = "" -o "$TABLE" = "" ] && echo "Syntax: $0 csvfile tablename" && exit 1

FIELDS=$(head -1 "$CSV" | perl -p -e 's/'$DELIM$DELIM'/"'$DELIM'col1".++$i."'$DELIM'"/ge' | perl -p -e 's/'$DELIM$DELIM'/"'$DELIM'col2".++$i."'$DELIM'"/ge' | sed -e 's/'$DELIM'/` text,\n`/g' -e 's/\r//g')
FIELDS='`'"$FIELDS"'col_extra` varchar(255)'

mysql $MYSQL_ARGS -e "
CREATE DATABASE IF NOT EXISTS $DB;
"

mysql $MYSQL_ARGS $DB -e "
DROP TABLE IF EXISTS $TABLE;
CREATE TABLE $TABLE ($FIELDS);

LOAD DATA INFILE '/app/$CSV' INTO TABLE $TABLE
FIELDS TERMINATED BY '$DELIM'
IGNORE 1 LINES
;
"
