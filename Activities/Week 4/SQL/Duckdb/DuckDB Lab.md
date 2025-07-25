# Lab: From Ad-Hoc Analysis to Managed Data Lakes with DuckDB & DuckLake

## 1. Introduction & Learning Objectives

Welcome to the DuckDB lab! In the world of data engineering, we often need to quickly inspect, analyze, and transform data that lives in files across various storage systems. Traditional data warehouses can be slow and cumbersome for these ad-hoc tasks, requiring lengthy data loading (ETL) processes.

In this lab, you will explore **DuckDB**, a high-performance, in-process analytical database system often called the "Swiss Army knife for data." We'll see how it can directly query data living in files on your local machine or in cloud storage like AWS S3.

Then, we will level up by exploring **DuckLake**, a DuckDB extension that brings powerful data management features like ACID transactions, data versioning, and time travel directly to your data lake files.

> [!NOTE]
>
> **DuckDB** is an **in-process SQL OLAP** database management system designed for fast analytical queries. It uses a columnar execution engine that supports parallel execution and can efficiently process datasets larger than system memory. DuckDB is optimized for analytical workloads and can be embedded locally on your machine or used in various environments to run complex SQL queries quickly
>
> **DuckLake** is a new open **lakehouse** format developed by the creators of DuckDB that innovates the data lake architecture by managing metadata using a standard SQL database instead of complex file-based systems. DuckLake stores metadata in an ACID-compliant catalog database (such as PostgreSQL, MySQL, SQLite, or even DuckDB itself) while keeping the actual data in open Parquet files on scalable object storage like S3. This approach allows efficient multi-table transactions, full schema evolution, time travel queries, and high concurrency without the metadata bloat and performance overhead typical in current lakehouse formats like Iceberg or Delta Lake
>
> Key features of DuckLake include:
>
> - **Using a database for metadata management** to leverage transactionality, indexing, constraint enforcement, and query optimization.
> - Separation of **storage (Parquet files)** and **metadata (SQL database)** for scalable and flexible architecture.
> - Support for **ACID transactions**, **schema evolution**, **multi-table operations**, and **time travel queries**.
> - Compatibility of data files with **Apache Iceberg**, enabling metadata-only migration.
> - Reduction in required compactions and efficient handling of small data changes via catalog-managed inlining.
> - Implementation as a DuckDB extension (from v1.3.0), making it easy to deploy DuckLake with DuckDB on various platforms.
>
> In summary, DuckDB provides a powerful, embedded analytical database engine, while DuckLake builds on DuckDB’s philosophy to offer a modern, SQL-driven lakehouse format that simplifies metadata management, enhances concurrency, and scales efficiently for enterprise scenarios

### Learning Objectives

By the end of this lab, you will be able to:

- Install and run the DuckDB command-line interface (CLI).
- Directly query Parquet and CSV files from remote AWS S3 buckets.
- Create persistent tables within a DuckDB database from remote data.
- Export query results from DuckDB back to files.
- Understand and use DuckLake to create managed tables on a data lake.
- Perform data modifications (like `DELETE`) and use "time travel" to query previous versions of your data.
- Articulate the key advantages of DuckDB and DuckLake in modern data engineering workflows.

## 2. Prerequisites

- Access to a command-line terminal.
- Basic knowledge of SQL queries (`SELECT`, `FROM`, `WHERE`).
- Your personal **AWS S3 credentials** (`KEY_ID` and `SECRET`) and an S3 bucket you have write access to.

> [!WARNING]
>
> **Security Warning**: REMEMBER never hardcode your credentials or commit them to a public repository. DuckDB's `SECRET` object stores them securely for your session.

## 3. Part 1: The Power of DuckDB for Ad-Hoc Analysis

In this part, we'll focus on DuckDB's core strength: its ability to analyze data *where it lives*.

### 3.1. Installation

> [!NOTE]
>
> You will be using **Codespaces** for this lab and will do everything using the Linux Terminal. 
>
> For programmatic use in applications, you would typically install the Python library with `pip install duckdb`, but for this lab, we will use the **powerful CLI**). Next week, you will learn how to use DuckDB in **JupyterLab** and see how it integrates with **pandas**.

First, let's install the DuckDB CLI. Open your terminal and run the following command:

```shell
# This script will download and extract the DuckDB CLI into your current directory.
curl https://install.duckdb.org | sh
```

You should now have a `duckdb` executable file. You can run it by typing `./duckdb`.

### 3.2. Connecting to S3

To allow DuckDB to access data in AWS S3, we first need to install the `httpfs` extension (which often comes pre-packaged) and securely provide our credentials.

```sql
-- Start the DuckDB CLI in-memory mode
>> duckdb

-- You don't need to install httpfs, it should be loaded automatically, but in case you ran into an issue you can install and load the extension.
-- To install the httpfs extension for reading from remote sources like S3
INSTALL httpfs;
LOAD httpfs;

-- Create a reusable, secure SECRET object with your AWS credentials.
-- IMPORTANT: Replace the placeholder values with your actual AWS credentials.
CREATE OR REPLACE SECRET s3_credentials (
    TYPE S3,
    PROVIDER CONFIG,
    KEY_ID 'YOUR_AWS_KEY_ID',
    SECRET 'YOUR_AWS_SECRET_ACCESS_KEY',
    REGION 'us-east-2'
);
```

### 3.3. Querying Remote Files Directly

Now for the magic. Let's query some NYC Yellow Taxi trip data stored in a public S3 bucket. We don't need to download or load anything first.

