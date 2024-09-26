# Data Warehousing with Apache Hive

## Project Overview
This project focuses on building a data warehousing solution using Apache Hive to manage, clean, and analyze sales, client, and ZIP code data. The primary objective was to store large datasets, ensure data quality, and create dimension and fact tables for effective reporting. The solution was implemented in a Hadoop environment, leveraging HDFS for distributed storage and Hive for data processing.
## Dataset Details
- **Sales Data:** The sales dataset contains fields such as `OrderID`, `OrderDate`, `Quantity`, `SaleAmount`, `CustomerName`, `City`, `State`, and product details. This data was loaded into an external Hive table for transformation and analysis.
- **Client Data:** The client dataset provides business details like `Company Name`, `Stock Symbol`, `Market Value`, and `Industry`. It was joined with the sales data for generating comprehensive reports.
- **Zip Code Data:** The ZIP code dataset was used to enrich and clean sales records that had missing or incorrect geographic details like `City`, `State`, and `ZipCode`.

## Pre-processing Setup
Before processing the data, ensure that the necessary Hadoop commands from the provided  `createDirAndLoadData.txt ` file are executed. These commands include
  1. Creating HDFS Directories.
  2. Loading Data into HDFS.
  3. Loading CSV SerDe Setup JAR.
   
## Steps Accomplished:
### 1. **Data Profiling:** 
The raw sales, client, and ZIP code files were extracted, loaded into HDFS, and external Hive tables were created. CSV SerDe was installed to enable reading the data in CSV format.

### 2. **Data Quality Testing:** 
The data was analyzed for quality issues like missing or invalid `OrderID`, `OrderDate`, `City`, and `ZipCode`. All discrepancies were logged into the `audit_log` table.

### 3. Data Transformation:
  - **Handling Missing Data:** Missing `OrderID` rows were filtered out, while invalid dates were replaced with `9999-12-31`. Blank `Product Keys` were filled with `#Unknown`.
  - **Geographic Data Enrichment:** Missing or incorrect geographic fields (City, State, ZipCode) were resolved by cross-referencing the provided ZIP code dataset.

### 4. Dimension Table Creation:
  - A `Zipcode Lookup` table was created using the provided ZIP code dataset, which helped resolve missing or incorrect `City` and `State` values.
  - A `Clients` table was also created, associating each sale with the corresponding client data and assigning appropriate `Client IDs`.

### 5. Fact Table Creation: 
A `sales_all_years` fact table was built, consolidating all the cleaned and processed sales data for efficient querying and reporting.

### 6. Reporting:
Reports were generated using Hive's `GROUP BY`, `ROLLUP`, and `CUBE` functionalities. These reports provided insights into sales performance by geography, product categories, and client segments.

## Technologies Used:
- **Apache Hive:** Used for querying and processing the data warehouse.
- **HDFS:** Utilized for distributed storage of large datasets.
- **CSV SerDe:** Installed for seamless integration of CSV files in Hive.




