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
    - Starts the Rserve container.  This creates a Unix domain
      socket `/home/rserve/socket` that allows for contacting
      the R server.

  - `make shell`
    - Starts the container with a shell, so you can look around

## Customization

Edit

  - `Dockerfile.in` for adding additional packages to R
  - `Rserve.sh` for setting limits for the Rserve processes
  - `Rserve.conf` for configuring the Rserve process.  Documentation
    is available from the [Rserve wiki](https://github.com/s-u/Rserve/wiki/rserve.conf)
