# Run "docker build" with a build context of the current directory
#   Example:
#     docker build -t floskl:1.0.0 .
#
# Note that the .dockerignore file ensures that the "COPY ./app" step
# below doesn't include undesired files/directories from local dev/debug.

# Starting point (some proper base image)
# See https://hub.docker.com/_/python for details
FROM python:3.12-alpine

# Copy necessary files from host's file system into container image
COPY ./app /app

# Location _inside_ the container image
WORKDIR /app

# Install (according to instruction in app/README)
RUN pip install -r requirements.txt

# Ensure that stdout reaches the container logs without delay  
ENV PYTHONUNBUFFERED=1

# What to run when the container starts (by default)
ENTRYPOINT ["gunicorn", "--config", "gunicorn_config.py"]
