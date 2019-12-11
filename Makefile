IMAGE_NAME = umc_s2i

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

