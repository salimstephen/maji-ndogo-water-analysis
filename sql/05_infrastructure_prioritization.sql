-- ============================================================
-- Maji Ndogo Water Analysis
-- 05 - Infrastructure Prioritization
-- ============================================================
--
-- Purpose:
-- Translate water-source conditions into infrastructure
-- improvement recommendations.
-- ============================================================


-- ------------------------------------------------------------
-- 1. Create the project-progress table
-- ------------------------------------------------------------

CREATE TABLE Project_progress (
    Project_id SERIAL PRIMARY KEY,
    source_id VARCHAR(20) NOT NULL
        REFERENCES water_source(source_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Address VARCHAR(50),
    Town VARCHAR(30),
    Province VARCHAR(30),
    Source_type VARCHAR(50),
    Improvement VARCHAR(50),
    Source_status VARCHAR(50) DEFAULT 'Backlog'
        CHECK (
            Source_status IN (
                'Backlog',
                'In progress',
                'Complete'
            )
        ),
    Date_of_completion DATE,
    Comments TEXT
);


-- ------------------------------------------------------------
-- 2. Populate initial improvement recommendations
-- ------------------------------------------------------------

INSERT INTO Project_progress (
    source_id,
    Address,
    Town,
    Province,
    Source_type,
    Improvement
)
SELECT
    ws.source_id,
    l.address,
    l.town_name,
    l.province_name,
    ws.type_of_water_source,

    CASE
        WHEN ws.type_of_water_source = 'river'
            THEN 'Drill wells'

        WHEN ws.type_of_water_source = 'shared_tap'
             AND v.time_in_queue >= 30
            THEN CONCAT(
                'Install ',
                FLOOR(v.time_in_queue / 30),
                ' taps nearby'
            )

        WHEN ws.type_of_water_source = 'tap_in_home_broken'
            THEN 'Diagnose local infrastructure'

        WHEN ws.type_of_water_source = 'well'
             AND wp.results != 'Clean'
            THEN
                CASE
                    WHEN wp.results = 'Chemical'
                        THEN 'Install RO filter'

                    WHEN wp.results = 'Biological'
                        THEN 'Install UV and RO filter'

                    ELSE 'Check contamination'
                END
    END AS Improvement

FROM water_source ws

LEFT JOIN well_pollution wp
    ON ws.source_id = wp.source_id

INNER JOIN visits v
    ON ws.source_id = v.source_id

INNER JOIN location l
    ON l.location_id = v.location_id

WHERE
    v.visit_count = 1
    AND (
        ws.type_of_water_source = 'river'
        OR ws.type_of_water_source = 'tap_in_home_broken'
        OR (
            ws.type_of_water_source = 'well'
            AND wp.results != 'Clean'
        )
        OR (
            ws.type_of_water_source = 'shared_tap'
            AND v.time_in_queue >= 30
        )
    );


-- ------------------------------------------------------------
-- 3. Verify the generated recommendations
-- ------------------------------------------------------------

SELECT *
FROM Project_progress
LIMIT 10;


SELECT COUNT(*) AS total_records
FROM Project_progress;


-- ------------------------------------------------------------
-- 4. Update river sources
-- ------------------------------------------------------------

UPDATE Project_progress
SET Improvement = 'Drill well'
WHERE Source_type = 'river';


-- Verify
SELECT
    Source_type,
    Improvement
FROM Project_progress
WHERE Source_type = 'river'
LIMIT 10;


-- ------------------------------------------------------------
-- 5. Update shared taps based on queue time
-- ------------------------------------------------------------

UPDATE Project_progress pp
JOIN visits v
    ON pp.source_id = v.source_id
SET pp.Improvement = CONCAT(
    'Install ',
    FLOOR(v.time_in_queue / 30),
    ' taps nearby'
)
WHERE
    pp.Source_type = 'shared_tap'
    AND v.time_in_queue >= 30;


-- Verify
SELECT
    pp.Source_type,
    pp.Improvement,
    v.time_in_queue
FROM Project_progress pp
JOIN visits v
    ON pp.source_id = v.source_id
WHERE pp.Source_type = 'shared_tap'
LIMIT 10;


-- ------------------------------------------------------------
-- 6. Update broken in-home taps
-- ------------------------------------------------------------

UPDATE Project_progress
SET Improvement = 'Diagnose local infrastructure'
WHERE Source_type = 'tap_in_home_broken';


-- Verify
SELECT
    Source_type,
    Improvement
FROM Project_progress
WHERE Source_type = 'tap_in_home_broken'
LIMIT 10;


-- ------------------------------------------------------------
-- 7. Quality check
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS null_improvements_remaining
FROM Project_progress
WHERE Improvement IS NULL;


SELECT
    COUNT(*) AS total_records
FROM Project_progress;