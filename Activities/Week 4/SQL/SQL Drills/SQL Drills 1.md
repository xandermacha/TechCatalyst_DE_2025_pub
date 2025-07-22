# SQL Drill #1

#### **1. Basic Customer Information**

Retrieve the customer names (`c_name`) and their addresses (`c_address`) from the `CUSTOMER` table for customers who are from the nation with `n_nationkey` equal to 3. Order the results by customer name in ascending order.

#### **2. Suppliers in Specific Regions**

From the `SUPPLIER` table, list supplier names (`s_name`) and their account balances (`s_acctbal`) for suppliers whose account balance is greater than 5000. Order the results by account balance in descending order.

#### **3. Part Market Segments**

From the `PART` table, display the part name (`p_name`) and a calculated column named `market_segment`. This new column should contain the value 'SMALL' if the part's `p_size` is less than or equal to 20, and 'LARGE' otherwise. Order the result by part name.

#### **4. Order Count by Year**

Count the number of orders made each year. Display the year and the count of orders.

#### **5. Average Order Prices**

Show the customer name and order price for **every order** that contained the part with `p_partkey = 5`. It is expected to see the same customer multiple times if they placed multiple qualifying orders

#### **6. Customer and Nation Information**

Join the `CUSTOMER` table with the `NATION` table to retrieve the customer names (`c_name`) and their corresponding nation names (`n_name`).

#### **7. Supplier and Part Connection**

Identify parts (`p_name` from the `PART` table) supplied by suppliers (`s_name` from the `SUPPLIER` table) in the 'EUROPE' region.

#### **8. Customer Orders and Line Items**

List customers (`c_name`) who have ordered a part with `p_partkey` equal to 5. Include details about the order's total price (`o_totalprice`).

#### **9. Monthly Sales Analysis (Using CTE)**

Monthly Sales Analysis (Using CTE): Using a CTE, calculate the total sales revenue for **each calendar month** in the dataset. Display each month (e.g., `1995-01-01`) and its corresponding total sales, ordered chronologically.

#### **10. Top Supplier Overview (Using CTE)**

Using a CTE, identify the top 5 suppliers based on the total **revenue generated from parts they sold** (as recorded in the `LINEITEM` table). Display the supplier's name and their total calculated revenue, ordered from highest to lowest.