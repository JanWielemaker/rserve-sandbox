# R Rserve docker image for safe execution

This directory builds a docker image based on Debian that safely executes 
Rserve. The Rserve instance is made available as `/home/rserve/socket`. To 
protect the container, we:

- Run the container using `--net=none` to disable networking inside
  the container
- Run `Rserve` as a non-priveleged user
- Disable most binaries using `chmod`, except for those needed.

## Installation

You need to install and enable Docker.

### Makefile targets

- `image`
  - Creates `/home/rserve`
  - Updates `Dockerfile`
  - Creates the docker image

- `run`
  - Starts the Rserve container.  This creates a Unix domain
    socket `/home/rserve/socket` that allows contacting
    the R server.

- `shell`
  - Starts the container with a shell, so you can look around

## Customization

Edit:

- `Dockerfile.in` for adding additional packages to R
- `Rserve.sh` for setting limits for the Rserve processes
- `Rserve.conf` for configuring the Rserve process. Documentation
   is available from the 
   [Rserve wiki](https://github.com/s-u/Rserve/wiki/rserve.conf)

## License

Copyright (c) 2016, Jan Wielemaker, Franco Masotti.
2-Clause BSD (aka FreeBSD).
