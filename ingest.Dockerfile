FROM python:3.9
RUN apt-get update && apt-get install wget
RUN pip install --upgrade pip
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ingest-data.py ingest-data.py
ENTRYPOINT [ "python", "ingest-data.py" ]
CMD ["--user", "admin", \
    "--password", "root", \
    "--host", "db_postgres", \
    "--port", "5432", \
    "--db", "ny_taxi", \ 
    "--data_table_name", "yellow_taxi_trips", \
    "--lookup_table_name", "zones", \
    "--data_url", "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet", \
    "--lookup_url", "https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv"]