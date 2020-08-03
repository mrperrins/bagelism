DOCKER_IMAGE_VERSION=0.1.1
DOCKER_IMAGE_NAME=mrperrins/bagelism-hq
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	dockerize -t $(DOCKER_IMAGE_NAME) \
		--add-file index.html /www/ \
		--add-file bagels.jpg /www/ \
		--entry '/bin/bagelism' \
		--cmd 'httpd -f -p 80 -h /www' \
		/bin/bagelism
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker build -t mrperrins/rpi-bagelism-httpd .
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_TAGNAME)

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm mrperrins/bagelism-hq /bin/bagelism echo "Success."
