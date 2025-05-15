-- find the top 5 taxons with the most occurrences of "Breaking leaf buds" or "Breaking needle buds" phenophases 
SELECT plant.taxonID, COUNT(*) AS bud_count
FROM plant 
JOIN phenophase ON plant.individualID = phenophase.individualID
WHERE phenophase.phenophaseName IN ('Breaking leaf buds', 'Breaking needle buds')
AND phenophase.phenophaseStatus = 'yes'
GROUP BY plant.taxonID
ORDER BY bud_count DESC
LIMIT 5;
