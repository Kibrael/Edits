WITH numer AS (SELECT
agency
,concat(agency, RID) AS arid
,count(sequence) AS numer_count
FROM hmdalar2014
WHERE 
action IN ('1', '2', '3')
AND property_type IN ('1', '2')
AND race IN ('6', '7')
GROUP BY agency, concat(agency, RID)),

denom AS (SELECT
agency
,concat(agency, RID) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
WHERE 
action IN ('1', '2', '3', '4', '5')
GROUP BY agency, concat(agency, RID))

SELECT numer_count, denom_count, (numer_count/denom_count::real) *100
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::real) *100 >50