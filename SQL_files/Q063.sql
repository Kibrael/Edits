WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE action = '1'
AND hoepa = '1'
AND lien = '1'
AND purchaser = '3'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
WHERE action = '1'
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100 AS Q063
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) * 100 > 1;