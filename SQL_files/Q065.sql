SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS Q065
FROM {table}
WHERE hoepa = '1'
GROUP BY agency, CONCAT(agency, rid)

HAVING COUNT(sequence) > 200;