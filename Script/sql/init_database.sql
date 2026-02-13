-- =====================================================
-- RidePulse Analytics
-- Database Initialization Script
-- 
-- This script creates the database and all required
-- dimension and fact tables for the project.
-- =====================================================

-- Drop database if it already exists (to reset everything)
DROP DATABASE IF EXISTS uber_analytics;

-- Create new database
CREATE DATABASE uber_analytics;

-- Select the database
USE uber_analytics;


-- ==========================
-- Dimension Table: Base
-- Stores unique base codes
-- ==========================
CREATE TABLE dim_base (
    base_code VARCHAR(10) PRIMARY KEY
);


-- ==========================
-- Dimension Table: Date
-- Stores calendar information
-- ==========================
CREATE TABLE dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE UNIQUE,
    year INT,
    month INT,
    weekday VARCHAR(20)
);


-- ==========================
-- Fact Table: Daily Operations
-- Stores daily trip activity per base
-- ==========================
CREATE TABLE fact_daily_operations (
    base_code VARCHAR(10),
    date_id INT,
    active_vehicles INT,
    trips INT,
    trips_per_vehicle FLOAT,
    
    -- Composite primary key ensures one record per base per day
    PRIMARY KEY (base_code, date_id),
    
    -- Foreign key relationships
    FOREIGN KEY (base_code) REFERENCES dim_base(base_code),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);


-- ==========================
-- Validation Queries
-- Used to verify data after loading
-- ==========================

-- Check total records in fact table
SELECT COUNT(*) FROM fact_daily_operations;

-- Check total records in base dimension
SELECT COUNT(*) FROM dim_base;

-- Check total records in date dimension
SELECT COUNT(*) FROM dim_date;

-- Preview first 5 records from fact table
SELECT * FROM fact_daily_operations LIMIT 5;
