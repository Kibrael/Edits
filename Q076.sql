

WITH sold14 AS (
SELECT
concat(agency, RID) as ARID,
count(sequence) as sold
FROM hmdalar2014
WHERE
loan_purpose = '3'
AND action IN ( '6')
AND property_type IN ('1', '2')
GROUP BY 
concat(agency, RID)),

orig14 AS (
SELECT
concat(agency, RID) as ARID,
count(sequence) as orig
FROM hmdalar2014
WHERE
loan_purpose = '3'
AND action IN ( '1')
AND property_type IN ('1', '2')
GROUP BY 
concat(agency, RID)),

sold13 AS (
SELECT
concat(agency, RID) as ARID,
count(sequence) as sold
FROM hmdalar2013
WHERE
loan_purpose = '3'
AND action IN ( '6')
AND property_type IN ('1', '2')
GROUP BY 
concat(agency, RID)),

orig13 AS (
SELECT
concat(agency, RID) as ARID,
count(sequence) as orig
FROM hmdalar2013
WHERE
loan_purpose = '3'
AND action IN ( '1')
AND property_type IN ('1', '2')
GROUP BY 
concat(agency, RID))

SELECT 
s.arid,
ABS((s.sold::real/(s.sold::real+o.orig::real))*100 - (s13.sold::real/(s13.sold::real+o13.orig::real))*100) AS Q076

FROM sold14 s
LEFT JOIN orig14 o ON s.arid = o.arid
LEFT JOIN sold13 s13 ON s13.arid = s.arid
LEFT JOIN orig13 o13 on o13.arid = s.arid

WHERE (s.sold + o.orig) > 750 
AND (s13.sold + o13.orig) >750
AND ABS((s.sold::real/(s.sold::real+o.orig::real))*100 - (s13.sold::real/(s13.sold::real+o13.orig::real))*100) >= 20