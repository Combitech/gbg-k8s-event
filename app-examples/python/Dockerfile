# Simple example - not a demonstration of "best practices" for production-ready container images!

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
ENTRYPOINT ["python3", "app.py"]
