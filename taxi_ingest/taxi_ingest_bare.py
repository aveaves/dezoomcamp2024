import argparse
import os 
import pandas as pd
from sqlalchemy import create_engine


class Parser:
    def __init__(self):
        self.user = "admin"
        self.password = "root"
        self.host = "db_postgres"
        self.port = "5432"
        self.db = "ny_taxi"
        self.data_table_name = "yellow_taxi_trips"
        self.lookup_table_name = "zones"
        self.data_url = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet"
        self.lookup_url = "https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv"

params = Parser()

user = params.user
password = params.password
host = params.host
port = params.port
db = params.db
data_table_name = params.data_table_name
lookup_table_name = params.lookup_table_name
data_url = params.data_url
lookup_url = params.lookup_url
data_dir = "taxi_data"
trip_data = 'yellow_tripdata_2021-01.parquet'
zone_data = 'taxi+_zone_lookup.csv'
trip_data_path = os.path.join(data_dir, trip_data)
zone_data_path = os.path.join(data_dir, zone_data)

# DOWNLOAD THE DATA IF IT DOESN'T EXIST YET.
if not os.path.isfile(trip_data_path):
    os.system(f'wget -O {trip_data_path} {data_url}')
if not os.path.isfile(zone_data_path):
    os.system(f'wget -O {zone_data_path} {lookup_url}')


# READ THE PARQUET and CSV FILES INTO DATAFRAMES
df_trip = pd.read_parquet(trip_data_path)
df_zone = pd.read_csv(zone_data_path)

# CREATE A CONNECTION TO THE DB
engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
# UPLOAD THE DATA TO THE DB
df_trip.to_sql(name=data_table_name, con=engine, if_exists='replace',
               method='multi', chunksize=1000)
df_zone.to_sql(name=lookup_table_name, con=engine, if_exists='replace',
               method='multi', chunksize=1000)

print("i got here")
