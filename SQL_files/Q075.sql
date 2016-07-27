WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_curr
FROM hmdalar2014
WHERE
loan_purpose = '1'
AND action IN ('1','6')
AND property_type IN ('1','2')
AND purchaser != '0'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_curr
FROM hmdalar2014
WHERE loan_purpose = '1'
AND action IN ('1','6')
AND property_type IN ('1','2')
GROUP BY agency, CONCAT(agency, rid)),

numer_prev AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_prev
FROM hmdalar2013
WHERE loan_purpose = '1'
AND action IN ('1','6')
AND property_type IN ('1','2')
AND purchaser != '0'
GROUP BY agency, CONCAT(agency, rid)),

denom_prev AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_prev
FROM hmdalar2013
WHERE loan_purpose = '1'
AND action IN ('1','6')
AND property_type IN ('1','2')
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_curr, denom_curr, numer_curr/denom_curr::REAL*100
,numer_prev, denom_prev, numer_prev/denom_prev::REAL*100
,(numer_curr/denom_curr::REAL*100 - numer_prev/denom_prev::REAL*100) AS pct_change_sold
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
LEFT JOIN numer_prev ON numer.arid = numer_prev.arid
LEFT JOIN denom_prev ON numer.arid = denom_prev.arid
WHERE numer_curr >=750
AND ABS(numer_curr/denom_curr::REAL*100 - numer_prev/denom_prev::REAL*100) >=20