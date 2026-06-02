from flask import Flask, request, jsonify
from subprocess import run, SubprocessError, TimeoutExpired
from sqlalchemy import create_engine, text
from pandas import read_excel
from dotenv import load_dotenv
from os import getenv

load_dotenv()

app = Flask(__name__)


@app.route("/run-dbt", methods=["POST"])
def run_dbt():
    """
    Run the dbt build command.
    """
    try:
        RES = run(
            ["dbt", "build", "--project-dir", "./dbt", "--profiles-dir", "./dbt"],
            capture_output=True,
            text=True,
        )

        # Raise an exception if the dbt command failed
        RES.check_returncode()

        return (
            jsonify(
                {
                    "success": True,
                    "message": "dbt command executed successfully!",
                    "output": RES.stdout,
                }
            ),
            200,
        )
    except TimeoutExpired:
        return (
            jsonify(
                {
                    "success": False,
                    "error": "dbt command timed out",
                    "output": RES.stderr,
                }
            ),
            500,
        )
    except SubprocessError:
        return (
            jsonify(
                {
                    "success": False,
                    "error": "Failed to execute dbt command",
                    "output": RES.stderr,
                }
            ),
            500,
        )


@app.route("/load-source-data", methods=["POST"])
def load_source_data():
    """
    Load source data into the database.

    Expects a JSON payload with the following structure:\n
    {
        "file_name": "file_name.xlsx", (must be located in the /app/api/data/ directory)
        "sheet_name": "Sheet1", (the name of the sheet in the Excel file to load)
        "table_name": "source_data_table" (the name of the table to create in the database, will be created in the bronze schema)
    }
    """
    PARAMS = request.get_json()
    USER = getenv("DB_USER")
    PASSWORD = getenv("DB_PASSWORD")
    DB_NAME = getenv("DB_NAME")
    CONN = f"postgresql+psycopg2://{USER}:{PASSWORD}@postgres:5432/{DB_NAME}"

    try:
        FILE = read_excel(
            f"/app/api/data/{PARAMS['file_name']}", sheet_name=PARAMS["sheet_name"]
        )
        ENGINE = create_engine(CONN)

        with ENGINE.connect() as conn:
            conn.execute(text("CREATE SCHEMA IF NOT EXISTS bronze;"))
            conn.commit()

        FILE.to_sql(
            PARAMS["table_name"],
            ENGINE,
            if_exists="replace",
            index=True,
            schema="bronze",
        )
        return (
            jsonify({"success": True, "message": "Source data loaded successfully!"}),
            201,
        )
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500


@app.route("/healthcheck", methods=["GET"])
def health_check():
    return jsonify({"success": True}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
