NETWORK=opstree

ifndef IMAGE_VERSION
	override IMAGE_VERSION = 0.1
endif

create-network:
	@echo "Creating network ${NETWORK}"
	@docker network create ${NETWORK} || true > /dev/null
	
setup-testdb:
	@docker exec testdb psql -h testdb -U postgres opstree -c "CREATE TABLE products (product_no integer, name text, price numeric);"
	@docker exec testdb psql -h testdb -U postgres opstree -c "INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', 9.99);"
	@docker exec testdb psql -h testdb -U postgres opstree -c "INSERT INTO products (product_no, name, price) VALUES (2, 'Cheese2', 2.99);"
	@docker exec testdb psql -h testdb -U postgres opstree -c "INSERT INTO products (product_no, name, price) VALUES (3, 'Cheese3', 3.99);"
	
run-testdb:
	@docker rm -f testdb || true > /dev/null
	@docker run -itd --rm --net ${NETWORK} --name testdb -e PGPASSWORD=password -e POSTGRES_PASSWORD=password -e POSTGRES_DB=opstree postgres:12.4
	sleep 5s
	make setup-testdb

build:
	docker build -t opstree/postgresqlbackup:$(IMAGE_VERSION) .

initStorage:
	@docker run -it --net ${NETWORK} -v ${PWD}/sample/properties:/etc/backup -v ${PWD}/sample/backup:/data/backup --rm opstree/postgresqlbackup:$(IMAGE_VERSION) init

listBackups:
	@docker run -it --net ${NETWORK} -v ${PWD}/sample/properties:/etc/backup -v ${PWD}/sample/backup:/data/backup --rm opstree/postgresqlbackup:$(IMAGE_VERSION) listBackups

backup:
	@docker run -it --net ${NETWORK} -v ${PWD}/sample/properties:/etc/backup -v ${PWD}/sample/backup:/data/backup --rm opstree/postgresqlbackup:$(IMAGE_VERSION) backup

restore:
	@docker run -it --net ${NETWORK} -v ${PWD}/sample/properties:/etc/backup -v ${PWD}/sample/backup:/data/backup --rm opstree/postgresqlbackup:$(IMAGE_VERSION) restore $(SNAPSHOT_ID)

run-debug:
	docker run -it --net ${NETWORK} -v ${PWD}/sample/properties:/etc/backup -v ${PWD}/sample/backup:/data/backup --rm --entrypoint /bin/bash opstree/postgresqlbackup:$(IMAGE_VERSION)

wait:
	@read -p "Press enter to continue...."
	clear

end-to-end-test:
	make run-testdb
	make wait
	rm -rf sample/backup

	make initStorage
	make wait

	make backup
	make wait

	make listBackups
	make wait

	make restore SNAPSHOT_ID=latest
	make wait
