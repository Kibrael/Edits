WITH numer_count AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

numer_sum AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,SUM(amount::INT) AS numer_sum
FROM {table}
WHERE amount NOT LIKE '%NA%'
AND property_type = '3'
GROUP BY agency, CONCAT(agency, rid)),

denom_count AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
GROUP BY agency, CONCAT(agency, rid)),

denom_sum AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,SUM(amount::INT) AS denom_sum
FROM {table}
WHERE amount NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency, rid))
SELECT numer_count.agency, numer_count.arid,
(numer_count/denom_count::REAL)*100 AS Q015_count, (numer_sum/denom_sum::REAL) * 100 AS Q015_value
FROM numer_count LEFT JOIN numer_sum ON numer_count.arid = numer_sum.arid
LEFT JOIN denom_count ON numer_count.arid = denom_count.arid
LEFT JOIN denom_sum ON numer_count.arid = denom_sum.arid
WHERE (numer_count/denom_count::REAL)*100 > 10 OR (numer_sum/denom_sum::REAL)*100 >10
ORDER BY numer_count.agency ASC;