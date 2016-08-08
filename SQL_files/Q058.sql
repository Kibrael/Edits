WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE preapproval = '1'
AND action = '7'
GROUP BY agency, CONCAT(agency,rid)
HAVING COUNT(sequence) = 0),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
WHERE preapproval ='1'
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count AS Q058, denom_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom_count >=1000 AND numer_count <= 0
