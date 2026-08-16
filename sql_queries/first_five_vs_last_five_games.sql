-- SQL query 1/1 used for the fourth dashboard (First 5 Games vs. Last 5 Games)
-- Returns various statistics calculated over the first five Olympic Games (separated by season), as well as the last five.

WITH selected_games AS (SELECT a.season, a.id, n.region, a.sport, a.event, a.games, a.medal, a.sex, a.age, CASE
WHEN a.games IN (
  SELECT DISTINCT games FROM athlete_events WHERE games LIKE '%Summer' ORDER BY games ASC LIMIT 5
  ) 
OR a.games IN (
  SELECT DISTINCT games FROM athlete_events WHERE games LIKE '%Winter' ORDER BY games ASC LIMIT 5
  ) 
  THEN 'First 5'
WHEN a.games IN (
  SELECT DISTINCT games FROM athlete_events WHERE games LIKE '%Summer' ORDER BY games DESC LIMIT 5
  ) 
OR a.games IN (
  SELECT DISTINCT games FROM athlete_events WHERE games LIKE '%Winter' ORDER BY games DESC LIMIT 5
  ) 
  THEN 'Last 5'
END AS era FROM athlete_events a
LEFT JOIN noc_regions n 
  ON a.noc = n.noc)

SELECT s.season, COUNT(DISTINCT s.id) AS total_participants, COUNT(DISTINCT s.id) FILTER (WHERE s.sex='M') 
AS participants_men, COUNT(DISTINCT s.id) FILTER (WHERE s.sex='F') AS participants_women, 
COUNT(DISTINCT s.id) FILTER (WHERE s.age < 25) AS participants_under_25, 
COUNT(DISTINCT s.id) FILTER (WHERE s.age >= 25 AND s.age <= 35) AS participants_25_to_35,
COUNT(DISTINCT s.id) FILTER (WHERE s.age > 35) AS participants_over_35,
COUNT(DISTINCT s.region) AS total_regions_participated,
COUNT(DISTINCT s.sport) AS total_sports, COUNT(DISTINCT s.event) AS total_different_events, 
COUNT(DISTINCT (s.region, s.games, s.event, s.medal)) FILTER (WHERE s.medal IS NOT NULL) AS total_medals, s.era FROM selected_games s
WHERE s.era IN ('First 5', 'Last 5')
GROUP BY s.era, s.season;
