-- Creates the Iceberg catalog database that maps the REST catalog

CREATE DATABASE IF NOT EXISTS iceberg
ENGINE = Iceberg('http://ice-rest-catalog:5000/')
SETTINGS
    catalog_type = 'rest',
    warehouse = 's3://iceberg',
    storage_endpoint = 'http://minio:9000',
    aws_access_key_id = 'admin',
    aws_secret_access_key = 'password';