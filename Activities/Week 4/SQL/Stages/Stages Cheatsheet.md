# Snowflake Data Loading: Assignment Cheat Sheet

This guide provides step-by-step instructions and code examples to help you complete the data loading assignment. It covers creating stages, defining file formats, and using both `COPY INTO` and `INSERT INTO` to load and transform data from different file types.

### Step 1: Environment Setup

First, make sure you are in the correct Snowflake context. Then, create your personal stage and the necessary file formats.

**1. Set Your Context**

```
USE ROLE de;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE TECHCATALYST;
-- This schema is for shared objects like your stage and formats
USE SCHEMA EXTERNAL_STAGE;
```

**2. Create Your Stage and File Formats** Replace `<YOURNAME>` with your name to create unique objects. The `s3_int`integration is already created for you.

```
-- Create a stage pointing to the S3 bucket
CREATE OR REPLACE STAGE <YOURNAME>_STAGE
  STORAGE_INTEGRATION = s3_int
  URL = 's3://techcatalyst-raw';

-- Create a format for JSON files
CREATE OR REPLACE FILE FORMAT <YOURNAME>_json_format
  TYPE = 'JSON';

-- Create a format for CSV files (handles headers and quotes)
CREATE OR REPLACE FILE FORMAT <YOURNAME>_csv_format
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1;

-- Create a format for Parquet files
CREATE OR REPLACE FILE FORMAT <YOURNAME>_parquet_format
  TYPE = 'PARQUET';
```

**3. Verify Your Setup** List files and check that your formats were created.

```
-- See the files in the public stage directory
LIST @<YOURNAME>_STAGE/stage/;

-- Confirm your file formats exist
SHOW FILE FORMATS;
```

### Step 2: Bulk Loading with `COPY INTO`

Use `COPY INTO` for a fast, direct data dump when your table schema perfectly matches the file's structure.

**1. Create the Destination Table** This command creates a temporary table in your personal schema (`<YOURSCHEMA>`) to hold the Parquet data.

```
CREATE OR REPLACE TEMPORARY TABLE TECHCATALYST.<YOURSCHEMA>.YELLOW_TAXI_PARQUET (
    VENDORID INT, TPEP_PICKUP_DATETIME TIMESTAMP, TPEP_DROPOFF_DATETIME TIMESTAMP,
    PASSENGER_COUNT FLOAT, TRIP_DISTANCE FLOAT, RATECODEID FLOAT, STORE_AND_FWD_FLAG VARCHAR,
    PULOCATIONID INT, DOLOCATIONID INT, PAYMENT_TYPE INT, FARE_AMOUNT FLOAT, EXTRA FLOAT,
    MTA_TAX FLOAT, TIP_AMOUNT FLOAT, TOLLS_AMOUNT FLOAT, IMPROVEMENT_SURCHARGE FLOAT,
    TOTAL_AMOUNT FLOAT, CONGESTION_SURCHARGE FLOAT, AIRPORT_FEE FLOAT
);
```

**2. Load the Parquet Data** This command copies data from the Parquet file into your table.

> **💡 Pro Tip:** Parquet files require `MATCH_BY_COLUMN_NAME` because the column order isn't guaranteed. This tells Snowflake to match data based on column names, not their position.

```
COPY INTO TECHCATALYST.<YOURSCHEMA>.YELLOW_TAXI_PARQUET
FROM '@<YOURNAME>_STAGE/stage/yellow_tripdata.parquet'
FILE_FORMAT = 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_parquet_format'
ON_ERROR = CONTINUE
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE; -- CRITICAL FOR PARQUET
```

### Step 3: Transforming Data with `INSERT INTO`

Use `INSERT INTO ... SELECT` when you need to manipulate data as you load it—like selecting specific columns, fixing data types, or creating new calculated fields.

#### Challenge 1: Simple Load (Select 5 Columns)

Here, you'll select a subset of columns from the staged files and fix the broken timestamp formats.

**1. Create the Destination Tables**

```
-- Table for CSV data
CREATE OR REPLACE TRANSIENT TABLE TECHCATALYST.<YOURSCHEMA>.SIMPLE_TAXI_DATA_CSV (
    VENDORID NUMBER, PICKUP_DATETIME TIMESTAMP, DROPOFF_DATETIME TIMESTAMP,
    TRIP_DISTANCE FLOAT, TOTAL_AMOUNT FLOAT
);

-- Table for Parquet data
CREATE OR REPLACE TRANSIENT TABLE TECHCATALYST.<YOURSCHEMA>.SIMPLE_TAXI_DATA_PARQUET (
    VENDORID NUMBER, PICKUP_DATETIME TIMESTAMP, DROPOFF_DATETIME TIMESTAMP,
    TRIP_DISTANCE FLOAT, TOTAL_AMOUNT FLOAT
);
```

**2. Load and Transform from CSV**

> **💡 Pro Tip:** For CSVs, you select columns by their position (`$1`, `$2`, etc.). Use `TO_TIMESTAMP()` to correctly parse the date and time strings.

```
INSERT INTO TECHCATALYST.<YOURSCHEMA>.SIMPLE_TAXI_DATA_CSV
SELECT
    $1::NUMBER,                  -- VendorID is the 1st column
    TO_TIMESTAMP($2, 'AUTO'),    -- Pickup time is the 2nd column
    TO_TIMESTAMP($3, 'AUTO'),    -- Dropoff time is the 3rd column
    $5::FLOAT,                   -- Trip distance is the 5th column
    $17::FLOAT                   -- Total amount is the 17th column
FROM
    '@<YOURNAME>_STAGE/stage/yellow_tripdata.csv'
    (FILE_FORMAT => 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_csv_format');
```

