WITH numer_count AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

numer_sum AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,SUM(amount::INT) AS numer_sum
FROM hmdalar2014
WHERE amount NOT LIKE '%NA%'
AND property_type = '3'
GROUP BY agency, CONCAT(agency, rid)),

denom_count AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid)),

denom_sum AS (SELECT
agency
,CONCAT(agency, RID) as arid
,SUM(amount::INT) AS denom_sum
FROM hmdalar2014
WHERE amount NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency, rid))
SELECT numer_count.agency, numer_count.arid, 
(numer_count/denom_count::real)*100, (numer_sum/denom_sum::real) * 100
FROM numer_count LEFT JOIN numer_sum ON numer_count.arid = numer_sum.arid
LEFT JOIN denom_count ON numer_count.arid = denom_count.arid
LEFT JOIN denom_sum ON numer_count.arid = denom_sum.arid
WHERE (numer_count/denom_count::real)*100 > 10 OR (numer_sum/denom_sum::real)*100 >10
ORDER BY numer_count.agency ASC