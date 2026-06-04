from airflow.sdk import dag, task, Variable, get_current_context
from datetime import datetime
from requests import post
import logging

@dag(
    dag_id="elt_pipeline_adt",
    start_date=datetime(2026, 5, 3),
    description="ELT pipeline for training ML models to predict PE on patients.",
    schedule=None, 
    catchup=False,
    params={
        "compile_dbt_models": True,
        "file_name": "Datos mismo archivo.xlsx",
        "sheet_name": "Total",
        "table_name": "raw_data"
        }
)
def elt_pipeline():

    @task(task_id="extract_data")
    def extract():
        CONTEXT = get_current_context()
        params = CONTEXT["params"]
        API_URL = Variable.get("api_url")
        ENDPOINT_LOAD_DATA = Variable.get("load_endpoint")
        
        url = f"http://{API_URL}{ENDPOINT_LOAD_DATA}"
        body = {"file_name": params["file_name"], "sheet_name": params["sheet_name"], "table_name": params["table_name"]}
        logging.info(f"Sending request to {url} with body: {body}")
        res = post(url, json=body)
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json["message"])
        else:
            logging.error(res_json["error"])
            raise Exception("Failed to extract data")

    @task.branch(task_id="decide_compile")
    def decide_compile():
        context = get_current_context()
        params = context["params"]
        return "compile_dbt_models" if params["compile_dbt_models"] else "transform_data"

    @task(task_id="compile_dbt_models")
    def compile_models():
        API_URL = Variable.get("api_url")
        ENDPOINT_COMPILE_MODEL = Variable.get("compile_endpoint")
        url = f"http://{API_URL}{ENDPOINT_COMPILE_MODEL}"
        res = post(url, headers={"Content-Type": "application/json"})
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json["message"])
        else:
            logging.error(res_json["error"])
            raise Exception("Failed to compile dbt models")

    @task(task_id="transform_data", trigger_rule="one_success")
    def transform_data():
        API_URL = Variable.get("api_url")
        ENDPOINT_TRANSFORM_DATA = Variable.get("run_endpoint")
        
        url = f"http://{API_URL}{ENDPOINT_TRANSFORM_DATA}"
        res = post(url, headers={"Content-Type": "application/json"})
        res_json = res.json()

        if res_json.get("success"):
            logging.info(res_json["message"])
        else:
            logging.error(res_json["error"])
            raise Exception("Failed to transform data")

    extract_task = extract()
    decide_task = decide_compile()
    compile_task = compile_models()
    transform_task = transform_data()

    extract_task >> decide_task
    decide_task >> compile_task >> transform_task
    decide_task >> transform_task

elt_pipeline()