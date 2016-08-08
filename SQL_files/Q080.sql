
WITH denom AS(
	SELECT
	agency
	,concat(agency, RID) AS arid
	,count(sequence) as denom_count
	FROM hmdalar2014
	WHERE action IN ('1', '2', '3', '4', '5')
	GROUP BY 
	agency, concat(agency, RID)),

numer AS (
	SELECT
	agency
	,concat(agency, RID) AS arid
	,count(sequence) as numer_count
	FROM hmdalar2014
	WHERE property_type IN ('1', '2')
	AND action IN ('1', '2', '3')
	AND ethnicity IN ('3', '4')
	GROUP BY agency, concat(agency, RID))

SELECT
numer.agency, numer.arid
,(numer_count::real / denom_count::real) *100 as Q080
FROM numer
LEFT JOIN denom ON numer.arid = denom.arid
WHERE numer_count::real / denom_count::real > 50