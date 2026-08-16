-- SQL query 1/2 used for the third dashboard (Medal Statistics Over Time)
-- Returns cumulative medal counts by nation over each Olympic Games (separated by season), with an overall medals category, as well as categories specific for each type of medal (gold, silver, bronze)

SELECT year, season, region, 
SUM(gold) OVER (PARTITION BY region, season ORDER BY year ASC ROWS UNBOUNDED PRECEDING) AS cumulative_gold_medals, 
SUM(silver) OVER (PARTITION BY region, season ORDER BY year ASC ROWS UNBOUNDED PRECEDING) AS cumulative_silver_medals,
SUM(bronze) OVER (PARTITION BY region, season ORDER BY year ASC ROWS UNBOUNDED PRECEDING) AS cumulative_bronze_medals,
SUM(total_medals) OVER (PARTITION BY region, season ORDER BY year ASC ROWS UNBOUNDED PRECEDING) AS cumulative_medals
FROM (SELECT year, season, region, COUNT(*) FILTER (WHERE medal='Gold') AS gold,
COUNT(*) FILTER (WHERE medal='Silver') AS silver, COUNT(*) FILTER (WHERE medal='Bronze') AS bronze,
COUNT(*) AS total_medals FROM (SELECT DISTINCT a.year, a.season, a.team, n.region, a.event, a.medal
FROM athlete_events a
LEFT JOIN noc_regions n 
  ON a.noc = n.noc
WHERE a.medal IS NOT NULL)
GROUP BY year, season, region
ORDER BY year, season, total_medals DESC)
ORDER BY year, season, total_medals DESC;
