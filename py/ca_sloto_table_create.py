import mysql.connector

# --- DB connection ---
conn = mysql.connector.connect(
    host="localhost",       # change if needed
    user="root",            # your MySQL username
    password="Ts111111!",   # your MySQL password
    database="ca_sloto"     # your database
)
cursor = conn.cursor()

# --- Create table SQL ---
create_table_sql = """
CREATE TABLE IF NOT EXISTS dresult (
    dnum VARCHAR(32) PRIMARY KEY,
    d1   TINYINT UNSIGNED,
    d2   TINYINT UNSIGNED,
    d3   TINYINT UNSIGNED,
    d4   TINYINT UNSIGNED,
    d5   TINYINT UNSIGNED,
    mn   TINYINT UNSIGNED,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
"""

# --- Execute ---
try:
    cursor.execute(create_table_sql)
    conn.commit()
    print("Table 'dresult' created successfully!")
except mysql.connector.Error as err:
    print(f"Error: {err}")

# --- Close connection ---
cursor.close()
conn.close()

