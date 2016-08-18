WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE action = '3'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count AS Q057
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom_count >=50 AND numer_count <= 0;


