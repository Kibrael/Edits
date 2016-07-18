WITH numer AS(SELECT 
agency
,concat(agency, rid) AS arid
,count(sequence) AS numer_count
FROM hmdalar2014
WHERE
action IN ('1','2','3')
AND property_type IN ('1','2')
AND sex IN ('3', '4')
GROUP BY agency, concat(agency, rid)),

denom AS(SELECT
agency
,concat(agency, rid) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
WHERE
action IN ('1','2','3','4','5')
GROUP BY agency, concat(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count::real/denom_count *100) AS Q082
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count::real/denom_count *100) > 50