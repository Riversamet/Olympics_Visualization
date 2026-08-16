-- SQL query 1/2 used for the second dashboard (Gender Statistics Over Time)
-- Returns athlete counts grouped by gender on a per-games basis

SELECT year, season, sex, COUNT(DISTINCT id) AS athlete_count FROM athlete_events
GROUP BY year, season, sex
ORDER BY year, season, sex;
