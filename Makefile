image:
	docker build -t rserve .

run:
	docker run --detach --publish=6311:6311 rserve
