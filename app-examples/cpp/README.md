# Example of containerized C++/CMake app

The [Dockerfile](./Dockerfile) shows the basic principles of encapsulating specific build/run instructions, as described in the [application's README](./app/README.md), into a language/stack invariant container image.

> ⚠️ This is ***not*** a demonstration of "best practices" for production-ready container images!

## Build the container image

```shell
docker build -t cpp-example:latest .
docker image ls # list all images on host
```

## Run the container

### Running with defaults

```shell
docker run --rm --init cpp-example:latest
```

* The `--rm` flag ensures that the container is deleted once in stops
* The `--init` flag ensures that `SIGINT` reaches the application when you do `Ctrl-C`

### Environment variable assignment

To override the default configuration the corresponding environment variable is overridden:

```shell
docker run --rm -e=APP_ITERATION_DELAY=10 cpp-example:latest
```

Refer to the [README in the parent directory](../README.md) for more options when running containers in general.
 