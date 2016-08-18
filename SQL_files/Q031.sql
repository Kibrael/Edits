WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS multi_count
FROM {table}
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS total_count
FROM {table}
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, numer.multi_count AS Q031
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom.total_count > 2000 AND numer.multi_count > 200;
