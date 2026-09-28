# Maji Ndogo Water Access & Infrastructure Analysis

## Overview

This project analyzes water access, service conditions, survey data, and infrastructure needs using the Maji Ndogo water services dataset.

The project was completed as a hands-on data analytics project using SQL, MySQL, and Jupyter Notebooks. The analysis covers data exploration and cleaning, water access analysis, queue-time analysis, auditor report integration, and infrastructure prioritization.

The main objective was to work with relational data, apply practical SQL techniques, identify patterns in water access and service conditions, and organize the results into structured analytical outputs.

---

## Project Objectives

The analysis focuses on questions such as:

- How is water access distributed across different locations and source types?
- How many people are served by different water sources?
- What patterns exist in water collection queue times?
- How can auditor information be integrated with the existing database?
- Which infrastructure conditions may require attention?
- How can the available data be used to organize potential intervention priorities?

---

## Analysis Workflow

### 1. Data Exploration and Cleaning

The first phase focused on understanding the database structure and improving data quality.

Key activities included:

- Exploring database tables and relationships
- Examining employee, location, visit, and water-source data
- Cleaning employee email addresses
- Standardizing employee phone numbers
- Analyzing employee distribution across locations
- Identifying field surveyors with high visit counts
- Exploring different water-source types
- Calculating the number of people served by different water sources
- Using SQL ranking functions to prioritize water sources
- Analyzing survey duration and queue times

### 2. Water Access Analysis

The second phase combined information from multiple database tables to examine water access across different locations.

The analysis included:

- Joining visits, locations, water sources, and pollution information
- Comparing water-source distribution across provinces
- Analyzing water access at town level
- Calculating the share of people served by different source types
- Examining queue-time patterns
- Creating an aggregated view for further water-access analysis

### 3. Auditor Report Integration

The third phase integrated information from an auditor report into the existing database.

The analysis included:

- Loading auditor information into the database
- Connecting audit results with employee, location, visit, and water-source information
- Creating a view to combine audit and operational information
- Comparing audit results across provinces and towns
- Examining audit results associated with individual employees
- Identifying areas with lower audit scores for further investigation

### 4. Infrastructure Prioritization

The final phase translated the analysis into structured infrastructure recommendations.

The analysis included potential interventions such as:

- Recommending wells as alternatives for river-based water sources
- Prioritizing additional shared taps where queue times are high
- Flagging broken in-home taps for infrastructure diagnosis
- Considering different treatment approaches for contaminated wells
- Creating a `Project_progress` table to organize potential interventions
- Applying conditional logic to assign potential improvements based on source type and service conditions

These recommendations are analytical outputs based on the project dataset. They would require additional technical, financial, and field validation before implementation.

---

## SQL Techniques Used

This project demonstrates practical use of several SQL techniques:

- `SELECT`
- `WHERE`
- `JOIN`
- `GROUP BY`
- Aggregate functions
- `CASE` statements
- Common Table Expressions (CTEs)
- `CREATE VIEW`
- Temporary tables
- `UPDATE`
- Window functions
- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- Date and time functions
- Data cleaning and standardization
- Conditional calculations
- Data integration

---

## Project Structure

