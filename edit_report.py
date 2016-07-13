##############
#K. David Roell CFPB 7/12/16
#Compiles a report of all quality and macro edit failures for HMDA LAR data
#
##############

import os
import pandas as pd
import psycopg2

from SQL_test import *


conn = psycopg2.connect("dbname=hmdamaster user=roellk") #connect and return connection
cur = conn.cursor()#instantiate cursor object to use in SQL queries

data = cur.execute(Q001())
data_df = pd.DataFrame(data)
print(data_df)

