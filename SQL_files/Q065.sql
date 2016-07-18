SELECT 
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE hoepa = '1' 
GROUP BY agency, CONCAT(agency, rid)

HAVING COUNT(sequence) > 200