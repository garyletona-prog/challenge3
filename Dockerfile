# Use an official and lightweight Python base image
FROM python:3.12-slim

# Set environment variables for Python
ENV PYTHONUNBUFFERED True

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker's cache
COPY requirements.txt ./

# --- INICIO DE LA MODIFICACIÓN ---

# Paso 1: Copia la carpeta 'packages' (que Cloud Build descargó de GCS)
# al interior de la imagen de Docker.
COPY packages/ ./packages/

# Paso 2: Instala las dependencias usando SOLAMENTE los paquetes de la carpeta local.
# --no-index: Le dice a pip que NO se conecte al índice de paquetes de internet (PyPI).
# --find-links=./packages: Le dice a pip dónde encontrar los archivos de los paquetes.
RUN pip install --no-cache-dir --no-index --find-links=./packages -r requirements.txt

# Paso 3 (Opcional pero recomendado): Limpia la carpeta de paquetes después de la instalación
# para que la imagen final del contenedor sea más pequeña y eficiente.
RUN rm -rf ./packages/

# --- FIN DE LA MODIFICACIÓN ---

# Copy all of the application's source code
COPY . ./

# Expose the port that Cloud Run will use
EXPOSE 8080

# --- THIS IS THE CORRECTED AND FINAL STARTUP COMMAND ---
# Gunicorn will be responsible for running the production server.
# It will look for the 'app' object in the 'main.py' file.
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
