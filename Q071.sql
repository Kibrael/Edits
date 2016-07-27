WITH thresh AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS thresh_ct
FROM hmdalar2014
WHERE action IN ('1','6')
AND loan_purpose IN ('1','3')
AND property_type IN ('1','2')
AND loan_type = '2'
AND purchaser = '2'
GROUP BY agency, CONCAT(agency,rid)),

numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS sold
FROM hmdalar2014
WHERE action ='6'
AND property_type In ('1','2')
AND loan_type = '2'
AND purchaser = '2'
GROUP BY agency, CONCAT(agency,rid)),

numer_prev AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS sold_prev
FROM hmdalar2013
WHERE action = '6'
AND property_type IN ('1','2')
AND loan_type = '2'
AND purchaser = '2'
GROUP BY agency, CONCAT(agency,rid))

SELECT
thresh.arid, thresh.thresh_ct, sold_prev, sold, ((sold-sold_prev)/sold_prev::REAL)*100 AS pct_change
FROM thresh LEFT JOIN numer ON numer.arid = thresh.arid 
LEFT JOIN numer_prev ON thresh.arid = numer_prev.arid
WHERE (CASE WHEN thresh_ct <2500 AND ABS(((sold-sold_prev)/sold_prev::REAL)*100) >10 THEN 1
	    --WHEN thresh_ct >=2500 AND ABS(((sold-sold_prev)/sold_prev::REAL)*100) >=30 THEN 1
	    ELSE NULL END) IS NOT NULL
ORDER BY pct_change asc
