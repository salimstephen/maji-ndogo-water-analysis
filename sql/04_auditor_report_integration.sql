-- ============================================================
-- Maji Ndogo Water Analysis
-- 04 - Auditor Report Integration
-- ============================================================
--
-- Purpose:
-- Integrate the auditor's findings with the existing water
-- services database and analyze audit performance by location
-- and employee.
--
-- Database: md_water_services
-- ============================================================


-- ------------------------------------------------------------
-- 1. Inspect the core tables used in the integration
-- ------------------------------------------------------------

SHOW TABLES;

DESCRIBE employee;
DESCRIBE visits;
DESCRIBE water_source;
DESCRIBE water_quality;
DESCRIBE well_pollution;


-- ------------------------------------------------------------
-- 2. Create an integrated audit view
-- ------------------------------------------------------------
--
-- The view connects:
--   auditors_report
--   location
--   water_source
--   visits
--   employee
--
-- This creates a reusable analytical dataset containing
-- audit results, water-source information, visit information,
-- location details, and assigned employee information.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW audit_employee_source_view AS
SELECT
    ar.location_id,
    ar.type_of_water_source AS audited_water_source,
    ar.true_water_source_score AS audit_score,
    ar.statements AS auditor_feedback,
    l.town_name,
    l.province_name,
    ws.source_id,
    ws.number_of_people_served,
    v.time_of_record AS visit_date,
    v.visit_count,
    e.employee_name,
    e.position,
    e.town_name AS employee_town
FROM auditors_report ar
JOIN location l
    ON ar.location_id = l.location_id
JOIN water_source ws
    ON ar.type_of_water_source = ws.type_of_water_source
JOIN visits v
    ON ws.source_id = v.source_id
JOIN employee e
    ON v.assigned_employee_id = e.assigned_employee_id;


-- ------------------------------------------------------------
-- 3. Verify that the analytical view exists
-- ------------------------------------------------------------

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


-- Preview the integrated dataset
SELECT *
FROM audit_employee_source_view
LIMIT 10;


-- ------------------------------------------------------------
-- 4. Analyze audit results by province and town
-- ------------------------------------------------------------

SELECT
    province_name,
    town_name,
    COUNT(*) AS total_audits,
    SUM(
        CASE
            WHEN audit_score <= 2 THEN 1
            ELSE 0
        END
    ) AS low_score_count,
    ROUND(AVG(audit_score), 2) AS avg_audit_score
FROM audit_employee_source_view
GROUP BY
    province_name,
    town_name
ORDER BY low_score_count DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 5. Analyze audit results by employee
-- ------------------------------------------------------------

SELECT
    employee_name,
    position,
    employee_town,
    COUNT(*) AS total_audits,
    SUM(
        CASE
            WHEN audit_score <= 2 THEN 1
            ELSE 0
        END
    ) AS low_score_count,
    ROUND(AVG(audit_score), 2) AS avg_audit_score
FROM audit_employee_source_view
GROUP BY
    employee_name,
    position,
    employee_town
ORDER BY avg_audit_score ASC
LIMIT 10;