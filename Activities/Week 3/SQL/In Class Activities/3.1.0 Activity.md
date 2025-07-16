# **Activity: A Comparative Analysis of OLTP and Data Warehousing**



**Learning Objective:** To understand the fundamental differences between Online Transaction Processing (OLTP) systems and Data Warehouses (DW), and to identify the appropriate application for each based on business requirements.

**Introduction**

In this activity, we will conduct a detailed exploration of OLTP systems and Data Warehouses. OLTP databases are optimized for managing transactional data and supporting day-to-day business operations. In contrast, Data Warehouses are architected for analytical queries and reporting to facilitate business intelligence. A thorough understanding of both is critical for effective data management and system design.

### **I. Research and Investigation**

Your group is tasked with researching the distinct characteristics of OLTP systems and Data Warehouses. Use the following framework to guide your investigation and document your findings.

**Research Framework:**

| **Attribute**               | **OLTP (Online Transaction Processing)**                     | **Data Warehouse (DW)**                                      |
| :-------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **Primary Purpose**         | Define its primary function within an organization.          | Define its primary function within an organization.          |
| **Design Focus**            | Is the system subject-oriented or application-oriented?      | Is the system subject-oriented or application-oriented?      |
| **Data Model**              | Describe the typical database schema (e.g., normalization level). | Describe the typical database schema (e.g., star, snowflake). |
| **Unit of Work**            | Characterize the common operations (e.g., `INSERT`, `UPDATE`). | Characterize the common operations (e.g., complex analytical queries). |
| **Primary Users**           | Identify the typical user base for the system.               | Identify the typical user base for the system.               |
| **Data Granularity & Size** | Describe the level of detail and typical data volume.        | Describe the level of detail and typical data volume.        |
| **Performance Metrics**     | What are the key performance indicators for this system?     | What are the key performance indicators for this system?     |
| **Example Technologies**    | List two to three representative database technologies.      | List two to three representative database technologies.      |

**Key Terminology:** Your group must be prepared to define and discuss the following core concepts:

- ACID Properties
- Database Normalization
- ETL (Extract, Transform, Load) Process
- Star Schema & Snowflake Schema
- OLAP (Online Analytical Processing)

### **II. Scenario Analysis**

Apply your research to the following business use cases. For each scenario, your group will determine whether an OLTP system or a Data Warehouse is the more suitable solution and prepare a justification for your decision.

- **Scenario A: E-commerce Order Processing** An online retail company requires a system to manage customer transactions. This system must handle user registrations, shopping cart management, order placement, payment processing, and inventory updates in real-time. The integrity and speed of each transaction are paramount.
- **Scenario B: Corporate Financial Analysis** A multinational corporation needs to perform a comprehensive analysis of its financial performance over the last decade. The system must consolidate data from various regional sales systems to allow executives to analyze revenue trends, profit margins by product line, and quarterly growth patterns.
- **Scenario C: Airline Reservation System** An airline is developing a system for managing flight reservations. It must allow thousands of travel agents and customers to search for flights, book seats, and process payments simultaneously. The system must ensure that a seat, once booked, cannot be assigned to another passenger.

### **III. Presentation of Findings**

Each group will deliver a formal presentation to the class summarizing its research and analysis.

**Presentation Requirements:**

1. **Introduction:** State the topic and objective.
2. **OLTP System Profile:** Provide a definition, purpose, and key characteristics of OLTP systems.
3. **Data Warehouse Profile:** Provide a definition, purpose, and key characteristics of Data Warehouses.
4. **Comparative Analysis:** Present a direct comparison of OLTP and DW based on the attributes from the research framework. A comparison table is recommended for clarity.
5. **Scenario Justification:** Select one of the scenarios (A, B, or C) and present your group's recommendation. Detail the rationale behind your choice of an OLTP system or a Data Warehouse.
6. **Conclusion:** Briefly summarize the core distinction between the two systems. You will then take questions from the class.