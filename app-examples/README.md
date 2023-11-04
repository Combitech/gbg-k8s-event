# Generic example of containerized applications

Various examples, for different programming languages and technology stacks, can be found the the sub-directories. Each of these include a specific `Dockerfile`, which encapsulates specific build/run instructions applicable for the implementation.

> ⚠️ These examples are ***not*** demonstrations of "best practices" for production-ready container images!

## Prepare naming shortcuts

To simplify the instructions below, environment variables are used to point out sub-directories and image/container names. If you prefer, you can write these names directly in your commands instead.

In this example the "cpp" application is used but feel free to point out any of the other examples instead, e.g. "python".

```shell
export EXAMPLE_APP_DIR=./cpp
export EXAMPLE_IMAGE_NAME=cpp-example
export EXAMPLE_CONTAINER_NAME=cpp-example
```

## Build the container image

```shell
docker build -t ${EXAMPLE_IMAGE_NAME:?}:latest ${EXAMPLE_APP_DIR:?}
docker image ls # list all images on host
```

## Run the container

### Simplest form

```shell
docker run --name ${EXAMPLE_CONTAINER_NAME:?} ${EXAMPLE_IMAGE_NAME:?}:latest
```

> From a separate shell:
>
> ```shell
> docker ps # list all running containers on host
> docker container rm --force ${EXAMPLE_CONTAINER_NAME:?} # kill/remove
> ```

### Better alternative for interaction 

```shell
docker run --init --rm -it --name ${EXAMPLE_CONTAINER_NAME:?} ${EXAMPLE_IMAGE_NAME:?}:latest
```

* Abort via `Ctrl-C` thanks to `--init` option
* Container deleted after termination thanks to `--rm` option
* For apps which requires input via `stdin`, the `-it` flags are required

### Running "detached" (in the background)

```shell
docker run --name ${EXAMPLE_CONTAINER_NAME:?} --rm -d ${EXAMPLE_IMAGE_NAME:?}:latest
docker ps # list running containers on host
docker logs ${EXAMPLE_CONTAINER_NAME:?} # add -f option to "follow"
docker stop ${EXAMPLE_CONTAINER_NAME:?} # more graceful than kill
```

## Clean up afterwards

```shell
docker image rm ${EXAMPLE_IMAGE_NAME:?}:latest
```