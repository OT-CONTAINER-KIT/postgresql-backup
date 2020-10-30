NETWORK=opstree
create-network:
	@echo "Creating network ${NETWORK}"
	@docker network create ${NETWORK} || true > /dev/null
	
