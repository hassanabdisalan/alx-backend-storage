-- 3. List all Glam rock bands ranked by their longevity
-- Lifespan is calculated from year formed to year split or 2022 if still active

SELECT band_name,
       IFNULL(split, 2022) - formed AS lifespan
FROM metal_bands
WHERE style = 'Glam rock'
ORDER BY lifespan DESC;
