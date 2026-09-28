-- ============================================================
-- Maji Ndogo Water Analysis
-- 03 - Queue Time Analysis
-- ============================================================

-- ------------------------------------------------------------
-- 1. Calculate the average queue time
-- ------------------------------------------------------------

SELECT
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits;


-- ------------------------------------------------------------
-- 2. Average queue time by day of week
-- ------------------------------------------------------------

SELECT
    DAYNAME(time_of_record) AS day_of_week,
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits
GROUP BY day_of_week
ORDER BY avg_queue_time_minutes DESC;


-- ------------------------------------------------------------
-- 3. Average queue time by hour of day
-- ------------------------------------------------------------

SELECT
    HOUR(time_of_record) AS hour_of_day,
    ROUND(
        AVG(NULLIF(time_in_queue, 0)),
        2
    ) AS avg_queue_time_minutes
FROM visits
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- ------------------------------------------------------------
-- 4. Queue-time pattern by day and hour
-- ------------------------------------------------------------

SELECT
    TIME_FORMAT(
        TIME(time_of_record),
        '%H:00'
    ) AS hour_of_day,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Sunday'
                THEN time_in_queue
            END
        ), 0
    ) AS Sunday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Monday'
                THEN time_in_queue
            END
        ), 0
    ) AS Monday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Tuesday'
                THEN time_in_queue
            END
        ), 0
    ) AS Tuesday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Wednesday'
                THEN time_in_queue
            END
        ), 0
    ) AS Wednesday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Thursday'
                THEN time_in_queue
            END
        ), 0
    ) AS Thursday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Friday'
                THEN time_in_queue
            END
        ), 0
    ) AS Friday,

    ROUND(
        AVG(
            CASE
                WHEN DAYNAME(time_of_record) = 'Saturday'
                THEN time_in_queue
            END
        ), 0
    ) AS Saturday

FROM visits
WHERE time_in_queue != 0
GROUP BY hour_of_day
ORDER BY hour_of_day;