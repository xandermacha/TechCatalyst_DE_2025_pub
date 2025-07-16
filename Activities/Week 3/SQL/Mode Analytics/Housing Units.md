# SQL Housing Data Analysis Exercise

## The Great American Housing Detective Challenge 🏠

### Background Story

You've just been hired as a junior data analyst at a real estate consulting firm. Your manager has tasked you with analyzing US housing construction patterns to help clients understand regional trends and seasonal patterns. Using the `tutorial.us_housing_units` dataset, you'll need to uncover insights that could influence investment decisions.

### Dataset Overview

The dataset contains monthly housing unit construction data across four US regions:

- **south**: Southern states housing units
- **west**: Western states housing units
- **midwest**: Midwestern states housing units
- **northeast**: Northeastern states housing units

------

## Part 1: Data Exploration & Quality Check (Data Engineer Hat 👷‍♀️)

**Challenge 1.1: Data Discovery** Write queries to answer these questions:

1. How many total records are in the dataset?
2. What is the date range of our data? (earliest and latest year)
3. Are there any months with unusual names or missing data?

**Challenge 1.2: Data Quality Investigation**

1. Find any months where housing construction was exactly 0 in ALL regions
2. Identify the top 5 months with the highest total nationwide construction
3. Check if there are any duplicate year-month combinations

------

## Part 2: Regional Analysis (Analyst Hat 📊)

**Challenge 2.1: Regional Powerhouses**

1. Which region has built the most housing units overall?
2. Rank the regions by their average monthly construction
3. Find the region with the most consistent construction (hint: look for the region with values closest to its average)

**Challenge 2.2: Regional Trends**

1. For each region, find the year with the highest total construction
2. Calculate what percentage each region contributes to total US construction
3. Identify which region has grown the most over time (compare earliest vs latest available years)

------

## Part 3: Seasonal Patterns (Advanced Analysis 🔍)

**Challenge 3.1: Seasonal Detective Work**

1. Which month typically sees the highest construction activity nationwide?
2. Which month is typically the slowest for construction?
3. Are there any regions that buck the seasonal trend?

**Challenge 3.2: Summer vs Winter Construction**

1. Compare summer months (June, July, August) vs winter months (December, January, February)
2. Which region shows the biggest difference between summer and winter construction?
3. Calculate the average construction for each season by region

------

## Part 4: Business Intelligence Questions (Strategic Thinking 💡)

**Challenge 4.1: Investment Insights**

1. If you were advising a construction company, which region and month combination would you recommend for launching a new project?
2. Find years where nationwide construction was above average
3. Identify any concerning trends (years with significant drops in construction)

**Challenge 4.2: Market Opportunities**

1. Find months where one region significantly outperformed the others
2. Calculate the growth rate for each region (compare first year to last year in dataset)
3. Which region shows the most potential for future investment based on recent trends?

------

## Bonus Challenges 🏆

**Bonus 1: Pattern Recognition** Find any interesting patterns in the data that weren't covered above. Write a query and explain what story the data tells.

**Bonus 2: Data Storytelling** Pick one insight from your analysis and write a brief explanation of what it means for the housing market.

**Bonus 3: Query Optimization** Take one of your more complex queries and see if you can rewrite it to be more efficient or readable.

------

## Technical Requirements

### Submission Guidelines:

1. Write clean, well-commented SQL queries
2. Include the business question you're answering above each query
3. Provide a brief interpretation of your results
4. Use meaningful column aliases
5. Format your queries for readability

### Sample Query Format:

```sql
-- Business Question: What region has the highest average construction?
-- Analysis: This helps identify the most active construction markets

SELECT 
    'South' as region_name,
    AVG(south) as avg_construction
FROM tutorial.us_housing_units
WHERE south IS NOT NULL
UNION ALL
SELECT 
    'West' as region_name,
    AVG(west) as avg_construction
FROM tutorial.us_housing_units
WHERE west IS NOT NULL
-- Continue for other regions...
ORDER BY avg_construction DESC;
```

------

