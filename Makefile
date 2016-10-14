#!/usr/bin/make -f

# Copyright (c) 2016, Jan Wielemaker, Franco Masotti.
# See LICENSE file for details.

USER=rserve
UHOME=/home/$(USER)
MOUNT=-v /home/$(USER):/home/rserve

all::
	@echo "Targets:"
	@echo
	@echo "  image		Build the docker image"
	@echo "  run		Run the image one time"
	@echo "  install	Run the image with --restart=unless-stopped"
	@echo "  shell		Run an interactive shell in the image"

image:	Dockerfile
	docker build -t rserve .

Dockerfile: $(UHOME) Dockerfile.in
	sed -e "s/@USERID@/$$(id -u $(USER))/g" \
	    -e "s/@GROUPID@/$$(id -g $(USER))/g" \
		Dockerfile.in > Dockerfile

run:
	docker run --net=none --detach $(MOUNT) rserve

install:
	docker run --net=none --detach --restart=unless-stopped $(MOUNT) rserve

shell:
	docker run -it $(MOUNT)	rserve /bin/bash

user: $(UHOME)

$(UHOME):
	sudo useradd --system --create-home --home-dir $(UHOME) $(USER)
	sudo chmod 750 $(UHOME)

deluser:
	sudo userdel $(USER)
	sudo rm -rf $(UHOME)
