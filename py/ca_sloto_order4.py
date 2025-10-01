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


def main():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Ts111111!",
        database="ca_sloto"
    )
    cursor = conn.cursor()

    dn = 1379
    dn_max = 3988

    total_perms = 0
    for d in range(dn, dn_max + 1):
        try:
            list1, list2, list3, list4 = get_first_four(cursor, d)
            c = generate_combinations(cursor, list1, list2, list3, list4)
            print(f"✅ d={d}, total permutations: {c}")
            total_perms += c
        except Exception as e:
            print(f"⚠️ Error at d={d}: {e}")

    conn.commit()
    print(f"\n🎯 Overall permutations inserted: {total_perms}")

    cursor.close()
    conn.close()


if __name__ == "__main__":
    main()

