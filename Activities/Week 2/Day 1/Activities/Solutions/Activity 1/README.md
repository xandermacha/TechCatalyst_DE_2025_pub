# Solution Guide: Log File Analysis Exercise

This document contains the step-by-step solution for the group exercise.

### Part 1: Project Setup

1. **Create Workspace:**

   ```bash
   mkdir log_analysis
   cd log_analysis
   ```

2. **Organize Folders:**

   ```bash
   mkdir raw_data processed_data reports
   ```

3. **Add Data:** Create the file `raw_data/activity_log.csv` and paste the provided content.

4. **Verify Structure:**

   ```bash
   tree
   ```

   **Expected Output:**

   ```
   .
   └── log_analysis
       ├── processed_data
       ├── raw_data
       │   └── activity_log.csv
       └── reports
   ```

### Part 2: Data Inspection & Cleaning

1. **Initial Look:**

   ```bash
   # Look at the first few lines
   head raw_data/activity_log.csv
   
   # Look at the last few lines
   tail raw_data/activity_log.csv
   ```

2. **Count Records:**

   ```bash
   wc -l raw_data/activity_log.csv
   ```

   **Expected Output:**

   ```
   17 raw_data/activity_log.csv
   ```

3. **Identify Issues:**

   - **Header Row:** Yes.
   - **Blank Lines:** Yes, one blank line.
   - **Duplicate Rows:** Yes, two pairs of duplicate rows.

4. **Create a Cleaned File (Revised Method):** We will use a two-step process to preserve the header.

   ```bash
   # Step 4a: Save the header to the new file.
   # The `>` operator creates the file and adds the header.
   head -n 1 raw_data/activity_log.csv > processed_data/cleaned_log.csv
   
   # Step 4b: Clean the body of the file and append it.
   # `tail -n +2` gets all data EXCEPT the header.
   # The `>>` operator appends the cleaned data to the file we just made.
   tail -n +2 raw_data/activity_log.csv | grep . | sort | uniq >> processed_data/cleaned_log.csv
   ```

5. **Verify Cleaning:**

   ```bash
   # Count lines in the new file. It should be 1 header + 13 data rows.
   wc -l processed_data/cleaned_log.csv
   ```

   **Expected Output:**

   ```
   14 processed_data/cleaned_log.csv
   ```

   ```bash
   # View the cleaned content to confirm the header is at the top.
   cat processed_data/cleaned_log.csv
   ```

   **Expected Output:**

   ```
   timestamp,user_id,action,product_id
   2025-07-06T10:00:00Z,user_123,view,prod_A
   2025-07-06T10:01:00Z,user_456,view,prod_B
   2025-07-06T10:02:00Z,user_123,add_to_cart,prod_A
   2025-07-06T10:03:00Z,user_789,view,prod_C
   2025-07-06T10:04:00Z,user_456,purchase,prod_B
   2025-07-06T10:05:00Z,user_123,purchase,prod_A
   2025-07-06T10:06:00Z,user_789,add_to_cart,prod_C
   2025-07-06T10:07:00Z,user_555,view,prod_D
   2025-07-06T10:08:00Z,user_123,view,prod_E
   2025-07-06T10:09:00Z,user_456,view,prod_F
   2025-07-06T10:10:00Z,user_789,purchase,prod_C
   2025-07-06T10:11:00Z,user_555,add_to_cart,prod_D
   2025-07-06T10:12:00Z,user_123,view,prod_A
   ```

### Part 3: Analysis & Reporting

1. **Report 1: Unique Users**

   ```bash
   tail -n +2 processed_data/cleaned_log.csv | cut -d',' -f2 | sort | uniq > reports/unique_users.txt
   ```

   **Expected `cat reports/unique_users.txt` Output:**

   ```
   user_123
   user_456
   user_555
   user_789
   ```

2. **Report 2: Purchase Activity**

   ```bash
   # We use `tail` here to be safe, though awk could also handle it with `NR > 1`.
   # awk -F',' 'NR > 1 && $3 == "purchase"' processed_data/cleaned_log.csv 
   tail -n +2 processed_data/cleaned_log.csv | awk -F',' '$3 == "purchase"' > reports/purchase_report.csv
   ```

   **Expected `cat reports/purchase_report.csv` Output:**

   ```
   2025-07-06T10:04:00Z,user_456,purchase,prod_B
   2025-07-06T10:05:00Z,user_123,purchase,prod_A
   2025-07-06T10:10:00Z,user_789,purchase,prod_C
   ```

3. **Challenge Report: Top 3 Most Active Users**

   ```bash
   tail -n +2 processed_data/cleaned_log.csv | cut -d',' -f2 | sort | uniq -c | sort -nr | head -n 3 > reports/top_3_users.txt
   ```

   **Expected `cat reports/top_3_users.txt` Output:**

   ```
     5 user_123
     3 user_789
     3 user_456
   ```

   *(Note: The order of `user_789` and `user_456` may vary as they have the same count.)*