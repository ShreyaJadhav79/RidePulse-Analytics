
""" RidePulse Analytics
Data Transformation Script

This script cleans and transforms the raw Uber dataset.
It creates time-based features and calculates business metrics
before saving the processed file."""


import pandas as pd


# ----------------------------------
# Load raw dataset
# ----------------------------------
file_path = "data/raw/Uber-Jan-Feb-FOIL.csv"
df = pd.read_csv(file_path)

print("Raw data loaded")
print("-" * 40)


# ----------------------------------
# Convert date column to datetime
# ----------------------------------
df["date"] = pd.to_datetime(df["date"])


# ----------------------------------
# Create time-based features
# ----------------------------------
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df["weekday"] = df["date"].dt.day_name()


# ----------------------------------
# Convert numeric columns safely
# ----------------------------------
df["active_vehicles"] = pd.to_numeric(df["active_vehicles"], errors="coerce")
df["trips"] = pd.to_numeric(df["trips"], errors="coerce")


# ----------------------------------
# Remove rows with missing values
# ----------------------------------
df = df.dropna(subset=["active_vehicles", "trips"])


# ----------------------------------
# Create business metric
# Trips per vehicle (efficiency)
# ----------------------------------
df["trips_per_vehicle"] = df["trips"] / df["active_vehicles"]


print("Transformation completed")
print("-" * 40)
print(df.head())


# ----------------------------------
# Save processed data
# ----------------------------------
output_path = "data/processed/uber_daily_operations.csv"
df.to_csv(output_path, index=False)

print("Processed file saved successfully")
