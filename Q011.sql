WITH curr_year AS (SELECT
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
