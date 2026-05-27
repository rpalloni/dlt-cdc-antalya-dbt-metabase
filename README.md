## architecture

Client-Server model architecture: Antalya (ClickHouse) as query engine created as an infrastructure component on a dedicated container to read and write Iceberg tables

CDC pipeline: PostgreSQL changes are captured in real time and written to Apache Iceberg tables on MinIO object storage. 

```
PostgreSQL (WAL)    --> OLake --> Iceberg   / MinIO <-- Trino
```

OLake use the ice rest catalog to track Iceberg table metadata. Antalya connects to the same catalog to discover and query those tables.