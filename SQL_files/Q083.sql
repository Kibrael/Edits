WITH numer AS (SELECT
agency
,concat(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM {table}
WHERE action IN ('1','2','3')
AND property_type IN ('1','2')
AND ethnicity IN ('3', '4')
AND race IN ('6','7')
AND sex IN ('3','4')
GROUP BY agency, concat(agency, RID)),

denom AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM {table}
WHERE action IN ('1','2','3','4','5')
GROUP BY agency, concat(agency, RID))

SELECT numer.agency, numer.arid, (numer_count::real/denom_count)*100 AS Q083
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count::real/denom_count)*100 > 20;
