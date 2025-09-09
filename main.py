import os
from flask import Flask

# Inicializa la aplicación Flask
app = Flask(__name__)

@app.route("/")
def hello_serverless():
    """
    Ruta principal que devuelve un saludo.
    Obtiene el nombre del servicio de la variable de entorno K_SERVICE,
    que es común en Cloud Run.
    """
    # Obtiene el nombre del servicio de una variable de entorno o usa un valor por defecto
    service_name = os.environ.get("K_SERVICE", "un servicio sin servidor")
    print("Solicitud recibida para hello-serverless en Python")
    return f"¡Hola desde mi aplicación en Python corriendo en {service_name}!"

if __name__ == "__main__":
    # Inicia el servidor web. Escucha en el puerto definido por la variable PORT.
    # Cloud Run y otros servicios sin servidor establecen esta variable automáticamente.
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
