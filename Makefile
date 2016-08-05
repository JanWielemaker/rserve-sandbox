USER=rserve
UHOME=/home/$(USER)
MOUNT=-v /home/$(USER):/home/rserve

image:	Dockerfile
	docker build -t rserve .

Dockerfile: $(UHOME) Dockerfile.in
	sed -e "s/@USERID@/$$(id -u $(USER))/g" \
	    -e "s/@GROUPID@/$$(id -g $(USER))/g" \
		Dockerfile.in > Dockerfile

run:
	docker run --net=none --detach $(MOUNT) rserve

shell:
	docker run -it $(MOUNT)	rserve /bin/bash

user: $(UHOME)

$(UHOME):
	sudo useradd --system --create-home --home-dir $(UHOME) $(USER)
	sudo chmod 750 $(UHOME)

deluser:
	sudo userdel $(USER)
	sudo rm -rf $(UHOME)
