import mysql.connector
import csv
import argparse

# setup argparse
parser = argparse.ArgumentParser(description="Export MySQL query results to CSV.")
parser.add_argument("filename", help="Output CSV file name")
args = parser.parse_args()

# connect to database
conn = mysql.connector.connect(
    host="localhost",     # change if not local
    user="root",          # replace with your MySQL user
    password="Ts111111!", # replace with your password
    database="ca_sloto"   # replace with your database name
)

cursor = conn.cursor()
cursor.execute("SELECT dnum, d1, d2, d3, d4, d5, mn FROM dresult")

# write results to user-provided file
with open(args.filename, "w", newline="") as f:
    writer = csv.writer(f, delimiter=";")  # semicolon delimiter
    writer.writerows(cursor.fetchall())     # no header

cursor.close()
conn.close()

