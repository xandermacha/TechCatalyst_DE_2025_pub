### Activity: Researching Different Types of Tables and Views in Snowflake

**Objective**: Understand the various types of tables and views offered by Snowflake, including their differences, usage, and syntax.

### Task Overview:

1. **Research the Different Types of Tables in Snowflake**:
   - Temporary Tables
   - Transient Tables
   - Standard (Permanent) Tables
   - External Tables
2. **Research the Different Types of Views in Snowflake**:
   - Standard Views
   - Materialized Views
   - Secure Views
3. **Document Your Findings**:
   - Definition and purpose of each type.
   - Key differences between them.
   - Common use cases.
   - Syntax for creating and using each type.

### Instructions:

1. **Research**:
   - Use the official Snowflake documentation as your primary source.
   - Look for additional resources that explain the concepts.
2. **Document Your Findings**:
   - Create a table in a document summarizing your findings.
   - Include examples and syntax for creating each type of table and view.

You can use the following table for each type you are researching.

| Field           | Description |
| --------------- | ----------- |
| Definition      |  Hiding sensitive data from view        |
| Purpose         |  limits access to sensitive data that should not be exposed to all users of underlying table          |
| Key Difference  |  Executes slower than non-secure view           |
| Common Use Case |  simplify queries for which users do not need to understand the underlying data representation           |
| Syntax Example  |             |

```sql 
   CREATE VIEW doctor_view AS SELECT patient_ID, patient_name diagnosis, treatment FROM hospital_table; 
```
1. **Share Your Findings**:

   - Be prepared to present your findings

---

## Views

### **Standard Views**

| Field           | Description |
| --------------- | ----------- |
| Definition      |  A named definition of a query           |
| Purpose         |  Allows accessing queryies as a table           |
| Key Difference  |  results are not stored           |
| Common Use Case |  For having the same data display views for different needs           |
| Syntax Example  |             |

```sql 
   CREATE VIEW doctor_view AS SELECT patient_ID, patient_name diagnosis, treatment FROM hospital_table; 
```
### **Materialized Views**

| Field           | Description |
| --------------- | ----------- |
| Definition      |  The materialized views results are stored          |
| Purpose         |  More like an actual table so data can be accessed quicker          |
| Key Difference  |  requires storage space and maintenance           |
| Common Use Case |  When query results contain small amount of rows and columns or when results require processing           |
| Syntax Example  |             |
```sql
  CREATE MATERIALIZED doctor_view AS
  SELECT patient_ID, patient_name, diagnosis, treatment FROM hospital_table;
```

### **Secured Views**

| Field           | Description |
| --------------- | ----------- |
| Definition      |  Hiding sensitive data from view        |
| Purpose         |  limits access to sensitive data that should not be exposed to all users of underlying table          |
| Key Difference  |  Executes slower than non-secure view           |
| Common Use Case |  simplify queries for which users do not need to understand the underlying data representation           |
| Syntax Example  |             |
```sql
  CREATE SECURE VIEW doctor_view AS
  SELECT patient_ID, patient_name, diagnosis, treatment FROM hospital_table;
```