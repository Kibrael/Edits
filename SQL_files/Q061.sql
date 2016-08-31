WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE property_type = '1'
AND lien = '1'
AND action = '1'
AND rate_spread::REAL > 5
AND rate_spread NOT LIKE '%NA%'
AND rate_spread != '     '
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
WHERE action = '1'
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100 AS Q061
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1;