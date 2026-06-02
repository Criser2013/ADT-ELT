from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/run-dbt", methods=["POST"])
def run_dbt():
    data = request.get_json()
    # Here you would add the logic to run your dbt commands based on the received data
    # For example, you could use subprocess to call dbt CLI commands
    # subprocess.run(["dbt", "run", "--models", data["models"]])
    
    return jsonify({"message": "dbt command executed successfully!"})

@app.route("/load-source-data", methods=["POST"])
def load_source_data():
    data = request.get_json()
    # Here you would add the logic to load source data based on the received data
    return jsonify({"message": "Source data loaded successfully!"})

@app.route("/healthcheck", methods=["GET"])
def health_check():
    return jsonify({"status": "ok"})