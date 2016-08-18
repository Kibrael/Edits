WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE
action IN ('1', '2', '3')
AND property_type IN ('1', '2')
AND race IN ('6', '7')
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
WHERE
action IN ('1', '2', '3', '4', '5')
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, numer_count AS Q081_numer, denom_count AS Q081_denom, (numer_count/denom_count::REAL) *100 AS Q081
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) *100 >50;