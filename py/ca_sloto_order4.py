import mysql.connector

def get_first_four(cursor, start_dnum):
    cursor.callproc('get_dnum_four_rows', [start_dnum])

    # --- Fetch results ---
    row_lists = []  # will store 4 lists
    for result in cursor.stored_results():
    	rows = result.fetchall()
    	print(f"rows={rows}")
    	for row in rows:
    		row_lists.append(list(row))  # convert each row tuple to list
    return row_lists


def generate_combinations(cursor, list1, list2, list3, list4):
    ctr = 0
    for a in list1:
        for b in list2:
            for c in list3:
                for d in list4:
                   p = f"{a}-{b}-{c}-{d}"
                   ctr += 1 
                   print(f"ctr={ctr}, p={p}")
                   cursor.callproc("upsert_order4", [p])
    return ctr


# Example usage
#list1 = [1, 2, 3, 4, 5]
#list2 = [6, 7, 8, 9, 10]
#list3 = [11, 12, 13, 14, 15]
#list4 = [16, 17, 18, 19, 20]

# --- DB connection ---
conn = mysql.connector.connect(
    host="localhost",     
    user="root",          
    password="Ts111111!", 
    database="ca_sloto"   
)

cursor = conn.cursor()

list1, list2, list3, list4 = get_first_four(cursor, 3988) 
c = generate_combinations(cursor, list1, list2, list3, list4)
print(f"\nTotal permutation: {c}")



conn.commit()

# --- Close connection ---
cursor.close()
conn.close()
