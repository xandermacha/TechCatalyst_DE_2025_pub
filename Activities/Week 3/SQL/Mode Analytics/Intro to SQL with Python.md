# SQL and Pandas Exercise: Apple Stock Analysis

## Mode Analytics

## Dataset Overview

You'll be working with `tutorial.aapl_historical_stock_price` which contains Apple's historical stock data from 2000-2014 with the following columns:

- `date`: Trading date
- `year`: Year of trading (2000-2014)
- `month`: Month of trading
- `open`: Opening price
- `high`: Highest price of the day
- `low`: Lowest price of the day
- `close`: Closing price
- `volume`: Number of shares traded
- `id`: Unique identifier

**Note**: The dataset contains approximately 250-260 trading days per year, with 2014 having only partial data (20 records).

------

## Part 1: SQL Queries

### Exercise 1.1: Basic SELECT

Write a query to select all columns from the first 10 rows of the dataset.

**Your Query:**

```sql
-- Write your query here
```

### Exercise 1.2: Specific Column Selection

Select only the `date`, `open`, `high`, `low`, and `close` columns for the first 20 rows.

**Your Query:**

```sql
-- Write your query here
```

### Exercise 1.3: WHERE Clause Practice

Write queries for the following conditions:

a) Find all records where the closing price was above $30



```sql
-- Write your query here
```

b) Find all records from the year 2008 (financial crisis year)



```sql
-- Write your query here
```

c) Find all records where the volume traded was greater than 100,000,000 shares



```sql
-- Write your query here
```

### Exercise 1.4: Basic Aggregations

Write queries to calculate:

a) The average closing price across all records



```sql
-- Write your query here
```

b) The total volume of shares traded

l

```sql
-- Write your query here
```

c) The count of trading days in the dataset



```sql
-- Write your query here
```

d) The highest and lowest closing prices



```sql
-- Write your query here
```

### Exercise 1.5: GROUP BY Aggregations

Write queries for:

a) Average closing price by year



```sql
-- Write your query here
```

b) Total volume traded by month (across all years)



```sql
-- Write your query here
```

c) Count of trading days by year



```sql
-- Write your query here
```

d) Highest closing price by year



```sql
-- Write your query here
```

### Exercise 1.6: Challenge Query

Find the year with the most trading days and the year with the fewest trading days (excluding 2014 which appears incomplete).

**Your Query:**



```sql
-- Write your query here
```

------

## Part 2: Python/Pandas Analysis

Now switch to the Python notebook in Mode. Your SQL queries are available as `datasets[0]`, `datasets[1]`, etc.

Make sure you create a Query that exposes the entire dataset to use for this Python activity. 

### Exercise 2.1: Data Preparation



```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load your first query (all data)
df = datasets[0]  # Adjust index based on your query order

# Display basic info about the dataset
print("Dataset Info:")
print(df.info())
print("\nFirst 5 rows:")
print(df.head())
```

### Exercise 2.2: Data Cleaning and Indexing



```python
# Convert date column to datetime
df['date'] = pd.to_datetime(df['date'])

# Set date as index
df_indexed = df.set_index('date')

# Display the result
print("DataFrame with date index:")
print(df_indexed.head())
```

### Exercise 2.3: Basic Pandas Analysis

Write code to:

a) Calculate daily price change (close - open)



```python
# Your code here
```

b) Calculate daily price range (high - low)



```python
# Your code here
```

c) Find the top 10 days with highest volume

```python
# Your code here
```

### Exercise 2.4: Filtering and Conditional Analysis



```python
# Filter data for 2008 only (financial crisis year)
df_2008 = # Your code here

# Find days where closing price was higher than opening price
bullish_days = # Your code here

# Calculate percentage of bullish days
bullish_percentage = # Your code here

print(f"Percentage of bullish days: {bullish_percentage:.2f}%")
```

### Exercise 2.5: Grouping and Aggregation



```python
# Group by year and calculate statistics
yearly_stats = # Your code here - calculate mean, min, max for close price by year

# Group by month (across all years) and find average volume
monthly_volume = # Your code here

print("Yearly Statistics:")
print(yearly_stats)
print("\nAverage Volume by Month:")
print(monthly_volume)
```

### Exercise 2.6: Advanced Analysis



```python
# Calculate rolling 30-day average of closing price
df_indexed['close_30ma'] = # Your code here

# Calculate volatility (30-day rolling standard deviation)
df_indexed['volatility'] = # Your code here

# Find the most volatile month
most_volatile_month = # Your code here

print(f"Most volatile month: {most_volatile_month}")
```

### Exercise 2.7: Data Visualization



```python
# Create a plot showing closing price over time
plt.figure(figsize=(12, 6))
# Your plotting code here
plt.title('Apple Stock Price Over Time')
plt.xlabel('Date')
plt.ylabel('Price ($)')
plt.show()

# Create a histogram of daily volume
plt.figure(figsize=(10, 6))
# Your plotting code here
plt.title('Distribution of Daily Trading Volume')
plt.xlabel('Volume')
plt.ylabel('Frequency')
plt.show()
```

### Exercise 2.8: Challenge Analysis

Perform the following advanced analysis:



```python
# Calculate the correlation between volume and price change
price_change = df_indexed['close'] - df_indexed['open']
volume_price_corr = # Your code here

# Find the best and worst performing months (by average return)
df_indexed['daily_return'] = # Calculate daily return percentage
monthly_returns = # Group by month and calculate average return

print(f"Volume-Price Change Correlation: {volume_price_corr:.4f}")
print("\nBest performing months:")
print(monthly_returns.nlargest(3))
print("\nWorst performing months:")
print(monthly_returns.nsmallest(3))
```

------



