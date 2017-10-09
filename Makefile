DOPTS=--net=none --detach --name=rserve

all::
	@echo "Targets:"
	@echo
	@echo "  image		Build the docker image"
	@echo "  run		Run the image one time"
	@echo "  install	Run the image with --restart=unless-stopped"

image:	Dockerfile
	docker build -t rserve .

run:
	docker run $(DOPTS) rserve

install:
	docker run $(DOPTS) --restart=unless-stopped rserve
