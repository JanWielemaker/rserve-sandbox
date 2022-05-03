# R Rserve docker image for safe execution

This directory builds a docker image that safely executes Rserve. Rserve
connections use a Unix domain socket,  such   that  the container can be
started with the `--net=none` to deny it   any  access to a network. The
socket is created in the volume `/rserve`  and named `socket`. There are
two ways to make the socket available:

  1. Start using `--name=rserve`.  This makes the socket available from
  embedded volume. Other docket container can use `--with-volumes-from
  rserve` to get access to the Rserve socket.

    ```
    docker run --net=none --name=rserve rserve
    ```


  2. Create a directory that is owned by a non-priviledged user/group
  and has its permissions set to provide access to the selected users.
  For example:

    ```
    useradd -U --create-home --home=/home/rserve rserve
    chmod 770 /home/rserve
    ```

  Now, the image can be started using the command below, creating
  `/home/rserve/socket`.  Note that the R server runs with the
  UID/GID of the mounted directory.

    ```
    docker run --net=none -v /home/rserve:/rserve rserve
    ```

## Safety

To protect the container, we

  - Run the container using `--net=none` to disable networking inside
    the container
  - Run `Rserve` as a non-priveleged user
  - Disable all executables using `chmod 0`, except for those
    needed to run `R`.

## Installation

  - `make image`
    - Creates the docker image

  - `make run`
    - Starts the Rserve container.  This creates a Unix domain
      socket `/home/rserve/socket` that allows for contacting
      the R server.

## Customization

  - The entry point `Rserve.sh` accepts options to limit resources.
    Use the command below for details

    ```
    docker run rserve --help
    ```

  - Please edit `Dockerfile` to add additional R packages.
