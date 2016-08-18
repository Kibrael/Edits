WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE action = '2'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
GROUP BY agency, CONCAT(agency, RID))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL) *100 AS Q007
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >15;

