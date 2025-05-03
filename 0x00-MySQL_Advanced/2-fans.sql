-- 2. Rank country origins of bands by total number of fans
-- This query counts total (non-unique) fans grouped by origin, sorted from most to least

SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
