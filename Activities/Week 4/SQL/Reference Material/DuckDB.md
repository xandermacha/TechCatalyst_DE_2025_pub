# DuckDB

To install in GitHub Codespaces terminal

```shell
curl https://install.duckdb.org | sh
```

To install as a Python library 

```python
pip install duckdb
```

---

## Terminal

Start by creating an empty database using

```
duckdb my_database.db
```

To start the DuckDB terminal just type

```shell
duckdb
```

You can try these commands 

```sql
show databases;
```

## Connecting to AWS S3

You will need to create a SECRET object

```sql
CREATE OR REPLACE SECRET secret (
    TYPE s3,
    PROVIDER config,
    KEY_ID 'YOURKEYID',
    SECRET 'YOURSECRET',
    REGION 'us-east-2'
);
```

Once created, you can read from a private S3 repo as shown:

```sql
DESC TABLE 's3://techcatalyst-raw/yellow_tripdata_2024-01.parquet';
```

```sql
SELECT COUNT(*) FROM 's3://techcatalyst-raw/yellow_tripdata_2024-*.parquet';
```

OR create a table

```sql
CREATE TABLE taxi AS
SELECT * FROM 's3://techcatalyst-raw/yellow_tripdata_2024-04.parquet';
```

You can now query the `taxi` table. 

To export you results you can use the `COPY` and `to` commands

```sql
copy
	(select * from taxi limit 100)
	to 's3://techcatalyst-raw/tarek/test.parquet'
	(format parquet);
```



