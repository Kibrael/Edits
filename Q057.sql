WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '3' 
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count AS count_denied, denom_count AS total_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom_count >=50


