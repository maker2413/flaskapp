.PHONY: run

build:
	@docker build \
		-t flask:test \
		.

run:
	@docker run \
		-p 5000:5000 \
		-d \
		--rm \
		--name flask-test \
		flask:test

stop:
	@docker stop flask-test
