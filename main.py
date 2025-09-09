from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello_world():
    """Ruta principal que devuelve un saludo."""
    return "¡Hola Mundo! Mi aplicación está funcionando en Cloud Run."

if __name__ == "__main__":
    # Este bloque ahora sí es importante para que Gunicorn funcione correctamente.
    # Escucha en el puerto que Cloud Run proporciona.
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
