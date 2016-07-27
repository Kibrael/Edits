Q076 = {
	"name":"Q076",
	"text":"""WITH sold14 AS (
		SELECT
		concat(agency, RID) AS ARID,
		count(sequence) AS sold
		FROM hmdalar2014
		WHERE
		loan_purpose = '3'
		AND action IN ( '6')
		AND property_type IN ('1', '2')
		GROUP BY
		concat(agency, RID)),

		orig14 AS (
		SELECT
		concat(agency, RID) AS ARID,
		count(sequence) AS orig
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
		s.*, o.orig,
		(s.sold::real/(s.sold::real+o.orig::real))*100 AS pct_sold14,
		(s13.sold::real/(s13.sold::real+o13.orig::real))*100 AS pct_sold13,
		ABS((s.sold::real/(s.sold::real+o.orig::real))*100 - (s13.sold::real/(s13.sold::real+o13.orig::real))*100) AS Q076

		FROM sold14 s
		LEFT JOIN orig14 o ON s.arid = o.arid
		LEFT JOIN sold13 s13 ON s13.arid = s.arid
		LEFT JOIN orig13 o13 on o13.arid = s.arid

		WHERE (s.sold + o.orig) > 750
		AND (s13.sold + o13.orig) >750
		AND ABS((s.sold::real/(s.sold::real+o.orig::real))*100 - (s13.sold::real/(s13.sold::real+o13.orig::real))*100) >= 20; """}

Q082 = {"""WITH numer AS(SELECT
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
		WHERE (numer_count::real/denom_count *100) > 50;"""}

Q080 = {"""WITH denom AS(
		SELECT
		agency
		,concat(agency, RID) AS arid
		,count(sequence) as denom_count
		FROM hmdalar2014
		WHERE property_type IN ('1', '2')
		AND action IN ('1', '2', '3', '4', '5')
		GROUP BY
		agency, concat(agency, RID)),

		numer AS (
		SELECT
		agency
		,concat(agency, RID) AS arid
		,count(sequence) as numer_count
		FROM hmdalar2014
		WHERE property_type IN ('1', '2')
		AND action IN ('1', '2', '3', '4', '5')
		AND ethnicity IN ('3', '4')
		GROUP BY agency, concat(agency, RID))

		SELECT
		numer.arid
		,(numer_count::real / denom_count::real) *100 as Q080
		FROM numer
		LEFT JOIN denom ON numer.arid = denom.arid
		WHERE numer_count::real / denom_count::real > 50;"""}

Q081 = {"""WITH numer AS (SELECT
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
		WHERE (numer_count/denom_count::real) *100 >50;"""}

Q083 = {"""WITH numer AS (SELECT
agency
,concat(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action IN ('1','2','3')
AND property_type IN ('1','2')
AND ethnicity IN ('3', '4')
AND race IN ('6','7')
AND sex IN ('3','4')
GROUP BY agency, concat(agency, RID)),

denom AS(SELECT
agency
,concat(agency, RID) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
WHERE action IN ('1','2','3','4','5')
GROUP BY agency, concat(agency, RID))

SELECT numer.agency, numer.arid, (numer_count::real/denom_count)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count::real/denom_count)*100 > 20;"""}

Q015 = {"""WITH numer_count AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

numer_sum AS(SELECT
agency
,CONCAT(agency, RID) AS arid
,SUM(amount::INT) AS numer_sum
FROM hmdalar2014
WHERE amount NOT LIKE '%NA%'
AND property_type = '3'
GROUP BY agency, CONCAT(agency, rid)),

denom_count AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid)),

denom_sum AS (SELECT
agency
,CONCAT(agency, RID) as arid
,SUM(amount::INT) AS denom_sum
FROM hmdalar2014
WHERE amount NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency, rid))
SELECT numer_count.agency, numer_count.arid,
(numer_count/denom_count::real)*100, (numer_sum/denom_sum::real) * 100
FROM numer_count LEFT JOIN numer_sum ON numer_count.arid = numer_sum.arid
LEFT JOIN denom_count ON numer_count.arid = denom_count.arid
LEFT JOIN denom_sum ON numer_count.arid = denom_sum.arid
WHERE (numer_count/denom_count::real)*100 > 10 OR (numer_sum/denom_sum::real)*100 >10
ORDER BY numer_count.agency ASC;"""}

