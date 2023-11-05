# Example of containerized Python app

The [Dockerfile](./Dockerfile) shows the basic principles of encapsulating specific install/run instructions, as described in the [application's README](./app/README.md), into a language/stack invariant container image.

> ⚠️ This is ***not*** a demonstration of "best practices" for production-ready container images!

## Build the container image

```shell
docker build -t python-example:latest .
docker image ls # list all images on host
```

## Run the container

```shell
docker run --rm -e=SERVER_HOST=0.0.0.0 -e=SERVER_PORT=4000 -p 127.0.0.1:5000:5000 python-example:latest
```
* The `--rm` flag ensures that the container is deleted once in stops
* The `-e` options configure environment variables used by the application
* The `-p` options "publishes" 4000 _inside_ the container to `127.0.0.1:5000` on the host.

> ❓***Confusing URL?***
>
> The log output printed when the application starts includes a URL as it applies _within_ the container.
>
> But to reach the server from the outside, the _published_ host/port address must be used (`127.0.0.1:5000` in this example) 

Refer to the [README in the parent directory](../README.md) for more options when running containers in general.
 