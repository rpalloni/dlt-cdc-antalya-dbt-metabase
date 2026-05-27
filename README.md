## architecture

Client-Server model architecture: Antalya (ClickHouse) as query engine created as an infrastructure component on a dedicated container to read and write Iceberg tables

CDC pipeline: PostgreSQL changes are captured in real time and written to Apache Iceberg tables on MinIO object storage. 

```
PostgreSQL (WAL) --> OLake --> Iceberg / MinIO <-- Antalya --> Metabase
```

OLake uses the ice rest catalog to track Iceberg table metadata. Antalya connects to the same catalog to discover and query those tables.


## Metabase
Official connector ClickHouse

| Field    | Value              |
| -------- | -------------------|
| UI       | localhost:3000     |
| Host     | vector             |
| Port     | 8123               |
| User     | root               |
| Password | topsecret          |