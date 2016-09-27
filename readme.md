### This repository contains code for developing descriptive statistics of historical HMDA data in order to generate a new series of quality checks for the data. Additionally, scripts for counting historical quality and macro edit failures are present.

#### Folders
**data:** contains data aggregates from the HMDA LAR data. Most of these files contain frequency distributions of numeric variables such as income, loan amount, and rate spread. Some are linked distributions associating two or more variables such as income and loan amount.

**get_data:** the Jupyter notebooks used to create the dynamic SQL statements to pull the data from a postgres instance of the HMDA LAR data.

**linked_dist_stats:** contains CSV files written from Pandas Dataframes containing descriptive statistics for loan products. Separate files exist for unmodified statistics and for data that have been cleaned using an interquartile range method to remove outliers.

**macro_by_agency:** contains CSVs showing macro quality edit fails for HMDA data by year and agency from 2005 to 2014.

**macro_csvs:** contains annual CSVs showing the agency code, respondent id, and relevant metric on which the LAR file failed the macro edit check.

**macro_graphs:** contains graphs of the macro CSVs as counts to show failure rates by year.

**macro_scripts:** contains the scripts used to generate the lists of failed macro edits and code used to process them for agency code, and graphical outputs.

**quality_by_agency:** contains CSVs of quality edit fails for HMDA data by year and agency from 2005 to 2014.

 **quality_csvs:** contains annual CSVs showing the agency code, respondent id, and count of LAR rows that failed the check.

**quality_graphs:** contains graphs of the quality edit failure counts.

**quality_scripts:** contains scripts used to obtain counts of failed edits from the HMDA LAR data and the code used to process them into images and counts by agency.

**SQL_files:** contains the SQL files used to generate the macro quality edit failure data.

**viz_work:** contains analysis work focusing on visualization of distributions between modified and unmodified data. This work will be used to make a recommendation regarding future quality and macro quality edits.

#### Major Scripts:
- get_desc_stats.ipynb: gathers descriptive statistics (average, min, max, stddev) for a specified field. These can be grouped by a geography and/or take optional arguments for min/max for the field in order to help with segment analysis.
- get_field_distribution.ipynb: gathers the distribution of value counts for the specified field. Takes an optional geography parameter. This is currently set to single family, conventional, home purchase loans.
- macro_engine.ipynb: runs all the macro edits in /SQL_files and returns tabular results on failed checks.
- quality_edit_engine.ipynb: generates dynamic SQL using quality_sql.json to run all quality edits and return tabular results on failed checks
- quality_out.ipynb: ingests the results of the quality_edit_engine to produce a grouping edit fails by agency code, and counts by year. Graphs (/quality_graphs) for each edit are produced for each year of data.
- macro_outputs.ipynb: ingests the results of the macro_engine and groups results by agency and year and saves graphs to /macro_graphs