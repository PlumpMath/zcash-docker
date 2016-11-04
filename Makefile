IMAGE := zcash-1.0.0
.DEFAULT_GOAL := run

build:
	docker build --tag ${IMAGE} .

run:
	docker run --volume ${HOME}/docker/volumes/zcash:/root/.zcash ${IMAGE}

bash:
	docker run -it --entrypoint=/bin/bash --volume ${HOME}/docker/volumes/zcash:/root/.zcash ${IMAGE}
