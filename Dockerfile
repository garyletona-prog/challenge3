# Use an official and lightweight Python base image
FROM python:3.12-slim

# Set environment variables for Python
ENV PYTHONUNBUFFERED True

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker's cache
COPY requirements.txt ./

# Install the application dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all of the application's source code
COPY . ./

# Expose the port that Cloud Run will use
EXPOSE 8080

# --- THIS IS THE CORRECTED AND FINAL STARTUP COMMAND ---
# Gunicorn will be responsible for running the production server.
# It will look for the 'app' object in the 'main.py' file.
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
