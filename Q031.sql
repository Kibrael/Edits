WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS multi_count
FROM hmdalar2014
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS total_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, numer.multi_count, denom.total_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom.total_count > 2000 AND numer.multi_count > 200
