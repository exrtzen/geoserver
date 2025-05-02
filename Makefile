ECW_DIR=./ECW
VALIDATOR=./validate-ecw.sh
IMAGE_NAME=ghcr.io/exrtzen/geoserver:2.20.4-ecw5.4
GEOSERVER_PORT=8080
CONTAINER_NAME=geoserver

all: validate build

validate:
	@echo "🔍 Validating ECW directory..."
	@bash $(VALIDATOR) $(ECW_DIR)

build:
	@echo "🐳 Building Docker image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) .

run:
	@echo "🚀 Running GeoServer container..."
	docker run -d -p $(GEOSERVER_PORT):8080 \
	  -v $(PWD)/data_dir:/opt/geoserver/data_dir \
	  --name $(CONTAINER_NAME) \
	  $(IMAGE_NAME)

stop:
	@echo "🚀 Stopping GeoServer container..."
	docker stop $(CONTAINER_NAME)

clean:
	@echo "🧹 Cleaning up..."
	rm -rf $(PWD)/data_dir
	docker container rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true

.PHONY: all validate build run stop clean
