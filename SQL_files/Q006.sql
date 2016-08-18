﻿WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) as numer_count
FROM {table}
WHERE action = '1' AND loan_purpose = '1'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) as denom_count
FROM {table}
WHERE loan_purpose = '1'
GROUP BY agency, CONCAT(agency, rid))

SELECT numer.agency, numer.arid, (numer_count/denom_count::REAL) *100 AS Q006
FROM numer LEFT JOIN denom on numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) * 100 > 95 AND numer_count > 25;