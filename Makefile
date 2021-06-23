DOPTS=--rm --net=none --detach --name=rserve
# Default limits for the R server processes
ROPTS=--limit-data=4000000 --limit-time=300 --limit-file=20000

all::
	@echo "Targets:"
	@echo
	@echo "  image		Build the docker image"
	@echo "  run		Run the image one time"
	@echo "  install	Run the image with --restart=unless-stopped"

image:	Dockerfile
	docker build -t rserve . 2>&1 | tee mkimg.log

run:
	docker run $(DOPTS) rserve $(ROPTS)

install:
	docker run $(DOPTS) --restart=unless-stopped rserve $(ROPTS)
