# RidePulse Analytics — Uber Trip Data Analytics Project 🚖📊  

Welcome to **RidePulse Analytics**, an end-to-end data analytics project built using **Python**, **MySQL**, and **SQL**.  
This project covers the full journey of data — from raw CSV files to meaningful business insights using a structured data model.

Designed as a portfolio project, RidePulse Analytics shows how real-world ride data can be cleaned, stored, and analyzed to answer practical business questions.

---

## 🏗️ Project Overview  

This project follows a simple analytics workflow:  

1. **Data Extraction & Validation** – Loaded raw Uber trip data from CSV files using Python.  
2. **Data Transformation** – Cleaned data, created time features, and calculated useful metrics.  
3. **Data Modeling** – Built fact and dimension tables in MySQL.  
4. **Data Loading** – Inserted transformed data into MySQL using Python connectors.  
5. **Data Analytics** – Answered real business questions using SQL queries.  

🎯 The goal of this project was to understand how raw data becomes useful insights through proper structure and queries.

---

## 🧩 Key Objectives  

- Store raw trip data in a clean and structured format.  
- Transform data for analysis using Python.  
- Design a simple **fact and dimension model** in MySQL.  
- Write SQL queries to answer business questions.  
- Practice end-to-end data analytics workflow.

---

## 🏗️ Data Architecture  

The project uses a simple warehouse-style structure:  

1. **Raw Layer** — Original CSV file (Uber trip data).  
2. **Processed Layer** — Cleaned and transformed dataset created using Python.  
3. **Database Layer** — MySQL database with:
   - `dim_base`  
   - `dim_date`  
   - `fact_daily_operations`  
4. **Analytics Layer** — SQL queries to answer business questions.

---

## 🛠️ Tools & Technologies  

- **Python** – Data cleaning, transformation, and loading  
- **MySQL** – Database for storing fact and dimension tables  
- **MySQL Workbench** – Running SQL queries  
- **Pandas** – Data processing  
- **SQL** – Business analysis queries  

---

## 📂 Project Structure  

RidePulse-Analytics
│
├── dataset
│   ├── raw
│   │   └── Uber-Jan-Feb-FOIL.csv
│   └── processed
│       └── uber_daily_operations.csv
│
├── script
│   ├── python
│   │   ├── extract_validate.py
│   │   ├── transform_data.py
│   │   └── load_to_mysql.py
│   │
│   └── sql
│       ├── init_database.sql
│       └── analytics_queries.sql
│
├── README.md
└── LICENSE

---

## 📊 Business Questions Answered  

This project answers real analytical questions such as:  

1. Which base generated the highest total trips?  
2. Which month had the highest demand?  
3. Which weekday has the most trips?  
4. Which base is most efficient (trips per vehicle)?  
5. Top 3 dates with highest trips.  
6. Lowest 3 dates by trips.  
7. Ranking bases by total trips.  
8. Month-wise performance of each base.  
9. Most productive weekday (efficiency-wise).  
10. Demand trend over time using rolling averages.  

Each question is written and solved using SQL queries in the `analytics_queries.sql` file.

---

## 🚀 Learning Outcomes  

Through this project, I learned:  
- How to clean and prepare raw data using Python  
- How to design fact and dimension tables  
- How to load data into MySQL using Python  
- How to write SQL queries for business insights  
- How to structure a small analytics project properly  

---

## 🌟 About Me  

Hi, I’m **Shreya Anil Jadhav**, an aspiring Data Analyst.  
I’m building projects to improve my skills in SQL, Python, and data analysis.  
This project helped me understand how data flows from raw files to business insights.  

---
