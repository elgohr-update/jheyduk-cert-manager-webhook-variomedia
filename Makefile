IMAGE_NAME := "cert-manager-webhook-variomedia"
IMAGE_TAG := "latest"

OUT := $(shell pwd)/_out

$(shell mkdir -p "$(OUT)")

verify:
	go test -v .

build:
	docker build --rm -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: rendered-manifest.yaml
rendered-manifest.yaml:
#	    --name cert-manager-webhook-variomedia $BACKSLASH
	helm template \
        --set image.repository=$(IMAGE_NAME) \
        --set image.tag=$(IMAGE_TAG) \
        deploy/cert-manager-webhook-variomedia > "$(OUT)/rendered-manifest.yaml"
