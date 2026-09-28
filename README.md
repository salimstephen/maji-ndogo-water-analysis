# Maji Ndogo Water Access & Infrastructure Analysis

## Overview

This project analyzes water access, service conditions, survey data, and infrastructure needs using the Maji Ndogo water services dataset.

The project was completed as a hands-on data analytics project using SQL, MySQL, and Jupyter Notebooks. The analysis covers data exploration and cleaning, water access analysis, queue-time analysis, auditor report integration, and infrastructure prioritization.

The main objective was to work with relational data, apply practical SQL techniques, identify patterns in water access and service conditions, and organize the findings into structured analytical outputs that can support decision-making.

---

## Project Objectives

The project focuses on answering the following questions:

- How is water access distributed across different locations and source types?
- How many people are served by different water sources?
- What patterns exist in water collection queue times?
- How can auditor information be integrated with the existing water services data?
- Which water sources or infrastructure conditions may require attention?
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
- Using SQL ranking functions to analyze water sources
- Analyzing survey duration and queue times

### 2. Water Access Analysis

The second phase combined information from multiple database tables to examine water access across different locations.

The analysis included:

- Joining visits, locations, water sources, and pollution information
- Comparing water-source distribution across provinces
- Analyzing water access at town level
- Calculating the share of people served by different source types
- Creating an aggregated view for further water-access analysis

### 3. Queue-Time Analysis

The third phase focused specifically on patterns in water collection queue times.

The analysis included:

- Calculating average queue times
- Comparing queue times across different days
- Analyzing queue times by hour
- Examining combined day-and-hour queue patterns
- Organizing queue-time results for further analysis

### 4. Auditor Report Integration

The fourth phase integrated information from an auditor report into the existing database.

The analysis included:

- Loading auditor information into the database
- Connecting audit results with employee, location, visit, and water-source information
- Creating a view to combine audit and operational information
- Comparing audit results across provinces and towns
- Examining audit results associated with individual employees
- Identifying lower audit scores for further investigation

### 5. Infrastructure Prioritization

The final phase used the available water-service information to organize potential infrastructure interventions.

The analysis included potential interventions such as:

- Identifying rivers as potential candidates for alternative water sources
- Prioritizing additional shared taps where queue times are high
- Flagging broken in-home taps for further attention
- Identifying wells with contamination concerns
- Creating a `Project_progress` table to organize potential interventions
- Applying conditional logic based on source type and service conditions

These recommendations are analytical outputs based on the project dataset. They would require additional technical, financial, and field validation before implementation.

---

## SQL Techniques Used

The project applied practical SQL techniques across data exploration, cleaning, analysis, data integration, and prioritization.

### Data Exploration and Cleaning
- `SELECT`, `WHERE`, `ORDER BY`, and filtering
- Data inspection using `DESCRIBE` and table exploration
- Text cleaning and standardization
- Conditional transformations using `CASE`
- Date and time functions
- Data quality checks

### Relational Data Analysis
- `INNER JOIN` and `LEFT JOIN`
- Multi-table joins
- `GROUP BY` and aggregate functions
- Temporary tables
- Common Table Expressions (CTEs)
- Creating analytical views with `CREATE VIEW`

### Analytical SQL
- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- Window functions
- Aggregated comparisons
- Day-of-week and hourly analysis
- Conditional calculations

