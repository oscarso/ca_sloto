#!/bin/bash

# Purpose:
#   Import MySQL schema objects exported by sql/ca_sloto_db_export_all.sh into a new database.
#   Uses two files in the current working directory:
#   - <old_db>_table_create.sql
#   - <old_db>_storedproc_create.sql
#
# Usage:
#   bash sql/ca_sloto_db_import_all.sh
#
# Notes:
#   - Prompts for an "OLD" database name only to locate the exported filenames.
#   - Prompts for a "NEW" database name to create/import into.
#   - Creates the NEW database if it does not exist.
#   - Imports table definitions first, then stored procedures/triggers/events.

# Ask for database name (must match exported filenames)
read -p "Enter OLD database name to exported from: " DB_NAME_OLD
read -p "Enter NEW database name to import into: " DB_NAME_NEW

# Ask for MySQL root password (hidden input)
read -s -p "Enter MySQL root password: " MYSQL_PWD
echo ""

# SQL files (must match export script)
TABLE_SQL="${DB_NAME_OLD}_table_create.sql"
PROC_SQL="${DB_NAME_OLD}_storedproc_create.sql"

# Step 1: Create the database
echo "Creating database $DB_NAME_NEW ..."
mysql -u root -p"$MYSQL_PWD" -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME_NEW\`;"

# Step 2: Import tables
if [[ -f "$TABLE_SQL" ]]; then
  echo "Importing tables into $DB_NAME_NEW ..."
  mysql -u root -p"$MYSQL_PWD" "$DB_NAME_NEW" < "$TABLE_SQL"
else
  echo "⚠️ Table file $TABLE_SQL not found, skipping..."
fi

# Step 3: Import stored procedures, triggers, events
if [[ -f "$PROC_SQL" ]]; then
  echo "Importing stored procedures into $DB_NAME_NEW ..."
  mysql -u root -p"$MYSQL_PWD" "$DB_NAME_NEW" < "$PROC_SQL"
else
  echo "⚠️ Stored procedure file $PROC_SQL not found, skipping..."
fi

echo "Import complete for database '$DB_NAME_NEW'."

