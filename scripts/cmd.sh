Tables 
-------
1. fligths


Create 
-------
bq mk --table bda_dataset.fligths fligths_schema.json


Upload CSV
----------
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=',' bda_dataset.fligths gs://bda_bucket_1/1.csv


Delete 
-------
bq rm -t bda_dataset.fligths