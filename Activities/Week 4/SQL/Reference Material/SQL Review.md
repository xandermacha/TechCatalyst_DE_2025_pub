## High-Value, Long-Term Customers 📈

**Use-Case:** The marketing team wants to create a loyalty program for its top American customers who have spent over $100,000 in total and have orders spanning at least three different years.

**Concepts Refreshed:** `JOIN`, `GROUP BY`, `HAVING`

```sql
SELECT
    c.c_name AS customer_name,
    SUM(o.o_totalprice) AS total_spent,
    COUNT(DISTINCT YEAR(o.o_orderdate)) AS num_years_active
FROM
    snowflake_sample_data.tpch_sf1.customer c
JOIN
    snowflake_sample_data.tpch_sf1.orders o ON c.c_custkey = o.o_custkey
JOIN
    snowflake_sample_data.tpch_sf1.nation n ON c.c_nationkey = n.n_nationkey
WHERE
    n.n_name = 'UNITED STATES' -- Filter for customers in a specific nation
GROUP BY
    c.c_name
HAVING
    SUM(o.o_totalprice) > 100000 -- Filter for customers spending over $100k
    AND COUNT(DISTINCT YEAR(o.o_orderdate)) >= 3 -- Filter for customers active at least 3 years
ORDER BY
    total_spent DESC;
```

## Regional Sales Performance Analysis 🌍

This query uses a Common Table Expression (CTE) to first aggregate sales data by nation and then joins it to the region table. This helps visualize how much revenue each global region generates, which is crucial for strategic planning and resource allocation.

**Use-Case:** A sales director wants to compare the total sales revenue from each business region (e.g., AMERICA, EUROPE, ASIA) to evaluate market performance.

**Concepts Refreshed:** `CTE`, `JOIN` (multiple), `GROUP BY`

```sql
WITH NationSales AS (
    -- First, calculate total sales for each nation
    SELECT
        c.c_nationkey,
        SUM(o.o_totalprice) AS total_nation_sales
    FROM
        snowflake_sample_data.tpch_sf1.orders o
    JOIN
        snowflake_sample_data.tpch_sf1.customer c ON o.o_custkey = c.c_custkey
    GROUP BY
        c.c_nationkey
)
-- Now, join the aggregated nation sales to the region table
SELECT
    r.r_name AS region_name,
    SUM(ns.total_nation_sales) AS total_region_revenue
FROM
    snowflake_sample_data.tpch_sf1.region r
JOIN
    snowflake_sample_data.tpch_sf1.nation n ON r.r_regionkey = n.n_regionkey
JOIN
    NationSales ns ON n.n_nationkey = ns.c_nationkey
GROUP BY
    r.r_name
ORDER BY
    total_region_revenue DESC;
```

## 3. Parts Without Recent Orders 📦

This query finds all parts that were **not** included in any order placed in the most recent full year of the dataset (1998). This is useful for inventory management to identify potentially obsolete or slow-moving items.

**Use-Case:** The inventory team needs a list of parts that weren't sold at all in 1998 to decide whether to discontinue them or put them on clearance.

**Concepts Refreshed:** `Subquery` in a `WHERE` clause (`NOT IN`)

```sql
SELECT
    p_partkey,
    p_name,
    p_brand,
    p_type
FROM
    snowflake_sample_data.tpch_sf1.part
WHERE
    p_partkey NOT IN (
        -- Subquery: Get all part keys that WERE sold in 1998
        SELECT DISTINCT
            l.l_partkey
        FROM
            snowflake_sample_data.tpch_sf1.lineitem l
        JOIN
            snowflake_sample_data.tpch_sf1.orders o ON l.l_orderkey = o.o_orderkey
        WHERE
            YEAR(o.o_orderdate) = 1998
    )
ORDER BY
    p_partkey;
```

