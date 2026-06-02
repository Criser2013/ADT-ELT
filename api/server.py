from flask import Flask, request, jsonify
from subprocess import run, SubprocessError, TimeoutExpired

app = Flask(__name__)

@app.route("/run-dbt", methods=["POST"])
def run_dbt():
    try:
        RES = run(["dbt", "build", "--project-dir", "../dbt", "--profiles-dir", "../dbt"], capture_output=True, text=True)

        # Raise an exception if the dbt command failed
        RES.check_returncode()

        return jsonify({"success": True, "message": "dbt command executed successfully!", "output": RES.stdout}), 200
    except TimeoutExpired:
        return jsonify({"success": False, "error": "dbt command timed out", "output": RES.stderr}), 500
    except SubprocessError:
        return jsonify({"success": False, "error": "Failed to execute dbt command", "output": RES.stderr}), 500

@app.route("/load-source-data", methods=["POST"])
def load_source_data():
    data = request.get_json()
    # Here you would add the logic to load source data based on the received data
    return jsonify({"success": True, "message": "Source data loaded successfully!"}), 201

@app.route("/healthcheck", methods=["GET"])
def health_check():
    return jsonify({"success": True, "status": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)