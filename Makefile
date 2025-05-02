ECW_DIR=./ECW
VALIDATOR=./scripts/validate-ecw.sh
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
	@if docker ps --format '{{.Names}}' | grep -q "^$(CONTAINER_NAME)$$"; then \
		echo "⚠️ Container $(CONTAINER_NAME) already running"; \
		exit 0; \
	elif docker ps -a --format '{{.Names}}' | grep -q "^$(CONTAINER_NAME)$$"; then \
		echo "🔄 Starting GeoServer container..."; \
		docker start $(CONTAINER_NAME); \
	else \
		echo "🚀 Running GeoServer container..."; \
		docker run -d -p $(GEOSERVER_PORT):8080 \
			-v $(PWD)/data_dir:/opt/geoserver/data_dir \
			--name $(CONTAINER_NAME) \
			$(IMAGE_NAME); \
	fi
	@echo "⏳ Waiting for GeoServer ready..."
	@while ! docker logs $(CONTAINER_NAME) 2>&1 | grep -q "Started @"; do \
		sleep 2; \
	done
	@echo "✅ GeoServer is ready! Visit: http://localhost:$(GEOSERVER_PORT)/geoserver"

stop:
	@echo "🚀 Stopping GeoServer container..."
	docker stop $(CONTAINER_NAME)

clean:
	@echo "🧹 Cleaning up..."
	rm -rf $(PWD)/data_dir
	docker container rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true

.PHONY: all validate build run stop clean
