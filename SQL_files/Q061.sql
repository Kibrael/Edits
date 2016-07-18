WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE property_type = '1'
AND lien = '1'
AND action = '1'
AND rate_spread::REAL >5
AND rate_spread NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1