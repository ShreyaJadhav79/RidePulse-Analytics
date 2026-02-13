"""
RidePulse Analytics
Extract & Validate Script

This script loads the raw Uber CSV file
and performs basic validation checks
like structure, columns, and missing values.
"""

import pandas as pd


# -----------------------------
# Load the raw dataset
# -----------------------------
file_path = "data/raw/Uber-Jan-Feb-FOIL.csv"
df = pd.read_csv(file_path)

print("File loaded successfully")
print("-" * 40)


# -----------------------------
# Basic Dataset Information
# -----------------------------

# Number of rows and columns
print("Rows and Columns:")
print(df.shape)
print("-" * 40)

# Column names
print("Column Names:")
print(df.columns.tolist())
print("-" * 40)

# Missing values check
print("Missing Values Per Column:")
print(df.isnull().sum())
print("-" * 40)

# Preview first 5 rows
print("First 5 Rows:")
print(df.head())
