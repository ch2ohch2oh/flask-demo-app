# /home/dazhi/webapp/Dockerfile

# Use a slim and official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables to make Python behave nicely in a container
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Copy and install dependencies first to leverage Docker's layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application's code
COPY . .

# The command to run your application, derived from your Procfile.
# It binds to port 8080, which fly.toml is configured to expect.
# The `src.app:app` part assumes your Flask app object is named `app` in `src/app.py`.
CMD ["gunicorn", "--bind", ":8080", "--workers", "4", "src.app:app"]