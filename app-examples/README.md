# Examples of containerized applications

Various examples, for different programming languages and technology stacks, can be found the the sub-directories. Each of these include their own `Dockerfile`, which encapsulates specific build/run instructions applicable for the implementations.

> ⚠️ These examples are ***not*** demonstrations of "best practices" for production-ready container images!

## Try things out

Take a look at the application source code and related instructions for how to build and run.

* [cpp-example](./cpp/app/)
* [cpp-example using Docker](./cpp/)
* [python-example](./python/app/)
* [python-example using Docker](./python/)

The sections below cover general ways of building, running and interacting with Docker images and containers.

## Build the container image

Typically you first `cd` into the application's directory (where the `Dockerfile` exists) before you build the container image. But that is not required as you can specify any path as the "build context root" argument (trailing "`.`" below, i.e. current directory)

```shell
docker build -t example-image:1.0.0 .
docker image ls # list all images on host
```

## Run the container

### Simplest form

```shell
docker run --name example-container example-image:1.0.0
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
docker run --init --rm -it example-image:1.0.0
```

* Abort via `Ctrl-C` thanks to `--init` option which makes `SIGINT` work better
* Container deleted after termination thanks to `--rm` option  
  (no need to give the container a deterministic name in this case)
* For apps which requires input via `stdin`, the `-it` flags are required

### Running in the background

Add the `-d` flag to run in "detached" mode. The output from the application must then be read via the `docker logs` command.

```shell
docker run --name example-container --rm --init -d example-image:1.0.0
docker ps # list running containers on host
docker logs example-container # add -f option to "follow"
docker stop example-container # more graceful than kill
```

## Clean up afterwards

```shell
docker image rm example-image:1.0.0
```

## Publish you images

Make the images available outside your local system by "pushing" them to an "OCI registry".

> There are many public registries, e.g. Docker Hub or GitHub Container registry. Individual companies and organizations can also host their own private registries.
>
> Here we make use of the [harbor.floskl.life](https://harbor.floskl.life) registry.

### Step 1, `tag` your image with the remote name

```shell
docker tag example-image:1.0.0 harbor.floskl.life/swc/example-image:1.0.0
```

The `/swc/` part is called a "namespace", which can be used to separate images for different applications, organizations individuals etc.

What's your namespace?

### Step2, `push` it

```shell
docker push harbor.floskl.life/swc/example-image:1.0.0 
```

This step assumes that you have "logged in" and have write permissions to the registry and namespace.

## Read the docs

The official [`docker` CLI docs](https://docs.docker.com/engine/reference/commandline/cli/) includes all the information on available commands and their options.
