WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE loan_type = '1'
AND loan_purpose = '1'
AND action = '3'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
WHERE loan_type = '1'
AND loan_purpose = '1'
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >70 AND denom_count >=50;