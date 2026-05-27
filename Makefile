# keep this startup order, olake last
COMPOSE = docker compose \
	-f docker/docker-compose-storage.yml \
	-f docker/docker-compose-pg-cdc.yml \
	-f docker/docker-compose-catalog.yml \
	-f docker/docker-compose-antalya.yml \
	-f docker/docker-compose-olake.yml \
	-f docker/docker-compose-metabase.yml \
	--env-file docker/.env

network:
	docker network inspect data-network >/dev/null 2>&1 || docker network create data-network

# waits for ClickHouse to accept connections, then runs setup automatically
up: network
	$(COMPOSE) up --build
	@echo "Waiting for ClickHouse..."
	@until docker exec vector clickhouse-client --user root --password topsecret --query "SELECT 1" >/dev/null 2>&1; do sleep 2; done
	@$(MAKE) --no-print-directory setup

down:
	$(COMPOSE) down

setup:
	docker exec vector clickhouse-client --user root --password topsecret \
	--queries-file /docker-entrypoint-initdb.d/iceberg.sql

destroy:
	$(COMPOSE) down --remove-orphans -v
	echo '{}' > docker/olake/config/state.json
	rm -f docker/data/ice-rest-catalog/var/lib/ice-rest-catalog/db.sqlite*
	rm -rf docker/clickhouse-data/vector/clickhouse
	rm -rf docker/clickhouse-data/swarm-1/clickhouse
	rm -rf docker/clickhouse-data/swarm-2/clickhouse
	rm -rf docker/clickhouse-data/keeper/keeper
