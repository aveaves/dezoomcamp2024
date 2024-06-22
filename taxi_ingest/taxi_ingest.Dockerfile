FROM python:3.9

# RUN addgroup --gid 10001 --system nonroot \
#  && adduser  --uid 10000 --system --ingroup nonroot --home /home/nonroot nonroot
RUN SNIPPET="export PROMPT_COMMAND='history -a' \
    && export HISTFILE=/container-profile/.bash_history \
    && export HISTSIZE=-1 \
    && export HISTFILESIZE=-1" \
    && echo "$SNIPPET" >> "/root/.bashrc"

RUN apt-get update && apt-get install -y wget less

WORKDIR /project
# RUN chown -R nonroot:nonroot /project

# USER nonroot
# ENV SHELL /bin/bash

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt \
    && pip install pgcli
# COPY taxi_ingest.py taxi_ingest.py
# ENTRYPOINT [ "python" "taxi_ingest.py"]
# CMD ["--user", "admin", \
#     "--password", "root", \
#     "--host", "db_postgres", \
#     "--port", "5432", \
#     "--db", "ny_taxi", \ 
#     "--data_table_name", "yellow_taxi_trips", \
#     "--lookup_table_name", "zones", \
#     "--data_url", "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet", \
#     "--lookup_url", "https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv"]