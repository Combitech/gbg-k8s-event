# Simple example - not a demonstration of "best practices" for production-ready container images!

# Starting point (some proper base image)
FROM ubuntu:latest

# Ensure that required tools are installed
RUN apt update && apt install -y g++ cmake

# Copy files from host's file system into container image
COPY ./app /app

# Location _inside_ the container image
WORKDIR /app

# Build (according to instructions in the README)
RUN mkdir build && cd build && cmake .. && make

ENTRYPOINT ["build/app"]
