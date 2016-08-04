image:
	docker build -t rserve .

run:
	docker run Rserve

run2:
	docker run --detach --publish=6311:6311 rserve
