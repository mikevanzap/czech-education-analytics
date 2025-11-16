## Power BI Connection Guide

### Option 1: Direct Query to Trino
1. Install [Trino ODBC Driver](https://trino.io/docs/current/installation/odbc.html)
2. In Power BI Desktop: Get Data → ODBC → DSN: `Trino_DSN`
3. Query: `SELECT * FROM hive.analytics.fct_regional_education`

### Option 2: Import from SQL Server
1. Get Data → SQL Server
2. Server: `localhost`
3. Database: `education_db`
4. Table: `analytics.fct_regional_education` (after dbt writes there)