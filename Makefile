all::
	@echo "Targets:"
	@echo
	@echo "  image		Build the docker image"
	@echo "  run		Run the image one time"
	@echo "  install	Run the image with --restart=unless-stopped"
	@echo "  shell		Run an interactive shell in the image"

image:	Dockerfile
	docker build -t rserve .

run:
	docker run --net=none --detach --name=rserve rserve

install:
	docker run --net=none --detach --restart=unless-stopped rserve