```sql
-- Let's inspect the schema of a single Parquet file without reading all the data.
DESCRIBE TABLE 's3://techcatalyst-raw/yellow_tripdata_2024-01.parquet';

-- Now, run a query across MULTIPLE parquet files using a glob pattern (wildcard).
-- DuckDB will scan all matching files and treat them as a single table.
SELECT COUNT(*) FROM 's3://techcatalyst-raw/yellow_tripdata_2024-*.parquet';

-- Let's run a more complex analytical query.
-- Find the top 5 busiest days in the first quarter of 2024.
SELECT
    CAST(tpep_pickup_datetime AS DATE) AS pickup_day,
    COUNT(*) AS trip_count
FROM 's3://techcatalyst-raw/yellow_tripdata_2024-*.parquet'
WHERE
    STRFTIME('%m', tpep_pickup_datetime) IN ('01', '02', '03')
GROUP BY
    pickup_day
ORDER BY
    trip_count DESC
LIMIT 5;
```

Notice how fast that was! You just ran a complex analytical query on gigabytes of data without a traditional data warehouse.

### 3.4. Persisting Data and Exporting Results

Sometimes, you want to save a subset of data locally for even faster access.

~~~sql
-- Exit the in-memory CLI by typing .exit
-- Now, let's create a persistent database file named 'taxi_lab.db'
ATTACH 'taxi_lab.db';
USE 'taxi_lab';

-- Create a persistent table named 'april_trips' by selecting data from a remote file.
CREATE OR REPLACE TABLE april_trips AS
SELECT * FROM 's3://techcatalyst-raw/yellow_tripdata_2024-04.parquet';

-- Now queries on this table are lightning fast because the data is local.
-- DuckDB has its own unique, concise syntax. This is the same as SELECT * FROM ...
FROM april_trips;

-- Let's use the SUMMARIZE command to get a quick overview of our local table.
SUMMARIZE april_trips;

-- Now, let's export the first 100 rows of our table to a new Parquet file
-- in YOUR OWN S3 bucket.
-- IMPORTANT: Replace 's3://your-bucket-name/your-folder/' with your actual S3 path.
COPY
  (SELECT * EXCLUDE (congestion_surcharge, airport_fee) FROM april_trips LIMIT 100)
  TO 's3://techcatalyst-raw/YOURNAME/test_export.parquet'
  (FORMAT PARQUET);
~~~

You have successfully queried remote data, created a local persistent table, and exported a result set back to the cloud.

## 4. Part 2: Managing the Data Lake with DuckLake

Querying raw files is great, but what happens when you need to update records, delete data, or see what a dataset looked like last week? This is where DuckLake comes in, adding a transactional layer on top of your data lake.

### 4.1. Setup and Creating a Lake

Let's start fresh in a new database file.

~~~sql
-- Exit the current DuckDB session (.exit) and start a new one.
-- Install and load the required extensions.
INSTALL ducklake;
LOAD ducklake;

-- This is the key step: Attach a DuckLake instance.
-- This tells DuckDB to use a file named 'datalake.ducklake' to track
-- the metadata and history for a lake we are calling 'taxi_lake'.
ATTACH 'ducklake:datalake.ducklake' AS taxi_lake;
USE taxi_lake;

-- to verify
SELECT CURRENT_DATABASE();
~~~

### 4.2. Creating a Managed Table and Making Changes

Now, instead of creating a regular table, we'll create a managed table within our new lake.

```sql
-- Create a managed table in our 'taxi_lake'.
-- DuckLake will copy the data into its own managed storage format (Parquet).
-- We will use a smaller CSV file for this example.
CREATE OR REPLACE TABLE taxi_lake.daily_trips AS
SELECT * FROM 's3://techcatalyst-raw/stages/yellow_dailytrip.csv';

-- Let's see how many trips were paid for by credit card (payment_type = 1)
SELECT count(*) FROM taxi_lake.daily_trips WHERE payment_type = 1;
```

Now, let's look at the history. DuckLake creates a "snapshot" every time the data is changed.

```sql
-- View the history of our managed table. You should see one entry for the initial creation.
FROM ducklake_snapshots('taxi_lake');
```

Let's imagine we discovered that all VendorID 1 data was faulty and needs to be removed.

```sql
-- Delete records from our managed table.
DELETE FROM taxi_lake.daily_trips WHERE VendorID = 1;

-- Check the count again. It should be lower.
SELECT count(*) FROM taxi_lake.daily_trips;

-- Now, check the snapshots again. You will see a new entry for the DELETE operation!
FROM ducklake_snapshots('taxi_lake');
```

### 4.3. Time Travel: Querying the Past

This is the most powerful feature. The `DELETE` operation was non-destructive. The old data still exists in the previous version. We can query it using the `snapshot_id` from the `ducklake_snapshots` table.

```sql
-- The first snapshot (before the delete) should have snapshot_id = 1.
-- Let's query the table AS OF that version.
-- The result should be the original, higher count.
SELECT count(*) FROM taxi_lake.daily_trips AT (VERSION => 1);

FROM ducklake_table_changes('taxi_lake', 'daily_trips', 'main', 1, 2);
```

You have just performed a `DELETE` on a table in your data lake and then used time travel to audit the changes and query the data exactly as it was before the operation.

## 5. Reflection and Key Takeaways

Please answer the following questions to solidify your understanding.

1. **Ad-Hoc Analysis:** What are the main advantages of using DuckDB to query files directly in S3 compared to a traditional data warehouse workflow that requires an `INSERT` or `COPY INTO` command first?
2. **Performance & Persistence:** When would you choose to create a persistent DuckDB table (like `april_trips`) versus always querying the source files directly?
3. **The Problem DuckLake Solves:** In your own words, what core problem does DuckLake solve for a data engineer managing files in a data lake?
4. **Real-World Time Travel:** Describe a real-world scenario where DuckLake's time travel feature would be incredibly useful. (e.g., correcting a mistaken data update, auditing, machine learning model reproducibility).