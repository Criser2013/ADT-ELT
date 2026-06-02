#!/bin/bash

airflow db migrate
airflow users create \
    --username $AIRFLOW_WEB_USERNAME \
    --password $AIRFLOW_WEB_PASSWORD \
    --firstname admin \
    --lastname User \
    --role Admin \
    --email $AIRFLOW_USER_EMAIL
airflow scheduler &
airflow api-server