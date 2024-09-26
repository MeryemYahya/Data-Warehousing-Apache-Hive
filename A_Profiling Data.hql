 --A-profiling data


--insall jar csv serde
add jar hdfs:///user/hdfs/csv-serde-1.1.2-0.11.0-all.jar;
list jars;

--create database office
create database  backoffice;
use backoffice;


-- create tables stage sales
CREATE EXTERNAL TABLE backoffice.stage_sales (
  RowID string,
  OrderID string,
  OrderDate string,
  OrderMonthYear string,
  Quantity string,
  Quote string,
  DiscountPct string,
  Rate string,
  SaleAmount string,
  CustomerName string,
  CompanyName string,
  Sector string,
  Industry string,
  City string,
  ZipCode string,
  State string,
  Region string,
  ProjectCompleteDate string,
  DaystoComplete string,
  ProductKey string,
  ProductCategory string,
  ProductSubCategory string,
  Consultant string,
  Manager string,
  HourlyWage string,
  RowCount string,
  WageMargin string
  )
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = '"',
  "escapeChar"    = "\\"
)
STORED AS TEXTFILE 
Location "/user/hdfs/data/sales" 
tblproperties('skip.header.line.count'='1', 'serialization.null.format'='');