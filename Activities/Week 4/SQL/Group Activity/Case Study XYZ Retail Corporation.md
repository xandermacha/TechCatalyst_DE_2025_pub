# Case Study: Data Engineering Modernization for XYZ Retail

#### Background

XYZ Retail Corporation is a global retail giant looking to modernize its data infrastructure. Their current system is a legacy on-premise **Microsoft SQL Server data warehouse**. It suffers from poor query performance, scalability limitations, and high maintenance overhead. All data integration is handled by **SQL Server Integration Services (SSIS)**packages, which perform basic transformations before loading data.

XYZ began its cloud journey a year ago and has a foundational presence on **AWS**, primarily using **Amazon S3** for ad-hoc data storage. They have chosen **Snowflake** as their strategic cloud data platform and need a comprehensive plan to migrate and build their new analytics ecosystem.

**Their primary data sources include:**

- **Transactional Systems (5):** On-premise relational databases (e.g., PostgreSQL, MySQL) containing sales, inventory, and customer data. This is **structured** data.
- **Web Analytics:** A third-party platform that provides daily exports of website clickstream data in **JSON** format. This is **semi-structured** data.
- **Product Reviews:** A system that captures customer product reviews as raw **text** files. This is **unstructured** data.

#### Objective

You are hired as a data engineering consulting team. Your objective is to design and propose a modern data architecture for XYZ Retail. This solution should replace their legacy on-premise system with a scalable, cloud-native solution using **Snowflake on AWS**. You must detail the migration strategy and the design for future data integration and management.

------

### **Part 1: The Proposal**

#### Instructions

Your team must research and develop a comprehensive technical proposal.

1. **Architecture & Migration Strategy:**
   - Design a modern **Lakehouse architecture**. How will you use **Amazon S3** as a data lake and **Snowflake** as the data warehouse? Explain how they work together.
   - Propose a plan to migrate the historical data from the on-premise MS SQL Server to Snowflake. Should this be a one-time bulk transfer? What tools would you use?
   - Propose a strategy for replacing the on-premise **SSIS ETL jobs**. Critically compare a traditional **ETL**approach with a modern **ELT** approach in the context of this project. Which do you recommend and why?
2. **Data Ingestion & Transformation:**
   - Design data ingestion pipelines for the three main data source types (structured, semi-structured, unstructured).
   - For the ongoing, incremental data loads from the transactional systems, compare using **Snowpipe** vs. a scheduled task-based approach (e.g., using AWS Glue or Snowflake Tasks). What is your recommendation?
   - Explain how you would land, process, and store the `JSON` clickstream data and the `TXT` product reviews. How would you make this data available for analytics in Snowflake? (Hint: Consider Snowflake's `VARIANT` data type and external tables).
   - What file format would you recommend for your S3 data lake (e.g., **Parquet**, CSV, JSON)? Justify your choice based on cost, performance, and compatibility with Snowflake.
3. **Optimization & Governance:**
   - Propose a security and governance model. How will you use **Role-Based Access Control (RBAC)** in Snowflake? How would you handle Personally Identifiable Information (PII) in the customer data? (Hint: Consider data masking).
   - Explain how **Snowflake stages (internal vs. external)** and **external tables** fit into your architecture. When would you use each?

------

### **Part 2: The Deliverables**

Your final submission should be a **PowerPoint presentation** containing the following:

1. **Executive Summary:** A high-level overview of XYZ's challenges and your proposed solution's benefits. (1 slide)
2. **Proposed Architecture Diagram:** A clear, easy-to-read diagram illustrating the flow of data from sources, through the AWS data lake, and into Snowflake. Show the key tools and services at each stage. (1 slide)
3. **Technical Deep Dive:**
   - **Migration Plan:** Step-by-step plan for the initial data migration.
   - **Data Ingestion:** Detailed design for the ongoing data pipelines for each data type.
   - **ETL vs. ELT:** Your analysis and recommendation for replacing SSIS.
   - **Storage & Optimization:** Your recommendations for file formats (e.g., Parquet), table design, and performance tuning (e.g., clustering).
   - **Security & Governance:** Your plan for securing data using RBAC and data masking.
4. **Implementation Plan:**
   - A high-level project timeline with key phases and milestones (e.g., Phase 1: Historical Migration, Phase 2: Pipeline Development, ..etc).
   - A brief discussion of potential risks and how you would mitigate them.

----

