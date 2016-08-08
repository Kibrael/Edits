WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS sold
FROM hmdalar2014
WHERE action IN ('1','6')
AND loan_purpose IN ('1','3')
AND property_type IN ('1','2')
AND loan_type = '1'
AND purchaser IN ('1','3')
GROUP BY agency, CONCAT(agency,rid)),

numer_prev AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS sold_prev
FROM hmdalar2013
WHERE action IN ('1','6')
AND loan_purpose IN ('1','3')
AND property_type In ('1','2')
AND loan_type = '1'
AND purchaser IN ('1','3')
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS count_curr
FROM hmdalar2014
WHERE action IN ('1','6')
AND loan_purpose IN ('1','3')
AND property_type IN ('1','2')
AND loan_type = '1'
GROUP BY agency, CONCAT(agency,rid)),

denom_prev AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS count_prev
FROM hmdalar2013
WHERE action IN ('1','6')
AND loan_purpose IN ('1','3')
AND property_type IN ('1','2')
AND loan_type = '1'
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, sold_prev, count_prev, sold, count_curr, (sold_prev/count_prev::REAL)*100 AS pct_sold_prev, (sold/count_curr::REAL)*100 AS pct_sold, 
((sold-sold_prev)/sold_prev::REAL)*100 AS pct_change
FROM numer LEFT JOIN numer_prev ON numer.arid = numer_prev.arid 
LEFT JOIN denom ON denom.arid = numer.arid
LEFT JOIN denom_prev ON denom_prev.arid = numer.arid

WHERE (CASE --WHEN (sold/count_curr < sold_prev/count_prev) AND ABS(sold - sold_prev/count_prev) >= 10 THEN 1
	    WHEN (sold/count_curr < sold_prev/count_prev) AND ABS(sold/count_curr - sold_prev/count_prev) >=10 THEN 1
	    WHEN count_curr >=10000 AND ABS(((sold/count_curr::REAL)*100)) >=20 THEN 1
	    ELSE NULL END) IS NOT NULL
ORDER BY pct_change asc