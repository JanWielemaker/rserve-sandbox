image:
	docker build -t rserve .

run:
	docker run --detach --publish=127.0.0.1:6311:6311 rserve
