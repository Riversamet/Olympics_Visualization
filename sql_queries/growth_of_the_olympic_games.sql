-- SQL query 1/1 used for the first dashboard (Growth of the Olympic Games)
-- Returns various Olympic statistics on a per-games basis

SELECT a.year, a.season, COUNT(DISTINCT a.id) AS athlete_count, COUNT(DISTINCT n.region) AS nation_count, 
COUNT(DISTINCT a.event) AS event_count, COUNT(DISTINCT a.sport) AS sport_count FROM athlete_events a
LEFT JOIN noc_regions n
  ON a.noc = n.noc
GROUP BY a.year, a.season
ORDER BY a.year, a.season;
