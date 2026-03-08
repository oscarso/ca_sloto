"""Purpose:
  Generate 4-number permutations from 4 consecutive rows in `dresult` and upsert
  them into the `order4` table using stored procedures.

Usage:
  python3 py/ca_sloto_order4.py

Notes:
  - Requires schema objects created by sql/ca_sloto_sql_init.sql:
    - table: order4
    - procedures: get_rows_4, order4_upsert
  - MySQL connection settings are currently hardcoded in main().
  - The start/end draw numbers are currently hardcoded (dn/dn_max).
"""

import mysql.connector

def get_first_four(cursor, start_dnum):
    """Fetch the first 4 rows starting at `start_dnum` using stored procedure `get_rows_4`.

    Returns a list of 4 lists. Each inner list corresponds to one row returned by the
    procedure (typically [d1, d2, d3, d4, d5]).
    """
    cursor.callproc('get_rows_4', [start_dnum])

    # --- Fetch results ---
    row_lists = []  # will store 4 lists
    for result in cursor.stored_results():
        rows = result.fetchall()
        print(f"rows={rows}")
        for row in rows:
            row_lists.append(list(row))  # convert each row tuple to list
    return row_lists


def generate_combinations(cursor, list1, list2, list3, list4):
    """Generate all 4-way combinations and upsert them into `order4`.

    For each combination, calls stored procedure `order4_upsert(p)` where `p` is
    formatted as "<a>-<b>-<c>-<d>".

    Returns the number of permutations generated.
    """
    ctr = 0
    for a in list1:
        for b in list2:
            for c in list3:
                for d in list4:
                    p = f"{a}-{b}-{c}-{d}"
                    ctr += 1
                    #print(f"ctr={ctr}, p={p}")
                    cursor.callproc("order4_upsert", [p])
    return ctr


def main():
    """Connect to MySQL, iterate through a draw-number range, and populate `order4`."""
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Ts111111!",
        database="test1"
    )
    cursor = conn.cursor()

    dn = 1379
    dn_max = 1383 

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

