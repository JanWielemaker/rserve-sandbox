image:
	docker build -t Rserve .

run:
	docker run Rserve

run2:
	docker run --detach --publish=6311:6311 Rserve
