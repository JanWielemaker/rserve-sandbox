# DOPTS=--net=none --detach --name=rserve
DOPTS=--net=none --detach -v /home/rserve:/rserve
ROPTS=--limit-data=unlimited --limit-time=900 --limit-file=10000000

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
