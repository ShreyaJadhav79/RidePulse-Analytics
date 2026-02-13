-- =====================================================
-- RidePulse Analytics
-- Business Analysis Queries
--
-- This file contains SQL queries used to answer
-- key business questions based on Uber trip data.
-- =====================================================


-- =====================================================
-- 1. Which base generated the highest total trips?
-- Purpose: Measure total trip volume per base.
-- =====================================================

SELECT
    base_code,
    SUM(trips) AS total_trips
FROM fact_daily_operations
GROUP BY base_code
ORDER BY total_trips DESC;



-- =====================================================
-- 2. Which month had the highest demand?
-- Purpose: Identify peak demand month.
-- =====================================================

SELECT 
    d.month,
    SUM(f.trips) AS total_trips
FROM fact_daily_operations f 
INNER JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.month 
ORDER BY total_trips DESC;



-- =====================================================
-- 3. Which weekday generates the highest trips?
-- Purpose: Analyze demand pattern across weekdays.
-- =====================================================

SELECT
    d.weekday,
    SUM(f.trips) AS total_trips
FROM fact_daily_operations f 
INNER JOIN dim_date d
    ON f.date_id = d.date_id    
GROUP BY d.weekday
ORDER BY total_trips DESC;



-- =====================================================
-- 4. Which base is most efficient?
-- Purpose: Compare average trips per vehicle.
-- =====================================================

SELECT
    base_code,
    ROUND(AVG(trips_per_vehicle), 2) AS avg_efficiency
FROM fact_daily_operations
GROUP BY base_code
ORDER BY avg_efficiency DESC;



-- =====================================================
-- 5. Which specific dates had the highest total trips?
-- (Top 3 peak demand days)
-- =====================================================

SELECT
    d.date,
    SUM(f.trips) AS total_trips
FROM fact_daily_operations f
INNER JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.date
ORDER BY total_trips DESC
LIMIT 3;



-- =====================================================
-- 6. Which dates had the lowest total trips?
-- (Top 3 lowest demand days)
-- =====================================================

SELECT
    d.date,
    SUM(f.trips) AS total_trips
FROM fact_daily_operations f
INNER JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.date
ORDER BY total_trips ASC
LIMIT 3;



-- =====================================================
-- 7. How do bases rank based on total trips?
-- Purpose: Assign performance rank using window function.
-- =====================================================

SELECT
    base_code,
    SUM(trips) AS total_trips,
    RANK() OVER (ORDER BY SUM(trips) DESC) AS performance_rank
FROM fact_daily_operations
GROUP BY base_code;



-- =====================================================
-- 8. How is each base performing month-wise?
-- Purpose: Compare monthly trip volume for each base.
-- =====================================================

SELECT
    f.base_code,
    d.month,
    SUM(f.trips) AS monthly_trips
FROM fact_daily_operations f 
INNER JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY f.base_code, d.month
ORDER BY f.base_code, d.month;



-- =====================================================
-- 9. On which weekday are vehicles most productive?
-- Purpose: Analyze efficiency by weekday.
-- =====================================================

SELECT 
    d.weekday,
    ROUND(AVG(f.trips_per_vehicle), 2) AS avg_efficiency
FROM fact_daily_operations f 
INNER JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.weekday
ORDER BY avg_efficiency DESC;



-- =====================================================
-- 10. Is demand increasing or decreasing over time?
-- Purpose: Calculate 7-day rolling average to identify trend.
-- =====================================================

SELECT
    date,
    daily_trips,
    ROUND(
        AVG(daily_trips) OVER (
            ORDER BY date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_7day_avg
FROM (
    SELECT
        d.date,
        SUM(f.trips) AS daily_trips
    FROM fact_daily_operations f
    INNER JOIN dim_date d
        ON f.date_id = d.date_id
    GROUP BY d.date
) t
ORDER BY date;
