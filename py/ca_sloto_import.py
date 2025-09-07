import mysql.connector
import argparse

# --- Setup argument parser ---
parser = argparse.ArgumentParser(description="Import CSV into MySQL table dresult.")
parser.add_argument("filename", help="CSV file to read")
args = parser.parse_args()

# --- DB connection ---
conn = mysql.connector.connect(
    host="localhost",     
    user="root",          
    password="Ts111111!", 
    database="ca_sloto"   
)
cursor = conn.cursor()

# --- Prepare SQL Insert ---
insert_sql = """
INSERT INTO dresult (dnum, d1, d2, d3, d4, d5, mn)
VALUES (%s, %s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE
d1=VALUES(d1), d2=VALUES(d2), d3=VALUES(d3),
d4=VALUES(d4), d5=VALUES(d5), mn=VALUES(mn),
updated_at=CURRENT_TIMESTAMP
"""

# --- Read file & insert rows ---
with open(args.filename, "r") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue  # skip blank lines

        # remove trailing semicolon, split by ";"
        parts = line.strip(";").split(";")

        if len(parts) != 7:
            print(f"Skipping malformed line: {line}")
            continue

        dnum, d1, d2, d3, d4, d5, mn = parts
        values = (dnum, d1, d2, d3, d4, d5, mn)

        cursor.execute(insert_sql, values)

# --- Commit changes ---
conn.commit()

# --- Count total records ---
cursor.execute("SELECT COUNT(*) FROM dresult")
total_records = cursor.fetchone()[0]

# --- Close connection ---
cursor.close()
conn.close()

print(f"Data inserted successfully! Total records in dresult: {total_records}")

