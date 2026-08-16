-- SQL query 2/2 used for the second dashboard (Gender Statistics Over Time)
-- Returns event counts grouped by gender on a per-games basis

SELECT year, season, 
CASE
WHEN event LIKE '%Women''s%' THEN 'Women''s'
WHEN event LIKE '%Men''s%'   THEN 'Men''s'
ELSE 'Mixed/Other'
END AS event_gender,
COUNT(DISTINCT event) AS event_count FROM athlete_events
GROUP BY year, season, event_gender
ORDER BY year, season, event_gender;