### Data Integration and Prioritization
- Integrating auditor information with existing database tables
- Combining operational, location, water-source, and quality data
- Creating structured intervention logic using `CASE`
- Updating analytical results based on identified conditions
- Creating and validating the `Project_progress` table

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
+-- outputs/
|
+-- sql/
|   +-- 01_data_exploration.sql
|   +-- 02_water_access_analysis.sql
|   +-- 03_queue_analysis.sql
|   +-- 04_auditor_report_integration.sql
|   +-- 05_infrastructure_prioritization.sql
|
+-- .gitignore
+-- README.md
```

---

## Notebook Breakdown

The notebooks group the analysis into three broader stages, while the SQL directory separates the main database work into five focused scripts for easier review and reuse.

### 01 - Water Crisis Analysis

**File:** `notebooks/01_water_crisis_analysis.ipynb`

This notebook covers the initial exploration, cleaning, and analysis of the Maji Ndogo water-services database.

Key areas include:
- Exploring the database structure and data dictionary
- Examining employees, locations, visits, and water sources
- Cleaning and standardizing employee contact information
- Analyzing employee and field-surveyor activity
- Examining locations by town, province, and location type
- Analyzing water-source types and the number of people served
- Applying SQL ranking functions
- Analyzing survey duration and queue times

### 02 - Auditor Report Integration

**File:** `notebooks/02_auditor_report_integration.ipynb`

This notebook focuses on integrating auditor information with the existing Maji Ndogo water-services data.

Key areas include:
- Exploring the auditor report data
- Examining relationships between audit and operational data
- Connecting auditor information with employees, locations, visits, and water sources
- Creating an analytical view combining audit and service information
- Comparing audit results across provinces and towns
- Examining audit results at employee level
- Identifying lower audit scores for further investigation

### 03 - Water Future Analysis

**File:** `notebooks/03_water_future_analysis.ipynb`

This notebook focuses on water access, service conditions, and potential infrastructure interventions.

Key areas include:
- Combining visits, locations, water sources, and water-quality information
- Analyzing water access across provinces and towns
- Creating the `Project_progress` table
- Examining infrastructure conditions
- Developing conditional logic for potential interventions
- Identifying potential actions for river sources
- Analyzing shared-tap queue conditions
- Identifying broken in-home taps
- Identifying wells with contamination concerns
- Organizing potential infrastructure improvements based on the available data

The notebooks provide the broader analytical workflow, while the SQL scripts separate the main database tasks into focused, reusable sections.

---

## SQL Script Breakdown

### 01 - Data Exploration

**File:** `sql/01_data_exploration.sql`

This script covers the initial exploration and cleaning of the Maji Ndogo database.

Key areas include:
- Exploring database tables and structures
- Inspecting employee and location data
- Cleaning and standardizing employee contact information
- Analyzing field-surveyor activity
- Examining locations by town, province, and location type
- Analyzing water-source types and people served
- Applying ranking functions to water-source analysis
- Examining survey periods and queue-time data

### 02 - Water Access Analysis

**File:** `sql/02_water_access_analysis.sql`

This script combines information from multiple tables to analyze water access across different locations.

Key areas include:
- Joining visits, locations, water sources, and water-quality information
- Creating the `combined_analysis_table` view
- Analyzing water access by province
- Analyzing water access by town
- Examining the number of people served by different water sources
- Calculating water-source shares and aggregated access measures

### 03 - Queue Analysis

**File:** `sql/03_queue_analysis.sql`

This script focuses on patterns in water collection queue times.

Key areas include:
- Calculating average queue times
- Comparing queue times across days
- Analyzing queue times by hour
- Examining combined day-and-hour patterns
- Organizing queue-time results for further analysis

### 04 - Auditor Report Integration

**File:** `sql/04_auditor_report_integration.sql`

This script integrates auditor information with the existing water-services database.

Key areas include:
- Exploring the auditor report and related tables
- Connecting audit information with locations, employees, visits, and water sources
- Creating the `audit_employee_source_view`
- Comparing audit results across provinces and towns
- Examining audit results at employee level
- Identifying lower audit scores for further investigation

### 05 - Infrastructure Prioritization

**File:** `sql/05_infrastructure_prioritization.sql`

This script organizes potential infrastructure interventions based on the available water-service data.

Key areas include:
- Creating the `Project_progress` table
- Identifying potential interventions based on water-source conditions
- Organizing potential actions for river sources
- Applying queue-time conditions to shared taps
- Identifying broken in-home taps
- Identifying wells with contamination concerns
- Applying conditional logic to organize potential interventions
- Performing quality checks on the resulting recommendations

The SQL scripts are organized separately so that each stage of the database analysis can be reviewed and understood independently.

---

## Tools and Technologies

- **MySQL** — relational database management and SQL analysis
- **SQL** — data exploration, cleaning, transformation, analysis, and data integration
- **Jupyter Notebook** — interactive environment for documenting and running the analysis
- **Python** — supporting the Jupyter Notebook workflow
- **Git** — version control
- **GitHub** — project versioning and portfolio presentation

---

## Skills Demonstrated

### SQL and Database Analysis
- Relational database analysis
- Multi-table joins
- Data cleaning and standardization
- Aggregation and grouping
- Common Table Expressions (CTEs)
- Temporary tables
- SQL views
- Window functions
- Ranking with `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`
- Date and time analysis
- Conditional logic using `CASE`

### Data Analytics
- Exploratory data analysis
- Data quality assessment
- Identifying patterns across location and time
- Comparing water access and service conditions
- Translating analytical findings into structured outputs
- Organizing data to support decision-making

### Data Integration and Analytical Reasoning
- Integrating auditor and operational data
- Connecting information across related tables
- Designing analytical views
- Developing condition-based intervention logic
- Validating analytical results
- Documenting assumptions and limitations

---

## How to Reproduce

This project was developed using a local MySQL database and Jupyter Notebook.

### Requirements

- MySQL
- Python
- Jupyter Notebook or JupyterLab
- Required Python packages used by the notebooks
- The Maji Ndogo water-services dataset

### Setup

1. Clone this repository.
2. Set up a local MySQL database using the Maji Ndogo dataset.
3. Update the database connection in the notebook with your own MySQL username, password, host, and database name.
4. Open the notebooks in Jupyter Notebook or JupyterLab.
5. Run the notebooks in sequence to follow the analytical workflow.
6. Review the SQL scripts in the `sql/` directory for the individual database analysis stages.

The repository does not include the local database, raw data files, or database credentials. These files and credentials are excluded through `.gitignore`.

### Suggested Notebook Order

1. `01_water_crisis_analysis.ipynb`
2. `02_auditor_report_integration.ipynb`
3. `03_water_future_analysis.ipynb`

The SQL scripts in the `sql/` directory can be reviewed independently according to their descriptions in the SQL Script Breakdown section.

---

## Data and Security

The repository is structured to keep local database files, raw data files, environment files, and credentials out of version control.

- Database credentials are not stored in the repository.
- Notebook database connections use placeholders for local credentials.
- Local database files and raw CSV/Excel files are excluded through `.gitignore`.
- Environment and cache files are also excluded from version control.
- The project can be configured locally using the user's own database credentials and data files.

---

## Project Limitations

- The analysis depends on the quality, completeness, and accuracy of the available dataset.
- Some analytical conclusions depend on assumptions made from the available data.
- The project was developed as a learning and portfolio project rather than a production analytics system.
- Infrastructure priorities are based on the available water-service data and analytical conditions identified in the project.
- The proposed interventions have not been independently validated through field assessments, engineering studies, financial analysis, or implementation planning.
- Additional operational, technical, financial, and community-level information would be required before using the findings for real-world implementation.

---

## Key Takeaways

This project provided practical experience applying SQL across a complete data analytics workflow, from database exploration and cleaning to analysis, data integration, and structured prioritization.

Key takeaways include:

- Working with relational data across multiple connected tables
- Cleaning and standardizing real-world style data
- Using joins, aggregations, CTEs, views, temporary tables, and window functions
- Analyzing patterns across locations and time
- Integrating auditor information with operational data
- Translating analytical conditions into structured outputs
- Using data to organize potential areas for further investigation and intervention
- Documenting assumptions, limitations, and data-quality considerations

---

## Author

**Stephen Otieno**

Data Science & Analytics Professional

- **GitHub:** [salimstephen](https://github.com/salimstephen)
- **Portfolio:** [salimstephen.vercel.app](https://salimstephen.vercel.app/)
- **LinkedIn:** [Stephen Otieno](https://linkedin.com/in/otieno-stephen)

---

## Project Note

This is a learning and portfolio project based on the Maji Ndogo water services dataset. It demonstrates practical SQL and data analytics skills, including relational data analysis, data cleaning, joins, aggregation, window functions, data integration, and analytical prioritization.

The infrastructure-related outputs are analytical results based on the available dataset and should not be interpreted as independently validated engineering, financial, or policy recommendations.
