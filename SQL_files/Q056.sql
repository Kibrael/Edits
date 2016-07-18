﻿WITH numer AS (SELECT 
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE loan_type = '1'
AND loan_purpose = '1'
AND action = '3'
GROUP BY agency, CONCAT(agency,rid)
HAVING COUNT(sequence) >=50),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
WHERE loan_type = '1'
AND loan_purpose = '1'
GROUP BY agency, CONCAT(agency,rid)
HAVING COUNT(sequence) >=50)

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid