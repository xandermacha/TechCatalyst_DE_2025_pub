# SQL Housing Exercise - Solution Key

## Part 1: Data Exploration & Quality Check

### Challenge 1.1: Data Discovery
```sql
-- 1. Total records in dataset
SELECT COUNT(*) as total_records FROM tutorial.us_housing_units;

-- 2. Date range of data
SELECT MIN(year) as earliest_year, MAX(year) as latest_year FROM tutorial.us_housing_units;

-- 3. Check for unusual month names
SELECT DISTINCT month_name FROM tutorial.us_housing_units ORDER BY month_name;
```

### Challenge 1.2: Data Quality Investigation
```sql
-- 1. Months with 0 construction in ALL regions
SELECT year, month, month_name FROM tutorial.us_housing_units 
WHERE south = 0 AND west = 0 AND midwest = 0 AND northeast = 0;

-- 2. Top 5 months with highest total construction
SELECT year, month_name, (south + west + midwest + northeast) as total_construction
FROM tutorial.us_housing_units 
ORDER BY total_construction DESC LIMIT 5;

-- 3. Check for duplicate year-month combinations
SELECT year, month, COUNT(*) as duplicate_count FROM tutorial.us_housing_units
GROUP BY year, month HAVING COUNT(*) > 1;
```

## Part 2: Regional Analysis

### Challenge 2.1: Regional Powerhouses
```sql
-- 1. Region with most housing units overall
SELECT 
    SUM(south) as south_total,
    SUM(west) as west_total,
    SUM(midwest) as midwest_total,
    SUM(northeast) as northeast_total
FROM tutorial.us_housing_units;

-- 2. Rank regions by average monthly construction
SELECT 
    'South' as region, AVG(south) as avg_construction FROM tutorial.us_housing_units
UNION ALL
SELECT 'West' as region, AVG(west) as avg_construction FROM tutorial.us_housing_units
UNION ALL
SELECT 'Midwest' as region, AVG(midwest) as avg_construction FROM tutorial.us_housing_units
UNION ALL
SELECT 'Northeast' as region, AVG(northeast) as avg_construction FROM tutorial.us_housing_units
ORDER BY avg_construction DESC;
```

### Challenge 2.2: Regional Trends
```sql
-- 1. Year with highest total construction by region
SELECT year, SUM(south) as south_yearly FROM tutorial.us_housing_units
GROUP BY year ORDER BY south_yearly DESC LIMIT 1;
-- (Repeat for other regions)

-- 2. Percentage contribution by region
SELECT 
    (SUM(south) / SUM(south + west + midwest + northeast)) * 100 as south_percentage,
    (SUM(west) / SUM(south + west + midwest + northeast)) * 100 as west_percentage,
    (SUM(midwest) / SUM(south + west + midwest + northeast)) * 100 as midwest_percentage,
    (SUM(northeast) / SUM(south + west + midwest + northeast)) * 100 as northeast_percentage
FROM tutorial.us_housing_units;
```

## Part 3: Seasonal Patterns

### Challenge 3.1: Seasonal Detective Work
```sql
-- 1. Month with highest construction nationwide
SELECT month_name, AVG(south + west + midwest + northeast) as avg_total
FROM tutorial.us_housing_units
GROUP BY month_name, month
ORDER BY avg_total DESC LIMIT 1;

-- 2. Slowest month for construction
SELECT month_name, AVG(south + west + midwest + northeast) as avg_total
FROM tutorial.us_housing_units
GROUP BY month_name, month
ORDER BY avg_total ASC LIMIT 1;

-- 3. Regional seasonal patterns
SELECT month_name, AVG(south) as avg_south, AVG(west) as avg_west, 
       AVG(midwest) as avg_midwest, AVG(northeast) as avg_northeast
FROM tutorial.us_housing_units
GROUP BY month_name, month
ORDER BY month;
```

### Challenge 3.2: Summer vs Winter Construction
```sql
-- 1. Summer vs Winter comparison
SELECT 
    'Summer' as season,
    AVG(south + west + midwest + northeast) as avg_construction
FROM tutorial.us_housing_units
WHERE month_name IN ('June', 'July', 'August')
UNION ALL
SELECT 
    'Winter' as season,
    AVG(south + west + midwest + northeast) as avg_construction
FROM tutorial.us_housing_units
WHERE month_name IN ('December', 'January', 'February');

-- 2. Regional summer vs winter differences
SELECT 
    'South' as region,
    AVG(CASE WHEN month_name IN ('June', 'July', 'August') THEN south END) as summer_avg,
    AVG(CASE WHEN month_name IN ('December', 'January', 'February') THEN south END) as winter_avg
FROM tutorial.us_housing_units;
-- (Repeat for other regions)
```

## Part 4: Business Intelligence Questions

### Challenge 4.1: Investment Insights
```sql
-- 1. Best region-month combination for new projects
SELECT month_name, 
       GREATEST(south, west, midwest, northeast) as highest_construction,
       CASE 
           WHEN south = GREATEST(south, west, midwest, northeast) THEN 'South'
           WHEN west = GREATEST(south, west, midwest, northeast) THEN 'West'
           WHEN midwest = GREATEST(south, west, midwest, northeast) THEN 'Midwest'
           ELSE 'Northeast'
       END as best_region
FROM tutorial.us_housing_units
ORDER BY highest_construction DESC LIMIT 5;

-- 2. Years with above-average construction
SELECT year, AVG(south + west + midwest + northeast) as yearly_avg
FROM tutorial.us_housing_units
GROUP BY year
HAVING AVG(south + west + midwest + northeast) > 
    (SELECT AVG(south + west + midwest + northeast) FROM tutorial.us_housing_units);

-- 3. Years with significant drops
SELECT year, AVG(south + west + midwest + northeast) as yearly_avg
FROM tutorial.us_housing_units
GROUP BY year
ORDER BY yearly_avg ASC LIMIT 5;
```

### Challenge 4.2: Market Opportunities
```sql
-- 1. Months where one region significantly outperformed
SELECT year, month_name, south, west, midwest, northeast
FROM tutorial.us_housing_units
WHERE south > (west + midwest + northeast) 
   OR west > (south + midwest + northeast)
   OR midwest > (south + west + northeast)
   OR northeast > (south + west + midwest)
ORDER BY year, month;

-- 2. Growth rate by region (first year vs last year)
SELECT 
    (SELECT AVG(south) FROM tutorial.us_housing_units WHERE year = (SELECT MAX(year) FROM tutorial.us_housing_units)) -
    (SELECT AVG(south) FROM tutorial.us_housing_units WHERE year = (SELECT MIN(year) FROM tutorial.us_housing_units)) as south_growth;
-- (Repeat for other regions)
```

## Key Insights Students Should Discover:
- **Seasonal patterns**: Construction typically peaks in spring/summer months
- **Regional dominance**: South typically leads in construction volume
- **Economic cycles**: Clear patterns of booms and busts in housing construction
- **Data quality**: Some months may have missing or zero values that need investigation

## Extension Questions for Advanced Students:
- Calculate year-over-year growth rates
- Identify outliers in the data
- Create rolling averages for trend analysis
- Analyze variance and standard deviation by region

