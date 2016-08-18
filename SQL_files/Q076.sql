WITH sold_curr AS (
SELECT
agency,
CONCAT(agency, RID) AS ARID,
COUNT(sequence) AS sold
FROM {table}
WHERE
loan_purpose = '3'
AND action IN ( '6')
AND property_type IN ('1', '2')
GROUP BY
agency, CONCAT(agency, RID)),

orig_curr AS (
SELECT
CONCAT(agency, RID) AS ARID,
COUNT(sequence) AS orig
FROM {table}
WHERE
loan_purpose = '3'
AND action IN ( '1')
AND property_type IN ('1', '2')
GROUP BY
CONCAT(agency, RID)),

sold_prev AS (
SELECT
CONCAT(agency, RID) AS ARID,
COUNT(sequence) AS sold
FROM {table_prev}
WHERE
loan_purpose = '3'
AND action IN ( '6')
AND property_type IN ('1', '2')
GROUP BY
CONCAT(agency, RID)),

orig_prev AS (
SELECT
CONCAT(agency, RID) AS ARID,
COUNT(sequence) AS orig
FROM {table_prev}
WHERE
loan_purpose = '3'
AND action IN ( '1')
AND property_type IN ('1', '2')
GROUP BY
CONCAT(agency, RID))

SELECT
s.agency, s.arid, (s.sold::REAL/(s.sold::REAL+o.orig::REAL))*100 - (s_prev.sold::REAL/(s_prev.sold::REAL+o_prev.orig::REAL))*100 AS Q076

FROM sold_curr s
LEFT JOIN orig_curr o ON o.arid = s.arid
LEFT JOIN sold_prev s_prev ON s_prev.arid = s.arid
LEFT JOIN orig_prev o_prev on o_prev.arid = s.arid

WHERE (s.sold + o.orig) > 750
AND ABS((s.sold::REAL/(s.sold::REAL+o.orig::REAL))*100 - (s_prev.sold::REAL/(s_prev.sold::REAL+o_prev.orig::REAL))*100) >= 20;