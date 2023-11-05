# Examples of containerized applications

Various examples, for different programming languages and technology stacks, can be found the the sub-directories. Each of these include their own `Dockerfile`, which encapsulates specific build/run instructions applicable for the implementations.

> ⚠️ These examples are ***not*** demonstrations of "best practices" for production-ready container images!

## Try things out

In the examples below, the `cpp` application is used but the `docker` commands and generic and applies to all kinds of containerized application.

## Build the container image

Typically you first `cd` into the application's directory (where the `Dockerfile` exists) before you build the container image. But that is not required as you can specify any path as the "build context root" argument (trailing "`.`" below, i.e. current directory)

```shell
docker build -t example-image:latest .
docker image ls # list all images on host
```

## Run the container

### Simplest form

```shell
docker run --name example-container example-image:latest
```

A deterministic name is assigned via the `--name` options. This makes it easier to refer to it in other commands, e.g. when deleting it. 

> From a separate shell:
>
> ```shell
> docker ps # list all running containers on host
> docker container rm --force example-container # kill/remove
> ```

### Better alternative for interaction 

```shell
docker run --init --rm -it example-image:latest
```

* Abort via `Ctrl-C` thanks to `--init` option which makes `SIGINT` work better
* Container deleted after termination thanks to `--rm` option  
  (no need to give the container a deterministic name in this case)
* For apps which requires input via `stdin`, the `-it` flags are required

### Running in the background

Add the `-d` flag to run in "detached" mode. The output from the application must then be read via the `docker logs` command.

```shell
docker run --name example-container --rm --init -d example-image:latest
docker ps # list running containers on host
docker logs example-container # add -f option to "follow"
docker stop example-container # more graceful than kill
```

## Clean up afterwards

```shell
docker image rm ${EXAMPLE_IMAGE_NAME:?}:latest
```


## Read the docs

The official [`docker` CLI docs](https://docs.docker.com/engine/reference/commandline/cli/) includes all the information on available commands and their options.
