# Usar una imagen base de Python oficial y ligera
FROM python:3.12-slim

# Establecer variables de entorno para Python
ENV PYTHONUNBUFFERED True

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de requerimientos primero para aprovechar la caché de Docker
COPY requirements.txt ./

# Instalar las dependencias de la aplicación
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el código de la aplicación
COPY . ./

# Exponer el puerto que Cloud Run usará
EXPOSE 8080

# --- ESTE ES EL COMANDO DE ARRANQUE CORREGIDO Y DEFINITIVO ---
# Gunicorn se encargará de ejecutar el servidor de producción.
# Buscará el objeto 'app' en el archivo 'main.py'.
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]

