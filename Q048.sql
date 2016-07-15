WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE preapproval = '1' AND action = '5'
GROUP BY agency, concat(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, (numer_count/denom_count::real)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::real)*100 >5