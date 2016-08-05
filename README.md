# R Rserve docker image for safe execution

This directory builds a docker image   that  safely executes Rserve. The
Rserve instance is made available as /home/rserve/socket. To protect the
container, we

  - Run the container using `--net=none` to disable networking inside
    the container
  - Run `Rserve` as a non-priveleged user
  - Disable most binaries using `chmod`, except for those needed.

## Installation

  - `make image`
    - Creates `/home/rserve`
    - Updates `Dockerfile`
    - Creates the docker image

  - `make run`
    - Starts the Rserve container

  - `make shell`
    - Starts the container with a shell, so you can look around
