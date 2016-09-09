SELECT

SUM(amount::INT) AS sum_amt
,AVG(amount::INT) AS avg_amt
,STDDEV(amount::INT) AS std_amt
,SUM(income::INT) AS sum_income
,AVG(income::INT) AS avg_income
,STDDEV(income::INT) AS std_income
,SUM(amount::INT) / SUM(income::REAL) AS avg_mult
,STDDEV(amount::INT / income::REAL) AS STD_mult 
--check against distributions of income and amount to see if this query should be run against bins

FROM hmdalar2014

WHERE 
amount NOT ILIKE '%NA%'
AND income NOT ILIKE '%NA%'
AND loan_purpose = '1'
AND property_type = '1'