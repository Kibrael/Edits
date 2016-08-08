

WITH sold_curr AS (
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

orig_curr AS (
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

sold_prev AS (
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

orig_prev AS (
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
(s.sold::real/(s.sold::real+o.orig::real))*100 - (s_prev.sold::real/(s_prev.sold::real+o_prev.orig::real))*100 AS Q076

FROM sold_curr s
LEFT JOIN orig_curr o ON o.arid = s.arid
LEFT JOIN sold_prev s_prev ON s_prev.arid = s.arid
LEFT JOIN orig_prev o_prev on o_prev.arid = s.arid

WHERE (s.sold + o.orig) > 750 
AND ABS((s.sold::real/(s.sold::real+o.orig::real))*100 - (s_prev.sold::real/(s_prev.sold::real+o_prev.orig::real))*100) >= 20