Q031 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS multi_count
FROM hmdalar2014
WHERE property_type = '3'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS total_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, numer.multi_count, denom.total_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom.total_count > 2000 AND numer.multi_count > 200;"""}

Q047 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE preapproval = '1' AND action = '4'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT numer.agency, numer.arid, (numer_count/denom_count::real) *100 AS Q047
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::real)*100 > 10;"""}

Q006 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE action = '1' AND loan_purpose = '1'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) as denom_count
FROM hmdalar2014
WHERE loan_purpose = '1'
GROUP BY agency, CONCAT(agency, rid))

SELECT numer.agency, numer.arid, (numer_count/denom_count::real) *100
FROM numer LEFT JOIN denom on numer.arid = denom.arid
WHERE (numer_count/denom_count::real) * 100 > 95 AND numer_count > 25 ;"""}

Q048 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE action = '1' AND loan_purpose = '1'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) as denom_count
FROM hmdalar2014
WHERE loan_purpose = '1'
GROUP BY agency, CONCAT(agency, rid))

SELECT numer.agency, numer.arid, (numer_count/denom_count::real) *100
FROM numer LEFT JOIN denom on numer.arid = denom.arid
WHERE (numer_count/denom_count::real) * 100 > 95 AND numer_count > 25"""}

Q007 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '2'
GROUP BY agency, CONCAT(agency, RID)),

denom AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,count(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, RID))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::real) *100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::real)*100 >15"""}


Q008 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, RID) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '4'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) as denom_count
FROM  hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 > 30"""}

Q009 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '5'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom on numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >15"""}

Q010 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '1'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
WHERE action IN ('1','2','3','4','5','6')
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100 < 20
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) < 20"""}

Q023 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE msa LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >30"""}

Q011 = {"""WITH curr_year AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS curr_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid)),

prev_year AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS prev_count
FROM hmdalar2013
GROUP BY agency, CONCAT(agency,rid))

SELECT
curr_year.agency, curr_year.arid, curr_count, prev_count, (curr_count/prev_count::REAL)*100
FROM curr_year LEFT JOIN prev_year ON curr_year.arid = prev_year.arid
WHERE ABS((curr_count/prev_count::REAL)*100) >20
AND curr_count >=500
AND prev_count >=500
"""}

Q016 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE income::INT < 10
AND income NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >20"""}

Q053 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE agency = '5'
AND action = '1'
AND hoepa = '1'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom on numer.arid = denom.arid
WHERE
(numer_count/denom_count::REAL)*100 > 1"""}

Q054 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) as numer_count
FROM hmdalar2014
WHERE agency = '5'
AND action = '6'
AND hoepa = '1'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1"""}

Q062 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '1'
AND hoepa = '1'
AND lien = '1'
AND purchaser = '1'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) *100 >1"""}

Q063 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '1'
AND hoepa = '1'
AND lien = '1'
AND purchaser = '3'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL) *100 >1"""}

Q065 = {"""SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE hoepa = '1'
GROUP BY agency, CONCAT(agency, rid)

HAVING COUNT(sequence) > 200"""}

Q055 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE hoepa = '1'
AND action = '1'
AND rate_spread::REAL >= 5
AND rate_spread NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 > 5"""}

Q061 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE property_type = '1'
AND lien = '1'
AND action = '1'
AND rate_spread::REAL >5
AND rate_spread NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1"""}

Q056 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE property_type = '1'
AND lien = '1'
AND action = '1'
AND rate_spread::REAL >5
AND rate_spread NOT LIKE '%NA%'
GROUP BY agency, CONCAT(agency,rid)),

denom AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency,rid))

SELECT
numer.agency, numer.arid, numer_count, denom_count, (numer_count/denom_count::REAL)*100
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE (numer_count/denom_count::REAL)*100 >1"""}

Q057 = {"""WITH numer AS (SELECT
agency
,CONCAT(agency,rid) AS arid
,COUNT(sequence) AS numer_count
FROM hmdalar2014
WHERE action = '3'
GROUP BY agency, CONCAT(agency, rid)),

denom AS (SELECT
agency
,CONCAT(agency, rid) AS arid
,COUNT(sequence) AS denom_count
FROM hmdalar2014
GROUP BY agency, CONCAT(agency, rid))

SELECT
numer.agency, numer.arid, numer_count AS count_denied, denom_count AS total_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom_count >=50"""}

Q058 = {"""WITH numer AS (SELECT
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
numer.agency, numer.arid, numer_count, denom_count
FROM numer LEFT JOIN denom ON numer.arid = denom.arid
WHERE denom_count >=1000"""}

