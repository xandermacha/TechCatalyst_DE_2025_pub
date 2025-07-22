# Challenge 3.5.1

All of the exercises add window functions to the following query:

```sql
USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCH_SF1;

select year(o_orderdate) as order_year,
        count(*) as num_orders, sum(o_totalprice) as tot_sales
       from orders
       group by order_year;
```

![image-20250721145013380](images/image-20250721145013380.png)

## Exercise 14-1

Add `grand_total_sales` as shown below

![image-20250721145116639](images/image-20250721145116639.png)

## Exercise 14-2

Add `records_per_year` as shown below:

![image-20250721145154207](images/image-20250721145154207.png)

## Exercise 14-3

Add `avg_per_year` as shown below:

![image-20250721145223970](images/image-20250721145223970.png)

## Exercise 14-4

Get the top 3 months for each year in terms of Total Sales

**CHALLENGING**

* Hint: consider using CTEs
* Hint: consider using RANK()

![image-20250721145354367](images/image-20250721145354367.png)

