-- SQL query 2/2 used for the third dashboard (Medal Statistics Over Time)
-- Returns total medals won by each nation summed over all Olympic Games (separated by season), with an overall medals category, as well as categories specific for each type of medal (gold, silver, bronze)

SELECT season, region, gold, silver, bronze, total_medals, 
RANK() OVER (PARTITION BY season ORDER BY total_medals DESC) AS medals_rank
FROM (SELECT season, region, COUNT(*) FILTER (WHERE medal='Gold') AS gold,
COUNT(*) FILTER (WHERE medal='Silver') AS silver, COUNT(*) FILTER (WHERE medal='Bronze') AS bronze,
COUNT(*) AS total_medals FROM (SELECT DISTINCT a.year, a.season, a.team, n.region, a.event, a.medal
FROM athlete_events a
LEFT JOIN noc_regions n 
  ON a.noc = n.noc
WHERE a.medal IS NOT NULL)
GROUP BY season, region
ORDER BY season, total_medals DESC)
ORDER BY season, medals_rank ASC;
