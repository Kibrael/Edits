WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer
FROM hmdalar2014
WHERE loan_purpose = '3'
AND action IN ('1','6')
AND property_type IN ('1','2')
AND loan_type IN ('2','3')
AND purchaser != '0'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom
FROM hmdalar2014
WHERE loan_purpose = '3'
AND action IN ('1', '6')
AND property_type IN ('1','2')
AND loan_type IN ('2', '3')
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer, denom, numer/denom::REAL*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom >=250 AND numer/denom*100 <=20