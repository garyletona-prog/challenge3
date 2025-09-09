# Etapa 1: Usar una imagen base de Python para instalar las dependencias
FROM python:3.12-slim as builder

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de requerimientos
COPY requirements.txt .

# Instalar las dependencias de la aplicación
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código fuente de la aplicación
COPY . .

# ---

# Etapa 2: Crear la imagen final de producción, que es más ligera y segura
FROM python:3.12-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos y las dependencias ya instaladas de la etapa anterior
COPY --from=builder /app .

# Exponer el puerto en el que correrá la aplicación (Cloud Run lo usará)
EXPOSE 8080

# El comando para iniciar la aplicación usando Gunicorn, un servidor de producción
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]