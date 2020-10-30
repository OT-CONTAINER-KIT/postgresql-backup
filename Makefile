NETWORK=opstree

ifndef IMAGE_VERSION
	override IMAGE_VERSION = 0.1
endif

create-network:
	@echo "Creating network ${NETWORK}"
	@docker network create ${NETWORK} || true > /dev/null
	
run-testdb:
	@docker rm -f testdb || true > /dev/null
	@docker run -itd --rm --net ${NETWORK} --name testdb -e POSTGRES_PASSWORD=password postgres

build:
	docker build -t opstree/postgresqlbackup:$(IMAGE_VERSION) .

listBackups:
	docker run -it --rm opstree/postgresqlbackup:$(IMAGE_VERSION) listBackups

backup:
	docker run -it --rm opstree/postgresqlbackup:$(IMAGE_VERSION) backup

restore:
	docker run -it --rm opstree/postgresqlbackup:$(IMAGE_VERSION) restore