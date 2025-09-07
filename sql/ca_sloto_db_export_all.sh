#!/bin/bash

# Prompt for database name
read -p "Enter database name to export: " DB_NAME

# Prompt for MySQL root password (hidden input)
read -s -p "Enter MySQL root password: " MYSQL_PWD
echo ""

# Define output filenames (consistent with import script)
TABLE_SQL="${DB_NAME}_table_create.sql"
PROC_SQL="${DB_NAME}_storedproc_create.sql"

# Dump stored procedures, triggers, events
mysqldump -u root -p"$MYSQL_PWD" \
  --no-create-info --no-data --no-create-db \
  --routines --triggers --events \
  "$DB_NAME" > "$PROC_SQL"

# Dump table CREATE statements only (no data)
mysqldump -u root -p"$MYSQL_PWD" \
  --no-data \
  "$DB_NAME" > "$TABLE_SQL"

echo "Dump complete: $TABLE_SQL and $PROC_SQL created for database '$DB_NAME'."

