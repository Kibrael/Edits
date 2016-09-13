### This repository contains code for developing descriptive statistics of historical HMDA data in order to generate a new series of quality checks for the data. Additionally, scripts for counting historical quality and macro edit failures are present.

#### Major Scripts:
- desc_stats.ipynb: gathers descriptive statistics (average, min, max, stddev) for a specified field. These can be grouped by a geography and/or take optional arguments for min/max for the field in order to help with segment analysis.
- get_field_distribution.ipynb: gathers the distribution of value counts for the specified field. Takes an optional geography parameter. This is currently set to single family, conventional, home purchase loans.
- macro_engine.ipynb: runs all the macro edits in /SQL_files and returns tabular results on failed checks.
- quality_edit_engine.ipynb: generates dynamic SQL using quality_sql.json to run all quality edits and return tabular results on failed checks
- quality_out.ipynb: ingests the results of the quality_edit_engine to produce a grouping edit fails by agency code, and counts by year. Graphs (/quality_graphs) for each edit are produced for each year of data.
- macro_outputs.ipynb: ingests the results of the macro_engine and groups results by agency and year and saves graphs to /macro_graphs


Dependancy files:
- /SQL_files contains a SQL script for each macro edit
- quality_sql.json contains there WHERE clauses for all quality edits

Vizualizations:
- macro_graphs
- quality_graphs
- untitled.ipynb

Other Files:
- edit work plan: a description of how edits function and an explorative path to convert them into statistically derived checks