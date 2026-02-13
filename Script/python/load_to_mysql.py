"""
RidePulse Analytics
Load to MySQL Script

This script loads the processed CSV file
into the MySQL data warehouse.

Steps:
1. Insert base data into dim_base
2. Insert date data into dim_date
3. Insert records into fact_daily_operations
"""

import pandas as pd
import mysql.connector


# ----------------------------------
# 1. Load processed dataset
# ----------------------------------
df = pd.read_csv("data/processed/uber_daily_operations.csv")


# ----------------------------------
# 2. Connect to MySQL database
# ----------------------------------
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    database="uber_analytics"
)

cursor = conn.cursor()


# ----------------------------------
# 3. Insert unique base codes
# into dim_base
# ----------------------------------
base_codes = df["dispatching_base_number"].unique()

for base in base_codes:
    cursor.execute(
        "INSERT IGNORE INTO dim_base (base_code) VALUES (%s)",
        (base,)
    )

conn.commit()


# ----------------------------------
# 4. Insert unique dates
# into dim_date
# ----------------------------------
unique_dates = df[["date", "year", "month", "weekday"]].drop_duplicates()

date_id_map = {}

for _, row in unique_dates.iterrows():

    # Insert date (ignore if already present)
    cursor.execute(
        """
        INSERT IGNORE INTO dim_date (date, year, month, weekday)
        VALUES (%s, %s, %s, %s)
        """,
        (
            row["date"],
            int(row["year"]),
            int(row["month"]),
            row["weekday"]
        )
    )

    # Get the generated date_id
    cursor.execute(
        "SELECT date_id FROM dim_date WHERE date = %s",
        (row["date"],)
    )

    result = cursor.fetchone()
    date_id_map[row["date"]] = result[0]

conn.commit()


# ----------------------------------
# 5. Insert records into fact table
# ----------------------------------
for _, row in df.iterrows():

    cursor.execute(
        """
        INSERT IGNORE INTO fact_daily_operations
        (base_code, date_id, active_vehicles, trips, trips_per_vehicle)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (
            row["dispatching_base_number"],
            date_id_map[row["date"]],
            int(row["active_vehicles"]),
            int(row["trips"]),
            float(row["trips_per_vehicle"])
        )
    )

conn.commit()


# ----------------------------------
# 6. Close connection
# ----------------------------------
cursor.close()
conn.close()

print("Data loaded into MySQL successfully.")
