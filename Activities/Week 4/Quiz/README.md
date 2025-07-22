![Quiz Time (virtual) - Team Build](images/quiztime-640w.jpg.jpg)

# Data Engineering Comprehensive Quiz



**Instructions:** For each question, please select the best possible answer.

---

## 1. ETL vs ELT

Which of the following best describes the primary difference between ETL and ELT?

**A)** ETL transforms data before loading it into the data warehouse, while ELT loads raw data and transforms it within the warehouse.  
**B)** ETL is used for unstructured data, while ELT is used for structured data.  
**C)** ETL requires a data lake, whereas ELT requires a data warehouse.  
**D)** ETL stands for 'Extract, Transfer, Load', while ELT stands for 'Extract, Load, Transfer'.

---

## 2. File Formats

Which file format is a columnar storage format known for its excellent compression and performance benefits in analytical querying?

**A)** CSV  
**B)** JSON  
**C)** AVRO  
**D)** Parquet

---

## 3. Data Types

A dataset containing a mix of customer emails, images of receipts, and plain text reviews is best described as:

**A)** Structured Data  
**B)** Unstructured Data  
**C)** Semi-structured Data  
**D)** Relational Data

---

## 4. Big Data Characteristics

What are the '3 Vs' that are commonly used to define Big Data?

**A)** Volume, Velocity, and Variety  
**B)** Volume, Veracity, and Value  
**C)** Velocity, Virtualization, and Visualization  
**D)** Variety, Veracity, and Volatility

---

## 5. AWS S3 Storage Classes

Which AWS S3 storage class is designed for long-term archival of data that is accessed infrequently, with retrieval times of several hours?

**A)** S3 Standard  
**B)** S3 Intelligent-Tiering  
**C)** S3 Glacier Deep Archive  
**D)** S3 Standard-IA

---

## 6. AWS Glue Crawler

What is the primary function of an AWS Glue Crawler?

**A)** To execute ETL jobs written in Python or Scala.  
**B)** To query data directly in Amazon S3 using standard SQL.  
**C)** To scan data in a data store, infer the schema, and create metadata tables in the AWS Glue Data Catalog.  
**D)** To provide a visual interface for cleaning and normalizing data without writing code.

---

## 7. AWS Services Combination

A data engineer wants to run a SQL query on a CSV file stored in an S3 bucket. Which combination of AWS services would be most suitable for this task?

**A)** AWS Glue and Amazon Redshift  
**B)** Amazon S3 and AWS Lambda  
**C)** AWS Glue Data Catalog and Amazon Athena  
**D)** AWS DataBrew and Amazon S3

---

## 8. Amazon S3 Features

Which feature of Amazon S3, when enabled, keeps a complete history of all versions of an object, protecting against accidental deletions or overwrites?

**A)** S3 Lifecycle Policies  
**B)** S3 Versioning  
**C)** S3 Cross-Region Replication  
**D)** S3 Bucket Policies

---

## 9. AWS Glue DataBrew

In AWS Glue DataBrew, what is a 'recipe'?

**A)** A schedule for running data preparation jobs.  
**B)** A connection to a data source like S3 or a JDBC database.  
**C)** A set of transformation steps that can be applied to a dataset.  
**D)** The output dataset after transformations have been applied.

---

## 10. Python Sets

What is the output of the following Python code snippet?

```python
my_set = {1, 2, 3, 3, 2}
print(len(my_set))
```

**A)** 5  
**B)** 3  
**C)** 2  
**D)** An error will be raised.

---

## 11. Python Collections

Which Python collection type is defined by key-value pairs and is mutable?

**A)** List  
**B)** Tuple  
**C)** Set  
**D)** Dictionary

---

## 12. Python Functions

How would you write a Python function called `calculate_average` that accepts a list of numbers and returns their average?

**A)**

```python
def calculate_average(numbers):
    return sum(numbers) / len(numbers)
```

**B)**

```python
def calculate_average(numbers):
    return total(numbers) / count(numbers)
```

**C)**

```python
function calculate_average(numbers):
    return sum(numbers) // len(numbers)
```

**D)**

```python
def calculate_average(numbers):
    print(sum(numbers) / len(numbers))
```

---

## 13. Python Control Flow

What will be printed to the console after this Python code is executed?

```python
for i in range(1, 5):
    if i == 3:
        continue #hint: skip the loop
    print(i)
```

**A)** 1, 2, 4, 5  
**B)** 1, 2, 3, 4  
**C)** 1, 2  
**D)** 1, 2, 4

---

## 14. Git Version Control

What is the primary purpose of using a `.gitignore` file in a project?

