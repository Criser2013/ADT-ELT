# ELT for Pulmonary Embolism prediction

This project recreates ETL process seen on [Pulmonary Embolism prediction project](https://github.com/Criser2013/Diagnostico-TEP/blob/main/preprocesamiento/Datos%20entrenamiento.ipynb) using a modern approach, passing from an imperative high level **Pandas** approach to **DBT** declarative strategy using *Medallion architecture*. 
Pipeline is almost the same but some fixes were added, for instance, outliners aren't removed and there are bound values to discretize quantitative variables.


## Tech stack

- **`dbt`:** To develop *Medallion architecture* models.
- **`airflow`:** Was used to orchestrate the entire pipeline.
- **`flask`:** To develop a small backend sever with the purpose of expose *dbt* functionality like compile, test and run models. It runs in `dbt` container.
- **`postgres`:** Selected data warehouse.
- **`docker compose`:** To easily run each service and allow interactions among between them.

Lightweight images of **Postgres**, **Python** and **Airflow** were used to get maximum performance with abscence of unnecessary dependencies.

## How to run?

1. Create a `.env` file following template available on `.env.example` file.
2. Open a shell and start containers and images building.
```bash
docker compose up --build -d
```

3. After the containers started and everyone show a `healthy` status, open your web browser an go to `http://localhost:8080`.
4. Sign in on `Airflow UI` using the credentials declared at `.env` file.
5. Once logged, go to **DAGS** section and trigger the DAG called `elt_pipeline_adt`.
6. Fill in the paramaters acording to your preferences and run it!

Once DAG finished, ML data will be available at `<DB_SCHEMA>_gold` schema on `gold_ml_discretized` table. Also check `<DB_SCHEMA>_silver` and `<DB_SCHEMA>_bronze` schemas to watch the silver and bronze models on the database. 
DBT logs are available on each task, to easily debug if would be necessary.

## Utilitary commands

- **Destroy containers and volume deletion**:
```bash
docker compose down -v
```

- **Execute a command on a container:**
```bash
docker compose exec <container-name> <command>
```

- **Check database schemas:**
```psql
\dn
```

- **See database tables:**
```psql
\dt <schema>.*
```

- **Watch table structure:**
```psql
\d <schema>.<table>
```

- **Log into Postgres instance:**
```bash
psql -W --username <DB_USERNAME> --dbname <DB_NAME>
```

## Outcome
Data ready to be used on ML pipelines or for data analisys (`gold_without_na_values` model).