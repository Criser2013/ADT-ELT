ARG AIRFLOW_VERSION=slim-3.2.2-python3.13

FROM apache/airflow:${AIRFLOW_VERSION}

USER root

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN apt update && apt upgrade -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

RUN pip install --no-cache-dir psycopg2-binary asyncpg apache-airflow-providers-fab

ENTRYPOINT ["/entrypoint.sh"]