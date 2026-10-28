.PHONY: build run stop

build:
	docker build -t deltiet-battery .

run:
	docker run --rm -p 8888:8888 deltiet-battery

stop:
	docker ps -q --filter ancestor=deltiet-battery | xargs -r docker stop
