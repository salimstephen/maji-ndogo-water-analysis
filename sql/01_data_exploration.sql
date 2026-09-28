-- ============================================================
-- Maji Ndogo Water Analysis
-- 01 - Data Exploration and Preparation
-- ============================================================
--
-- Purpose:
-- Explore the core tables, clean selected employee fields,
-- and establish baseline information about locations,
-- water sources, and field visits.
--
-- Database: md_water_services
-- ============================================================


-- ------------------------------------------------------------
-- 1. Inspect the data dictionary
-- ------------------------------------------------------------

SELECT *
FROM data_dictionary
LIMIT 10;


-- ------------------------------------------------------------
-- 2. Inspect employee records
-- ------------------------------------------------------------

SELECT *
FROM employee
LIMIT 5;


-- ------------------------------------------------------------
-- 3. Generate standardized employee email addresses
-- ------------------------------------------------------------

SELECT
    employee_name,
    CONCAT(
        LOWER(REPLACE(TRIM(employee_name), ' ', '.')),
        '@ndogowater.gov'
    ) AS generated_email
FROM employee;


-- Apply the standardized email format
UPDATE employee
SET email = CONCAT(
    LOWER(REPLACE(TRIM(employee_name), ' ', '.')),
    '@ndogowater.gov'
);


-- Verify the update
SELECT
    employee_name,
    email
FROM employee
LIMIT 10;


-- ------------------------------------------------------------
-- 4. Clean employee phone numbers
-- ------------------------------------------------------------

-- Preview the transformation before updating
SELECT
    employee_name,
    phone_number AS original_phone,
    TRIM(phone_number) AS cleaned_phone,
    LENGTH(phone_number) AS original_length,
    LENGTH(TRIM(phone_number)) AS cleaned_length
FROM employee
LIMIT 10;


-- Apply the cleaning
UPDATE employee
SET phone_number = TRIM(phone_number)
WHERE phone_number IS NOT NULL;


-- Verify the cleaned values
SELECT
    employee_name,
    phone_number,
    LENGTH(phone_number) AS phone_length
FROM employee
LIMIT 10;


-- ------------------------------------------------------------
-- 5. Count employees by location
-- ------------------------------------------------------------

SELECT
    COALESCE(
        NULLIF(TRIM(LOWER(town_name)), ''),
        NULLIF(TRIM(LOWER(province_name)), ''),
        NULLIF(TRIM(LOWER(address)), ''),
        'unknown'
    ) AS location,
    COUNT(*) AS employee_count
FROM employee
GROUP BY location
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 6. Identify the top field surveyors
-- ------------------------------------------------------------

SELECT
    assigned_employee_id,
    COUNT(location_id) AS total_visits
FROM visits
GROUP BY assigned_employee_id
ORDER BY total_visits DESC
LIMIT 3;


-- Retrieve details for the highest-visit surveyors
SELECT
    assigned_employee_id,
    employee_name,
    email,
    phone_number
FROM employee
WHERE assigned_employee_id IN (1, 30, 34);


-- ------------------------------------------------------------
-- 7. Explore water-source locations
-- ------------------------------------------------------------

-- Records by town
SELECT
    town_name,
    COUNT(*) AS num_records
FROM location
GROUP BY town_name
ORDER BY num_records DESC;


-- Records by province
SELECT
    province_name,
    COUNT(*) AS num_records
FROM location
GROUP BY province_name
ORDER BY num_records DESC;


-- Records by province and town
SELECT
    province_name,
    town_name,
    COUNT(*) AS records_per_town
FROM location
GROUP BY province_name, town_name
ORDER BY province_name, records_per_town DESC;


-- Rural vs urban location coverage
SELECT
    location_type,
    COUNT(*) AS num_records
FROM location
GROUP BY location_type
ORDER BY num_records DESC;


-- ------------------------------------------------------------
-- 8. Explore water-source types
-- ------------------------------------------------------------

SELECT
    type_of_water_source,
    COUNT(*) AS num_sources
FROM water_source
GROUP BY type_of_water_source
ORDER BY num_sources DESC;


-- Average number of people served per source type
SELECT
    type_of_water_source,
    ROUND(AVG(number_of_people_served), 0) AS avg_people_served
FROM water_source
GROUP BY type_of_water_source
ORDER BY avg_people_served DESC;


-- Total people served by source type
SELECT
    type_of_water_source,
    SUM(number_of_people_served) AS total_people_served
FROM water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;


-- ------------------------------------------------------------
-- 9. Rank water-source types by population served
-- ------------------------------------------------------------

SELECT
    type_of_water_source,
    total_people_served,
    RANK() OVER (
        ORDER BY total_people_served DESC
    ) AS rank_by_people_served
FROM (
    SELECT
        type_of_water_source,
        SUM(number_of_people_served) AS total_people_served
    FROM water_source
    WHERE type_of_water_source <> 'tap_in_home'
    GROUP BY type_of_water_source
) AS totals
ORDER BY total_people_served DESC;


-- ------------------------------------------------------------
-- 10. Rank individual water sources within each type
-- ------------------------------------------------------------

SELECT
    type_of_water_source,
    source_id,
    number_of_people_served,
    RANK() OVER (
        PARTITION BY type_of_water_source
        ORDER BY number_of_people_served DESC
    ) AS rank_within_type
FROM water_source
WHERE type_of_water_source IN (
    'shared_tap',
    'tap_in_home_broken',
    'well',
    'river'
)
ORDER BY
    type_of_water_source,
    rank_within_type
LIMIT 20;


-- ------------------------------------------------------------
-- 11. Determine the survey period
-- ------------------------------------------------------------

SELECT
    MIN(time_of_record) AS survey_start_date,
    MAX(time_of_record) AS survey_end_date,
    DATEDIFF(
        MAX(time_of_record),
        MIN(time_of_record)
    ) AS survey_duration_days
FROM visits;


-- ------------------------------------------------------------
-- 12. Analyze average queue time
-- ------------------------------------------------------------

SELECT
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits;


-- Average queue time by day of week
SELECT
    DAYNAME(time_of_record) AS day_of_week,
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits
GROUP BY day_of_week
ORDER BY avg_queue_time_minutes DESC;


-- Average queue time by hour
SELECT
    HOUR(time_of_record) AS hour_of_day,
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits
GROUP BY hour_of_day
ORDER BY hour_of_day;