**A)** To list all the files in the project repository.  
**B)** To specify which files and directories should be ignored by the Git version control system.  
**C)** To store environment variables and credentials securely.  
**D)** To document the project's dependencies.

---

## 15. Pandas DateTime Conversion

You have a pandas DataFrame `df` with a 'sale_date' column stored as strings ('YYYY-MM-DD'). Which function should you use to convert this column to a proper datetime data type?

**A)** `pd.to_datetime(df['sale_date'])`  
**B)** `df['sale_date'].to_date()`  
**C)** `pd.convert_datetime(df['sale_date'])`  
**D)** `df['sale_date'].astype('datetime')`

---

## 16. Pandas I/O Functions

Which pandas I/O function would you use to read a file that uses a columnar storage format, which is beneficial for large-scale analytical workloads?

**A)** `pd.read_csv()`  
**B)** `pd.read_json()`  
**C)** `pd.read_parquet()`  
**D)** `pd.read_excel()`

---

## 17. Pandas DataFrame Operations

In pandas, you have two DataFrames: `df_customers` (with columns `customer_id`, `name`) and `df_orders` (with columns `order_id`, `customer_id`, `amount`). How would you combine them to create a single DataFrame that includes all customers and their corresponding orders?

**A)** `pd.concat([df_customers, df_orders])`  
**B)** `pd.merge(df_customers, df_orders, on='customer_id', how='left')`  
**C)** `df_customers.join(df_orders)`  
**D)** `pd.merge(df_customers, df_orders, on='customer_id', how='inner')`

---

## 18. Pandas Data Filtering

How do you select all rows from a pandas DataFrame `df` where the value in the 'age' column is greater than 30?

**A)** `df[df['age'] > 30]`  
**B)** `df.query('age' < 30)`  
**C)** `df.loc['age' > 30]`  
**D)** `df.where(df['age'] > 30)`

---

## 19. SQL Aggregation Filtering

Which SQL clause is used to filter the results of a query after aggregation has been performed by a `GROUP BY` clause?

**A)** WHERE  
**B)** HAVING  
**C)** FILTER  
**D)** ORDER BY

---

## 20. Common Table Expressions

What is a Common Table Expression (CTE) in SQL?

**A)** A permanent table that is stored in the database schema.  
**B)** A temporary, named result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement.  
**C)** A special type of `JOIN` that combines rows from two or more tables.  
**D)** An alias given to a column or table in a query.

---

## 21. SQL Joins and Subqueries

Given two tables, `Employees` (EmployeeID, Name) and `Sales` (SaleID, EmployeeID, Amount), which SQL query will return the names of employees who have not made any sales?

**A)**

```sql
SELECT e.Name
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleID IS NULL;
```

**B)**

```sql
SELECT e.Name
FROM Employees e
INNER JOIN Sales s ON e.EmployeeID = s.EmployeeID;
```

**C)**

```sql
SELECT e.Name
FROM Employees e
RIGHT JOIN Sales s ON e.EmployeeID = s.EmployeeID;
```

**D)**

```sql
SELECT e.Name
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleID IS NOT NULL;
```

---

## 22. SQL Subqueries

In SQL, what is the main purpose of a subquery?

**A)** To format the output of the main query, such as changing data types.  
**B)** To create a permanent backup of a table before modification.  
**C)** To nest a query inside another query, allowing the result of the inner query to be used by the outer query.  
**D)** To combine rows from two or more tables based on a related column.

---

## 23. Snowflake Architecture

Which statement best describes Snowflake's architecture?

**A)** A tightly coupled architecture where compute and storage are combined on the same nodes.  
**B)** A two-layer architecture consisting only of a storage layer and a query processing layer.  
**C)** A multi-cluster, shared-data architecture that separates storage, compute, and cloud services into three distinct layers.  
**D)** A serverless architecture where users only manage the cloud services layer.

---

## 24. Snowflake Compute Layer

In the Snowflake architecture, what is the 'Compute Layer' composed of?

**A)** The underlying cloud storage (e.g., S3, Azure Blob Storage) where all data is stored.  
**B)** A collection of services that coordinate activities, including authentication, metadata management, and query optimization.  
**C)** User-managed relational database instances.  
**D)** One or more clusters of virtual warehouses that execute queries and perform data processing.

---

## 25. Snowflake Benefits

What is a key advantage of Snowflake's separation of storage and compute?

**A)** It ensures that all data is stored in a relational format.  
**B)** It guarantees that all queries will run in under one minute.  
**C)** It allows multiple compute clusters (virtual warehouses) to access the same data simultaneously without competing for resources.  
**D)** It reduces data storage costs by automatically compressing all data.

---

