-- ============================================================
-- Maji Ndogo Water Analysis
-- 02 - Water Access Analysis
-- ============================================================

-- ------------------------------------------------------------
-- 1. Combine visits, water sources, locations and pollution data
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW combined_analysis_table AS
SELECT
    ws.type_of_water_source AS source_type,
    l.town_name,
    l.province_name,
    l.location_type,
    ws.number_of_people_served AS people_served,
    v.time_in_queue,
    wp.results
FROM visits AS v
LEFT JOIN well_pollution AS wp
    ON wp.source_id = v.source_id
INNER JOIN location AS l
    ON l.location_id = v.location_id
INNER JOIN water_source AS ws
    ON ws.source_id = v.source_id
WHERE v.visit_count = 1;


-- Verify the combined dataset
SELECT COUNT(*) AS total_rows
FROM combined_analysis_table;


-- ------------------------------------------------------------
-- 2. Analyze water-source access by province
-- ------------------------------------------------------------

WITH province_totals AS (
    SELECT
        province_name,
        SUM(people_served) AS total_people_served
    FROM combined_analysis_table
    GROUP BY province_name
)

SELECT
    ct.province_name,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'river'
                THEN people_served ELSE 0
            END
        ) * 100.0 / pt.total_people_served, 0
    ) AS river,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'shared_tap'
                THEN people_served ELSE 0
            END
        ) * 100.0 / pt.total_people_served, 0
    ) AS shared_tap,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'tap_in_home'
                THEN people_served ELSE 0
            END
        ) * 100.0 / pt.total_people_served, 0
    ) AS tap_in_home,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'tap_in_home_broken'
                THEN people_served ELSE 0
            END
        ) * 100.0 / pt.total_people_served, 0
    ) AS tap_in_home_broken,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'well'
                THEN people_served ELSE 0
            END
        ) * 100.0 / pt.total_people_served, 0
    ) AS well
FROM combined_analysis_table ct
JOIN province_totals pt
    ON ct.province_name = pt.province_name
GROUP BY ct.province_name
ORDER BY ct.province_name;


-- ------------------------------------------------------------
-- 3. Analyze water access at town level
-- ------------------------------------------------------------

CREATE TEMPORARY TABLE town_aggregated_water_access
WITH town_totals AS (
    SELECT
        province_name,
        town_name,
        SUM(people_served) AS total_people_served
    FROM combined_analysis_table
    GROUP BY province_name, town_name
)
SELECT
    ct.province_name,
    ct.town_name,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'river'
                THEN people_served ELSE 0
            END
        ) * 100.0 / tt.total_people_served, 0
    ) AS river,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'shared_tap'
                THEN people_served ELSE 0
            END
        ) * 100.0 / tt.total_people_served, 0
    ) AS shared_tap,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'tap_in_home'
                THEN people_served ELSE 0
            END
        ) * 100.0 / tt.total_people_served, 0
    ) AS tap_in_home,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'tap_in_home_broken'
                THEN people_served ELSE 0
            END
        ) * 100.0 / tt.total_people_served, 0
    ) AS tap_in_home_broken,
    ROUND(
        SUM(
            CASE
                WHEN source_type = 'well'
                THEN people_served ELSE 0
            END
        ) * 100.0 / tt.total_people_served, 0
    ) AS well
FROM combined_analysis_table ct
JOIN town_totals tt
    ON ct.province_name = tt.province_name
    AND ct.town_name = tt.town_name
GROUP BY
    ct.province_name,
    ct.town_name
ORDER BY
    ct.province_name,
    ct.town_name;


-- Preview town-level results
SELECT *
FROM town_aggregated_water_access
LIMIT 10;