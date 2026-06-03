from airflow.sdk import dag, task, Variable, get_current_context
from datetime import datetime
import requests
import logging

# Variables recuperadas en tiempo de parseo (Opcional: considera moverlas dentro de las tareas)
API_URL = Variable.get("api_url", default_var="http://dbt:5000")
ENDPOINT_LOAD_DATA = Variable.get("load_endpoint", default_var="/load-dbt")
ENDPOINT_COMPILE_MODEL = Variable.get("compile_endpoint", default_var="/compile-dbt")
ENDPOINT_TRANSFORM_DATA = Variable.get("transform_endpoint", default_var="/run-dbt")

default_params = {
    "API_URL": API_URL,
    "ENDPOINT_LOAD_DATA": ENDPOINT_LOAD_DATA,
    "ENDPOINT_COMPILE_MODEL": ENDPOINT_COMPILE_MODEL,
    "ENDPOINT_TRANSFORM_DATA": ENDPOINT_TRANSFORM_DATA,
    "compile_dbt_models": True
}

@dag(
    owner="Criser2013",
    dag_id="elt_pipeline_adt",
    start_date=datetime(2026, 6, 3),
    description="ELT pipeline for training ML models to predict PE on patients.",
    params=default_params,
    schedule=None, 
    catchup=False
)
def elt_pipeline():

    @task(task_id="extract_data")
    def extract():
        context = get_current_context()
        params = context["params"]
        
        url = f"{params['API_URL']}{params['ENDPOINT_LOAD_DATA']}"
        res = requests.post(url)
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json.get("message"))
        else:
            logging.error(res_json.get("error"))
            raise Exception("Failed to extract data")

    @task.branch(task_id="decide_compile")
    def decide_compile():
        context = get_current_context()
        params = context["params"]
        return "compile_dbt_models" if params["compile_dbt_models"] else "transform_data"

    @task(task_id="compile_dbt_models")
    def compile_models():
        context = get_current_context()
        params = context["params"]
        
        url = f"{params['API_URL']}{params['ENDPOINT_COMPILE_MODEL']}"
        res = requests.post(url)
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json.get("message"))
        else:
            logging.error(res_json.get("error"))
            raise Exception("Failed to compile dbt models")

    @task(task_id="transform_data")
    def transform_data():
        context = get_current_context()
        params = context["params"]
        
        url = f"{params['API_URL']}{params['ENDPOINT_TRANSFORM_DATA']}"
        res = requests.post(url)
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json.get("message"))
        else:
            logging.error(res_json.get("error"))
            raise Exception("Failed to transform data")

    extract_task = extract()
    decide_task = decide_compile()
    compile_task = compile_models()
    transform_task = transform_data()

    extract_task >> decide_task
    decide_task >> compile_task >> transform_task
    decide_task >> transform_task

elt_pipeline()