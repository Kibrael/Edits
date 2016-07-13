	[{
		"name": "Q035",
		"text": "WHERE loan_type !: '1' AND purchaser IN  ('1','3')"
	},

	{
		"name": "Q001",
		"text": "WHERE amount not like '%NA%' AND income not like '%NA%' AND amount::int >: 1000 AND (amount::int / income::int) < 5"
	},

	{
		"name": "Q002",
		"text": "WHERE property_type : '1' AND income NOT LIKE '%NA%' AND amount NOT LIKE '%NA%' AND income::INT >: 200 AND amount::INT >: 2000"
	},

	{
		"name": "Q003",
		"text": "WHERE loan_type : '2' AND property_type in ('1', '2') AND amount::INT > 626 AND amount not like '%NA%'"
	},

	{
		"name": "Q004",
		"text": "WHERE loan_type : '3' AND property_type IN ('1', '2') AND amount::INT >- 1050 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q005",
		"text": "WHERE purchaser IN ('1', '2', '3', '4') AND property_type IN ('1', '2') AND amount::INT > 1203 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q013",
		"text": "WHERE property_type = '3' AND amount::INT >: 100 AND amount::INT <: 10000 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q036",
		"text": "WHERE property_type = '2' AND amount::INT > 150 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q037",
		"text": "WHERE lien : '2' AND amount::INT > 250 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q038",
		"text": "WHERE lien : '3' AND amount::INT > 100 AND amount NOT LIKE '%NA%'"
	},

	{
		"name": "Q025",
		"text": "WHERE loan_purpose = '1' AND property_type : '1' AND amount::INT <:10 AND amount NOT LIKE '%NA'"
	},

	{
		"name": "Q032",
		"text": "WHERE action : '1' AND action_taken_date :: application_received_date"
	},

	{
		"name": "Q068",
		"text": "WHERE action IN ('1', '2', '3', '4', '5', '7', '8') AND ethnicity : '4' AND race : '7' AND sex : '4' AND co_ethnicity : '4' AND co_race1 : '7' AND co_sex : '4'"
	},

	{
		"name": "Q014",
		"text": "WHERE income::INT > 3000 AND income NOT LIKE '%NA%'"
	},

	{
		"name": "Q024",
		"text": "WHERE action : '1' AND (amount::INT / income::INT) >: 5 AND income::INT <: 9 AND income NOT LIKE '%NA%' AND amount NOT LIKE '%NA%' "
	},

	{
		"name": "Q027",
		"text": "WHERE action in ('1', '2', '3', '4', '5', '7', '8') AND property_type IN ('1', '2') AND income LIKE '%NA' "
	},

	{
		"name": "Q067",
		"text": "WHERE action in ('1', '2', '3', '4', '5', '7', '8') AND ethnicity : '4' AND race : '7' AND sex : '4' AND co_ethnicity : '4' AND co_race1 : '7' AND co_sex : '4' AND income NOT LIKE '%NA%'"
	}
]