**3. Load and Transform from Parquet**

> **💡 Pro Tip:** For Parquet, you select columns by name (`$1:ColumnName`).

```
INSERT INTO TECHCATALYST.<YOURSCHEMA>.SIMPLE_TAXI_DATA_PARQUET
SELECT
    $1:VendorID::NUMBER,
    $1:tpep_pickup_datetime::TIMESTAMP,
    $1:tpep_dropoff_datetime::TIMESTAMP,
    $1:trip_distance::FLOAT,
    $1:total_amount::FLOAT
FROM
    '@<YOURNAME>_STAGE/stage/yellow_tripdata.parquet'
    (FILE_FORMAT => 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_parquet_format');
```

#### Challenge 2: Advanced Transformations (Summary Table)

Here, you will create new columns based on calculations and logic.

**1. Create the Destination Table** This one table will be used for data from all three file formats.

```
CREATE OR REPLACE TRANSIENT TABLE TECHCATALYST.<YOURSCHEMA>.SUMMARY_TAXI_DATA (
    VENDORID NUMBER, TPEP_PICKUP_DATETIME TIMESTAMP, TPEP_DROPOFF_DATETIME TIMESTAMP,
    TPEP_MONTH NUMBER, TPEP_YEAR NUMBER, TPEP_IS_WEEKEND STRING,
    PASSENGER_COUNT NUMBER, TRIP_DURATION_MINUTES FLOAT, TOTAL_AMOUNT FLOAT
);
```

**2. Load and Transform from JSON**

> **💡 Pro Tip:** JSON requires `LATERAL FLATTEN` to un-nest the data. You then access fields using `f.value:key_name`.

```
INSERT INTO TECHCATALYST.<YOURSCHEMA>.SUMMARY_TAXI_DATA
SELECT
    f.value:VendorID::NUMBER,
    TO_TIMESTAMP(f.value:tpep_pickup_datetime::STRING),
    TO_TIMESTAMP(f.value:tpep_dropoff_datetime::STRING),
    MONTH(TO_TIMESTAMP(f.value:tpep_pickup_datetime::STRING)),
    YEAR(TO_TIMESTAMP(f.value:tpep_pickup_datetime::STRING)),
    CASE WHEN DAYNAME(TO_TIMESTAMP(f.value:tpep_pickup_datetime::STRING)) IN ('Sat', 'Sun') THEN 'WEEKEND' ELSE 'WEEKDAY' END,
    f.value:passenger_count::NUMBER,
    DATEDIFF('minutes', TO_TIMESTAMP(f.value:tpep_pickup_datetime::STRING), TO_TIMESTAMP(f.value:tpep_dropoff_datetime::STRING)),
    (f.value:fare_amount::FLOAT + f.value:extra::FLOAT + f.value:mta_tax::FLOAT + f.value:tip_amount::FLOAT + f.value:tolls_amount::FLOAT + f.value:improvement_surcharge::FLOAT + f.value:total_amount::FLOAT + f.value:congestion_surcharge::FLOAT + f.value:Airport_fee::FLOAT)
FROM
    '@<YOURNAME>_STAGE/stage/yellow_tripdata.json'
    (FILE_FORMAT => 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_json_format'),
LATERAL FLATTEN(input => PARSE_JSON($1)) f;
```

**3. Load and Transform from Parquet** The logic is the same as JSON, but the syntax for selecting columns is `$1:ColumnName`.

```
INSERT INTO TECHCATALYST.<YOURSCHEMA>.SUMMARY_TAXI_DATA
SELECT
    $1:VendorID::NUMBER,
    $1:tpep_pickup_datetime::TIMESTAMP,
    $1:tpep_dropoff_datetime::TIMESTAMP,
    MONTH($1:tpep_pickup_datetime::TIMESTAMP),
    YEAR($1:tpep_pickup_datetime::TIMESTAMP),
    CASE WHEN DAYNAME($1:tpep_pickup_datetime::TIMESTAMP) IN ('Sat', 'Sun') THEN 'WEEKEND' ELSE 'WEEKDAY' END,
    $1:passenger_count::NUMBER,
    DATEDIFF('minutes', $1:tpep_pickup_datetime::TIMESTAMP, $1:tpep_dropoff_datetime::TIMESTAMP),
    $1:total_amount::FLOAT
FROM
    '@<YOURNAME>_STAGE/stage/yellow_tripdata.parquet'
    (FILE_FORMAT => 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_parquet_format');
```

**4. Load and Transform from CSV** Again, the logic is the same, but you select columns by position (`$1`, `$2`, etc.).

```
INSERT INTO TECHCATALYST.<YOURSCHEMA>.SUMMARY_TAXI_DATA
SELECT
    $1::NUMBER,
    TO_TIMESTAMP($2),
    TO_TIMESTAMP($3),
    MONTH(TO_TIMESTAMP($2)),
    YEAR(TO_TIMESTAMP($2)),
    CASE WHEN DAYNAME(TO_TIMESTAMP($2)) IN ('Sat', 'Sun') THEN 'WEEKEND' ELSE 'WEEKDAY' END,
    $4::NUMBER,
    DATEDIFF('minutes', TO_TIMESTAMP($2), TO_TIMESTAMP($3)),
    $17::FLOAT
FROM
    '@<YOURNAME>_STAGE/stage/yellow_tripdata.csv'
    (FILE_FORMAT => 'TECHCATALYST.EXTERNAL_STAGE.<YOURNAME>_csv_format');
```