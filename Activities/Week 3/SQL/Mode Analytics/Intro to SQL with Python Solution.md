# SQL and Pandas Exercise: Apple Stock Analysis

# SQL and Pandas Exercise Solutions

## Part 1: SQL Query Solutions

### Exercise 1.1: Basic SELECT

```sql
SELECT * 
FROM tutorial.aapl_historical_stock_price 
LIMIT 10;
```

### Exercise 1.2: Specific Column Selection

```sql
SELECT date, open, high, low, close
FROM tutorial.aapl_historical_stock_price 
LIMIT 20;
```

### Exercise 1.3: WHERE Clause Practice

**a) Find all records where the closing price was above $30**

```sql
SELECT *
FROM tutorial.aapl_historical_stock_price
WHERE close > 30;
```

**b) Find all records from the year 2008 (financial crisis year)**

```sql
SELECT *
FROM tutorial.aapl_historical_stock_price
WHERE year = 2008;
```

**c) Find all records where the volume traded was greater than 100,000,000 shares**

```sql
SELECT *
FROM tutorial.aapl_historical_stock_price
WHERE volume > 100000000;
```

### Exercise 1.4: Basic Aggregations

**a) The average closing price across all records**

```sql
SELECT AVG(close) AS average_closing_price
FROM tutorial.aapl_historical_stock_price;
```

**b) The total volume of shares traded**

```sql
SELECT SUM(volume) AS total_volume
FROM tutorial.aapl_historical_stock_price;
```

**c) The count of trading days in the dataset**

```sql
SELECT COUNT(*) AS trading_days
FROM tutorial.aapl_historical_stock_price;
```

**d) The highest and lowest closing prices**

```sql
SELECT MAX(close) AS highest_close, MIN(close) AS lowest_close
FROM tutorial.aapl_historical_stock_price;
```

### Exercise 1.5: GROUP BY Aggregations

**a) Average closing price by year**

```sql
SELECT year, AVG(close) AS avg_closing_price
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year;
```

**b) Total volume traded by month (across all years)**

```sql
SELECT month, SUM(volume) AS total_volume
FROM tutorial.aapl_historical_stock_price
GROUP BY month
ORDER BY month;
```

**c) Count of trading days by year**

```sql
SELECT year, COUNT(*) AS trading_days
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year;
```

**d) Highest closing price by year**

```sql
SELECT year, MAX(close) AS highest_close
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year;
```

### Exercise 1.6: Challenge Query

```sql
SELECT year, COUNT(*) AS trading_days
FROM tutorial.aapl_historical_stock_price
WHERE year != 2014  -- Exclude incomplete 2014 data
GROUP BY year
ORDER BY COUNT(*) DESC;
```

------

## Part 2: Python/Pandas Solutions

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

**a) Calculate daily price change (close - open)**

```python
df_indexed['price_change'] = df_indexed['close'] - df_indexed['open']
print("Daily price change added:")
print(df_indexed[['open', 'close', 'price_change']].head())
```

**b) Calculate daily price range (high - low)**

```python
df_indexed['price_range'] = df_indexed['high'] - df_indexed['low']
print("Daily price range added:")
print(df_indexed[['high', 'low', 'price_range']].head())
```

**c) Find the top 10 days with highest volume**

```python
top_volume_days = df_indexed.nlargest(10, 'volume')[['volume', 'close']]
print("Top 10 highest volume days:")
print(top_volume_days)
```

### Exercise 2.4: Filtering and Conditional Analysis

```python
# Filter data for 2008 only (financial crisis year)
df_2008 = df_indexed[df_indexed['year'] == 2008]

# Find days where closing price was higher than opening price
bullish_days = df_indexed[df_indexed['close'] > df_indexed['open']]

# Calculate percentage of bullish days
bullish_percentage = (len(bullish_days) / len(df_indexed)) * 100

print(f"Percentage of bullish days: {bullish_percentage:.2f}%")
print(f"Total bullish days: {len(bullish_days)}")
print(f"Total trading days: {len(df_indexed)}")
```

### Exercise 2.5: Grouping and Aggregation

```python
# Group by year and calculate statistics
yearly_stats = df_indexed.groupby('year')['close'].agg(['mean', 'min', 'max']).round(2)

# Group by month (across all years) and find average volume
monthly_volume = df_indexed.groupby('month')['volume'].mean()

print("Yearly Statistics:")
print(yearly_stats)
print("\nAverage Volume by Month:")
print(monthly_volume)
```

### Exercise 2.6: Advanced Analysis

```python
# Calculate rolling 30-day average of closing price
df_indexed['close_30ma'] = df_indexed['close'].rolling(window=30).mean()

# Calculate volatility (30-day rolling standard deviation)
df_indexed['volatility'] = df_indexed['close'].rolling(window=30).std()

# Find the most volatile month
monthly_volatility = df_indexed.groupby('month')['volatility'].mean()
most_volatile_month = monthly_volatility.idxmax()

print(f"Most volatile month: {most_volatile_month}")
print("Average volatility by month:")
print(monthly_volatility.round(2))
```

### Exercise 2.7: Data Visualization

```python
# Create a plot showing closing price over time
plt.figure(figsize=(12, 6))
plt.plot(df_indexed.index, df_indexed['close'], linewidth=1)
plt.title('Apple Stock Price Over Time (2000-2014)')
plt.xlabel('Date')
plt.ylabel('Price ($)')
plt.grid(True, alpha=0.3)
plt.show()

# Create a histogram of daily volume
plt.figure(figsize=(10, 6))
plt.hist(df_indexed['volume'], bins=50, alpha=0.7, color='skyblue')
plt.title('Distribution of Daily Trading Volume')
plt.xlabel('Volume')
plt.ylabel('Frequency')
plt.grid(True, alpha=0.3)
plt.show()
```

### Exercise 2.8: Challenge Analysis

```python
# Calculate the correlation between volume and price change
price_change = df_indexed['close'] - df_indexed['open']
volume_price_corr = df_indexed['volume'].corr(price_change)

# Find the best and worst performing months (by average return)
df_indexed['daily_return'] = ((df_indexed['close'] - df_indexed['open']) / df_indexed['open']) * 100
monthly_returns = df_indexed.groupby('month')['daily_return'].mean()

print(f"Volume-Price Change Correlation: {volume_price_corr:.4f}")
print("\nBest performing months:")
print(monthly_returns.nlargest(3))
print("\nWorst performing months:")
print(monthly_returns.nsmallest(3))
```

### Bonus Challenge Solution

```python
def identify_buy_signals(df):
    """
    Identify potential buy signals based on technical indicators
    """
    # Calculate 30-day moving average
    df['ma_30'] = df['close'].rolling(window=30).mean()
    
    # Calculate average volume
    avg_volume = df['volume'].mean()
    
    # Calculate previous day change
    df['prev_day_change'] = df['close'].shift(1) - df['open'].shift(1)
    
    # Identify buy signals
    buy_signals = df[
        (df['close'] < df['ma_30']) &  # Price below MA
        (df['volume'] > avg_volume) &  # Volume above average
        (df['prev_day_change'] < 0)    # Previous day was decline
    ]
    
    return buy_signals[['close', 'volume', 'ma_30', 'prev_day_change']]

# Apply the function
buy_signals = identify_buy_signals(df_indexed)
print(f"Number of buy signals identified: {len(buy_signals)}")
print("\nFirst 5 buy signals:")
print(buy_signals.head())
```
