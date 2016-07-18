WITH numer AS (SELECT 
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE agency = '5'
AND action = '6'
AND hoepa = '1'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1