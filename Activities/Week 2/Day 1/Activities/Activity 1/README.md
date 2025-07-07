# Group Exercise: Log File Analysis (45 Minutes)

**Scenario:** Your team has just received a raw server log file (`activity_log.csv`) containing user activity from your company's e-commerce website. Before this data can be loaded into a database, your task is to perform an initial investigation, clean the data, and extract some key business metrics using only command-line tools.

**Objective:** Work with your group to complete the following tasks. Use the commands you learned in today's lesson (`ls`, `mkdir`, `mv`, `cp`, `cat`, `head`, `tail`, `wc`, `cut`, `sort`, `uniq`, `awk`, `|`, `>`).

### Part 1: Project Setup 

1. **Create a Workspace:** Inside your `/content/` directory, create a new project folder called `log_analysis`.

2. **Organize Your Folders:** Inside `log_analysis`, create three subdirectories:

   - `raw_data`
   - `processed_data`
   - `reports`

3. **Add the Data:** Create the `activity_log.csv` file (your instructor will provide the content) and save it inside the `raw_data` folder.

4. **Verify:** Use the `tree` command to check that your directory structure looks like this:

   ```
   .
   └── log_analysis
       ├── processed_data
       ├── raw_data
       │   └── activity_log.csv
       └── reports
   ```

### Part 2: Data Inspection & Cleaning 

Your raw data might not be perfect. You need to investigate it and create a cleaned version.

1. **Initial Look:** Use `head`, `tail`, and `less` to look at the contents of `activity_log.csv`.
2. **Count the Records:** Use `wc -l` to count the total number of lines in the raw file.
3. **Identify Issues:** Discuss with your group:
   - Is there a header row?
   - Are there any blank lines?
   - Are there any obvious duplicate rows?
4. **Create a Cleaned File:** Create a single, piped command that does the following:
   - Reads the content of `activity_log.csv`.
   - Removes any blank lines (Hint: `grep .` can be used to find lines with at least one character).
     - `grep .`: Matches any line with at least one character, effectively removing blank lines.
   - Sorts the data to prepare for deduplication.
   - Removes any duplicate rows.
   - Saves the final, clean data to a new file named `cleaned_log.csv` inside the `processed_data` folder.
5. **Verify:** Use `wc -l` on your new `cleaned_log.csv` file. The line count should be lower than the original (`14` lines) . Use `cat` to view its contents and confirm the duplicates and blank lines are gone.

### Part 3: Analysis & Reporting 

Now that you have clean data, you can extract some useful metrics. All report files should be saved in the `reports`directory.

1. **Report 1: Unique Users**
   - **Task:** Create a list of all unique user IDs who performed an action.
   - **Output:** Save the list to a file named `unique_users.txt`.
   - **Hint:** You will need to `cut` out the `user_id` column, `sort` it, and then find the `uniq`ue entries. Don't forget to skip the header row from your cleaned file!
2. **Report 2: Purchase Activity**
   - **Task:** Extract all records from your `cleaned_log.csv` where the action was a `purchase`.
   - **Output:** Save these records to a new CSV file named `purchase_report.csv`.
   - **Hint:** `awk` is excellent for filtering rows based on a column's value. Remember from our previous activity how we used `$3` to indicate third column.
3. **Challenge Report: Top 3 Most Active Users**
   - **Task:** Find the 3 users who appear most frequently in the logs. The report should show the count of activities next to the user ID.
   - **Output:** Save the result to a file named `top_3_users.txt`.
   - **Hint:** This is a multi-step pipe!
     1. `cut` the user ID column.
     2. `sort` the user IDs.
     3. `uniq -c` to count each unique user.
     4. `sort -nr` to sort the counts in numeric, reverse (descending) order.
     5. `head` to get the top 3.

### Part 4: Final Review 

1. **Final Check:** Use `tree` one last time to view your final project structure. It should be neatly organized with raw data, processed data, and all three reports in their correct folders.
2. **Review:** Use `cat` to display the contents of each of your three report files. Do they look correct? Discuss the results with your group.