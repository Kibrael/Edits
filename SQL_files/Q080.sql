
WITH denom AS(
	SELECT
	agency
	,CONCAT(agency, RID) AS arid
	,COUNT(sequence) as denom_count
	FROM {table}
	WHERE action IN ('1', '2', '3', '4', '5')
	GROUP BY
	agency, CONCAT(agency, RID)),

numer AS (
	SELECT
	agency
	,CONCAT(agency, RID) AS arid
	,COUNT(sequence) AS numer_count
	FROM {table}
	WHERE property_type IN ('1', '2')
	AND action IN ('1', '2', '3')
	AND ethnicity IN ('3', '4')
	GROUP BY agency, CONCAT(agency, RID))

SELECT
numer.agency, numer.arid, (numer_count::REAL / denom_count::REAL) *100 as Q080
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE numer_count::REAL / denom_count::REAL > 50;