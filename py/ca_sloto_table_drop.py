import mysql.connector
import argparse

# --- Setup argument parser ---
parser = argparse.ArgumentParser(description="Drop a MySQL table.")
parser.add_argument("table", help="Name of the table to drop")
args = parser.parse_args()

# --- DB connection ---
conn = mysql.connector.connect(
    host="localhost",
    user="root",          # change to your MySQL user
    password="Ts111111!", # change to your MySQL password
    database="ca_sloto"   # change to your database
)
cursor = conn.cursor()

# --- Drop table ---
drop_sql = f"DROP TABLE IF EXISTS `{args.table}`"
try:
    cursor.execute(drop_sql)
    conn.commit()
    print(f"Table '{args.table}' dropped successfully!")
except mysql.connector.Error as err:
    print(f"Error: {err}")

# --- Close connection ---
cursor.close()
conn.close()

