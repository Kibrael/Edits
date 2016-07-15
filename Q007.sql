﻿WITH numer AS (SELECT 
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '2'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT 
numer.agency, numer.arid, (numer_count/denom_count::real) *100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::real)*100 >15

