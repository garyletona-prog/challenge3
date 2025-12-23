from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello_world():
    """Main route that returns a greeting."""
    return "Hello again World!!!!!!!!!! My application is running on Cloud Run."

if __name__ == "__main__":
    # This block is now important for Gunicorn to work correctly.
    # It listens on the port that Cloud Run provides.
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))

