# gbg-k8s-event

Demo of containers and Kubernetes at the Göteborg office

## Setup

If Docker and/or Visual Studio Code are not already installed on the system, these tools can be installed via scripts:

```shell
scripts/install-docker.sh
scripts/install-code.sh
```

> ⚠️ Do not run the install script if the tool is already installed.

## Running "devcontainers"

This repository includes a predefined "[devcontainer](https://containers.dev/)" (in the [`.devcontainer/`](./.devcontainer) directory). When the repository root is opened in Visual Studio Code ("open folder", e.g. via `code .`), you can then choose to open the folder in that container. This will give you an environment where necessary tools, such as `docker`, `kubectl`, `python` and others are available.

Once the devcontainer has started, you can use the terminal _within_ Visual Studio Code to run commands.

## Application examples

Simple (dummy) applications, implemented in various languages, can be found under [`app-examples/`](./app-examples). The purpose of these is to show how containerization (via Docker in this case) can be used to harmonized the build- and execution experience for different stacks.

Please refer to the dedicated [README](./app-examples/README.md) for further details.

## Kubernetes examples

Examples of manifests for Pods, Services, Secrets etc. can be found under [`k8s-examples/`](./k8s-examples).

Please refer to the dedicated [README](./k8s-examples/README.md) for further details.

## Main application

The main application ("floskl") to containerize and eventually deploy in Kubernetes is cloned from a separate repository. A convenience script is provided to help out with this.

```shell
scripts/init-fresh-repo.sh
```

> ⚠️ If you have a prior version of this repo cloned, that version will be deleted.

To work with the main application you are recommended to open the application folder in a separate Visual Studio Code instance. This will enable you to leverage tasks and launcher/debugger options prepared for local development.

Run the following command from a terminal _within_ the devcontainer, i.e. the first Visual Studio Code instance.

```shell
code repos/floskl
```

Then follow the instructions in the [README](https://github.com/uivraeus/floskl#readme) of the application repo for further guidance.