```text
Maji_Ndogo_Water_Analysis/
|
+-- notebooks/
|   +-- 01_water_crisis_analysis.ipynb
|   +-- 02_auditor_report_integration.ipynb
|   +-- 03_water_future_analysis.ipynb
|
+-- sql/
|   +-- 01_data_exploration.sql
|   +-- 02_water_access_analysis.sql
|   +-- 03_queue_analysis.sql
|   +-- 04_auditor_report_integration.sql
|   +-- 05_infrastructure_prioritization.sql
|
+-- outputs/
|
+-- .gitignore
+-- README.md
---

## Notebook Breakdown

### 01 - Water Crisis Analysis

**File:** `notebooks/01_water_crisis_analysis.ipynb`

This notebook focuses on the initial exploration, cleaning, and analysis of the Maji Ndogo water services database.

Main areas covered:

- Database structure exploration
- Data dictionary inspection
- Employee data cleaning
- Email standardization
- Phone number cleaning
- Employee and surveyor analysis
- Location analysis
- Water-source analysis
- People served by source type
- SQL ranking functions
- Survey duration analysis
- Queue-time analysis

### 02 - Auditor Report Integration

**File:** `notebooks/02_auditor_report_integration.ipynb`

This notebook integrates the auditor's report with the existing Maji Ndogo database.

Main areas covered:

- Database table exploration
- Understanding relationships between tables
- Auditor report integration
- Combining audit information with employee and location data
- Audit score analysis
- Province and town comparisons
- Employee-level audit analysis

### 03 - Water Future Analysis

**File:** `notebooks/03_water_future_analysis.ipynb`

This notebook focuses on analyzing water access conditions and organizing potential infrastructure improvements.

Main areas covered:

- Combining visits, locations, water sources, and pollution information
- Provincial and town-level water access analysis
- Creating the `Project_progress` table
- Identifying infrastructure conditions
- River-source intervention logic
- Shared-tap queue analysis
- Broken in-home tap analysis
- Well contamination analysis
- Potential infrastructure improvements

---

## SQL Script Breakdown

The `sql` directory contains the main SQL analysis organized into separate scripts.

### 01 - Data Exploration

**File:** `sql/01_data_exploration.sql`

Contains SQL queries for:

- Database exploration
- Employee data cleaning
- Employee analysis
- Location analysis
- Field surveyor analysis
- Water-source analysis
- Ranking water sources
- Survey period analysis
- Queue-time analysis

### 02 - Water Access Analysis

**File:** `sql/02_water_access_analysis.sql`

Contains SQL queries for:

- Combining water-source, location, visit, and pollution information
- Creating the `combined_analysis_table` view
- Province-level water-access analysis
- Town-level water-access analysis
- Calculating water-source shares

### 03 - Queue Analysis

**File:** `sql/03_queue_analysis.sql`

Contains SQL queries for:

- Average queue time
- Average queue time by day
- Average queue time by hour
- Day and hour queue-time analysis

### 04 - Auditor Report Integration

**File:** `sql/04_auditor_report_integration.sql`

Contains SQL queries for:

- Exploring database tables
- Inspecting relationships between relevant tables
- Integrating auditor information
- Creating an audit analysis view
- Province and town-level audit analysis
- Employee-level audit analysis

### 05 - Infrastructure Prioritization

**File:** `sql/05_infrastructure_prioritization.sql`

Contains SQL queries for:

- Creating the `Project_progress` table
- Assigning potential infrastructure improvements
- Applying source-specific intervention logic
- Prioritizing shared-tap improvements using queue time
- Identifying broken in-home taps
- Applying contamination-based recommendations
- Performing basic quality checks

---

## Tools and Technologies

- **MySQL** - relational database management
- **SQL** - data exploration, cleaning, analysis, and transformation
- **Jupyter Notebook** - interactive analysis and documentation
- **Python** - supporting notebook environment
- **Git** - version control
- **GitHub** - project documentation and portfolio presentation

---

## Skills Demonstrated

### SQL and Database Analysis

- Relational database analysis
- Multi-table joins
- Data cleaning
- Aggregation
- Common Table Expressions
- Window functions
- Views
- Temporary tables
- Conditional logic
- Date and time analysis

### Data Analytics

- Exploratory data analysis
- Data quality investigation
- Pattern identification
- Location-based analysis
- Time-based analysis
- Analytical prioritization
- Translating data into structured recommendations

### Data Integration

- Integrating external audit information
- Connecting related datasets
- Creating analytical views
- Combining operational and audit information
- Structuring data for decision support

---

## How to Reproduce the Analysis

The notebooks were developed using a local MySQL database containing the Maji Ndogo project data.

To reproduce the analysis:

1. Set up a local MySQL environment.
2. Load the required Maji Ndogo dataset into MySQL.
3. Configure the database connection in the notebooks using your own local credentials.
4. Open the notebooks using Jupyter Notebook or JupyterLab.
5. Run the notebooks in sequence.
6. Use the SQL scripts in the `sql` directory as a reference for the main analytical queries.

The repository does not contain database credentials or local database files.

---

## Data and Security

Database credentials are not included in this repository.

Local database files, CSV files, Excel files, environment files, and Python cache files are excluded through `.gitignore`.

The database connection shown in the notebooks uses placeholder credentials rather than a real password.

---

## Project Limitations

- The analysis depends on the structure and quality of the provided project dataset.
- Some calculations depend on assumptions defined during the original analysis.
- The project is designed as a learning and portfolio project rather than a production data system.
- Infrastructure recommendations are analytical outputs based on the available data.
- Any real-world implementation would require additional technical, financial, operational, and field validation.

---

## Key Takeaways

This project demonstrates how SQL can be used throughout a practical data analytics workflow, from understanding and cleaning relational data to integrating additional information and organizing analytical findings.

The project brings together:

- Database exploration
- Data cleaning
- Relational joins
- Aggregation
- Window functions
- Time-based analysis
- Data integration
- Analytical prioritization
- Structured decision-support analysis

---

## Author

**Stephen Otieno**

Data Science & Analytics Professional

- GitHub: https://github.com/salimstephen
- Portfolio: https://salimstephen.vercel.app/
- LinkedIn: https://linkedin.com/in/otieno-stephen

---

## Project Note

This repository represents a learning and portfolio project based on the Maji Ndogo water services dataset.

The analysis is intended to demonstrate practical SQL and data analytics skills. The infrastructure recommendations presented in the project are analytical outputs based on the available dataset and should not be interpreted as independently validated engineering, financial, or policy recommendations.