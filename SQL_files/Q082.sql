WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE
action IN ('1','2','3')
AND property_type IN ('1','2')
AND sex IN ('3', '4')
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,concat(agency, rid) AS arid
,count(sequence) AS denom_count
FROM {table}
WHERE
action IN ('1','2','3','4','5')
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count::REAL/denom_count *100) AS Q082
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count::REAL/denom_count *100) > 50;