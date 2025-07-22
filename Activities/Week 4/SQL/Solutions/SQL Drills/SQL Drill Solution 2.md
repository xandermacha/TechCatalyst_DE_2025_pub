# SQL Drill 2 Solution



**1. Suppliers Without Small Parts (Subquery)** This query finds suppliers who do not appear in the subquery's list of suppliers who *do* supply small parts.

```SQL
SELECT
    s_name
FROM
    snowflake_sample_data.tpch_sf1.supplier
WHERE
    s_suppkey NOT IN (
        SELECT
            ps.ps_suppkey
        FROM
            snowflake_sample_data.tpch_sf1.partsupp ps
        JOIN
            snowflake_sample_data.tpch_sf1.part p ON ps.ps_partkey = p.p_partkey
        WHERE
            p.p_size < 5
    );
```

------

**2. Order Performance by Clerk (GROUP BY & HAVING)** This query aggregates sales by clerk and then uses `HAVING`to filter for the high-performing clerks.

```SQL
SELECT
    o_clerk,
    SUM(o_totalprice) AS total_revenue
FROM
    snowflake_sample_data.tpch_sf1.orders
GROUP BY
    o_clerk
HAVING
    SUM(o_totalprice) > 10000000
ORDER BY
    total_revenue DESC;
```

------

**3. Regional Supplier Count (JOIN & COUNT DISTINCT)** This requires joining through the `NATION` table to link `REGION` and `SUPPLIER` and using `COUNT(DISTINCT ...)` to avoid counting suppliers who operate in multiple nations within the same region more than once.

```SQL
SELECT
    r.r_name AS region_name,
    COUNT(DISTINCT s.s_suppkey) AS number_of_suppliers
FROM
    snowflake_sample_data.tpch_sf1.region r
JOIN
    snowflake_sample_data.tpch_sf1.nation n ON r.r_regionkey = n.n_regionkey
JOIN
    snowflake_sample_data.tpch_sf1.supplier s ON n.n_nationkey = s.s_nationkey
GROUP BY
    r.r_name
ORDER BY
    number_of_suppliers DESC;
```

------

**4. Orders Above Average Size (CTE)** A CTE is used to first calculate the number of items for each order. The main query then filters this list by comparing each order's item count to the overall average (calculated in a subquery).

```SQL
WITH OrderLineCounts AS (
    SELECT
        l_orderkey,
        COUNT(*) as item_count
    FROM
        snowflake_sample_data.tpch_sf1.lineitem
    GROUP BY
        l_orderkey
)
SELECT
    l_orderkey,
    item_count
FROM
    OrderLineCounts
WHERE
    item_count > (SELECT AVG(item_count) FROM OrderLineCounts)
ORDER BY
    item_count DESC;
```

------

**5. Customer's Last Order Date (Scalar Subquery)** A correlated subquery is used in the `SELECT` list. For each customer row being processed by the outer query, the inner query runs to find the `MAX` order date specifically for that customer.

```SQL
SELECT
    c.c_name,
    (
        SELECT MAX(o.o_orderdate)
        FROM snowflake_sample_data.tpch_sf1.orders o
        WHERE o.o_custkey = c.c_custkey
    ) AS last_order_date
FROM
    snowflake_sample_data.tpch_sf1.customer c
ORDER BY
    c.c_name;
```

------

**6. Parts Shipped by 'DELIVER IN PERSON' (JOIN & LIKE)** This query joins `PART` and `LINEITEM` and uses `SELECT DISTINCT` to ensure each part name is listed only once.

```SQL
SELECT DISTINCT
    p.p_name
FROM
    snowflake_sample_data.tpch_sf1.part p
JOIN
    snowflake_sample_data.tpch_sf1.lineitem l ON p.p_partkey = l.l_partkey
WHERE
    l.l_shipinstruct = 'DELIVER IN PERSON';
```

------

**7. Top Spending Customers in Germany (Comprehensive)** This query joins three tables, filters by nation, aggregates the total price for each customer, and then uses `ORDER BY` and `LIMIT` to find the top 5.

```SQL
SELECT
    c.c_name,
    SUM(o.o_totalprice) as total_spending
FROM
    snowflake_sample_data.tpch_sf1.customer c
JOIN
    snowflake_sample_data.tpch_sf1.orders o ON c.c_custkey = o.o_custkey
JOIN
    snowflake_sample_data.tpch_sf1.nation n ON c.c_nationkey = n.n_nationkey
WHERE
    n.n_name = 'GERMANY'
GROUP BY
    c.c_name
ORDER BY
    total_spending DESC
LIMIT 5;
```

------

**8. Profitability Analysis (GROUP BY with Expression)** This solution calculates the profit directly in the `SUM()` function and then uses the alias `total_profit` in the `HAVING` clause for filtering.

```SQL
SELECT
    p.p_brand,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_profit
FROM
    snowflake_sample_data.tpch_sf1.part p
JOIN
    snowflake_sample_data.tpch_sf1.lineitem l ON p.p_partkey = l.l_partkey
GROUP BY
    p.p_brand
HAVING
    total_profit > 5000000
ORDER BY
    total_profit DESC;
```

------

**9. Self-Join for Same-Day Orders ** This query joins the `ORDERS` table to itself on customer key and order date. The condition `a.o_orderkey < b.o_orderkey` is a clever trick to prevent an order from being paired with itself and to ensure each pair (e.g., 101, 105) appears only once.

```SQL
SELECT
    a.o_custkey,
    a.o_orderkey AS order_1,
    b.o_orderkey AS order_2,
    a.o_orderdate
FROM
    snowflake_sample_data.tpch_sf1.orders a
JOIN
    snowflake_sample_data.tpch_sf1.orders b ON a.o_custkey = b.o_custkey AND a.o_orderdate = b.o_orderdate
WHERE
    a.o_orderkey < b.o_orderkey;
```

------

**10. Delayed Shipments (JOIN & Date Functions)** This query uses the `DATEDIFF` function to find the number of days between the order date and ship date, filtering for rows where the difference is greater than 30.

```SQL
SELECT
    l.l_orderkey,
    o.o_orderdate,
    l.l_shipdate,
    DATEDIFF('day', o.o_orderdate, l.l_shipdate) as days_delayed
FROM
    snowflake_sample_data.tpch_sf1.lineitem l
JOIN
    snowflake_sample_data.tpch_sf1.orders o ON l.l_orderkey = o.o_orderkey
WHERE
    DATEDIFF('day', o.o_orderdate, l.l_shipdate) > 30
ORDER BY
    days_delayed DESC;
```