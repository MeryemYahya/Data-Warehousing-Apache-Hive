--create table zipcode
CREATE EXTERNAL TABLE zipcode_lookup (
  zipcode smallint,
  type string,
  decommissioned bigint,
  primary_city string,
  acceptable_cities string,
  unacceptable_cities string,
  state string,
  state_name string,
  county string,
  timezone string ,
  area_codes string,
  world_region string,
  country string,
  latitude float,
  longitude float,
  irs_estimated_population_2014 bigint
  )
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = '"',
  "escapeChar"    = "\\"
)
STORED AS TEXTFILE 
Location '/user/hdfs/data/zipcode'
tblproperties('skip.header.line.count'='1', 'serialization.null.format'='');

-- Find all rows where city or state differ
select  A.city ,B.primary_city , A.state , B.state 
    from cleansed_sales A left join
    zipcode_lookup B on A.zipcode = B.zipcode
    where A.City <> B.primary_city or A.state <> B.state;


-- Fill in zip codes from zipcode look up table

insert overwrite table cleansed_sales
select  RowID, null, OrderID,
    OrderDate,
    OrderMonthYear,
    Quantity,
    Quote,
    DiscountPct,
    Rate,
    SaleAmount,
    CustomerName,
    CompanyName,
    Sector,
    Industry,
    coalesce(z.primary_city, s.city) as City,
    s.ZipCode,
    coalesce(z.state, s.state) as State,
    Region,
    ProjectCompleteDate, DaysToComplete, ProductKey,
    ProductCategory,
    ProductSubCategory,
    Consultant,
    Manager,
    HourlyWage,
    RowCount,
    WageMargin
    from cleansed_sales s 
    left join zipcode_lookup z on s.zipcode = z.zipcode;


--create stage table clients


create table stage_clients (
    ClientID            string,
    Name                string,
    Symbol              string,
    LastSale            string,
    MarketCapLabel      string,
    MarketCapAmount     string,
    IPOyear             string,
    Sector              string,
    industry            string,
    SummaryQuote        string
)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = '"',
  "escapeChar"    = "\\"
)
 STORED AS TEXTFILE 
Location '/user/hdfs/data/clients'
tblproperties('serialization.null.format'='');

-- Add data types for clients table

create table cleansed_clients (
    ClientID            int,
    Name                string,
    Symbol              string,
    LastSale            double,
    MarketCapLabel      string,
    MarketCapAmount     bigint,
    IPOyear             int,
    Sector              string,
    industry            string,
    SummaryQuote        string
);

-- Load cleansed_clients
insert into cleansed_clients
select    cast(ClientID as int) as ClientID,
    Name,
    Symbol,
    LastSale,
    MarketCapLabel,
    cast(MarketCapAmount as bigint) as MarketCapAmount,
    cast(IPOyear as int) as IPOyear,
    Sector              string,
    industry            string,
    SummaryQuote        string 
from stage_clients;


-- Update sales table with clientIDs
insert overwrite table cleansed_sales
select  RowID, c.ClientID, OrderID,
    OrderDate,
    OrderMonthYear,
    Quantity,
    Quote,
    DiscountPct,
    Rate,
    SaleAmount,
    CustomerName,
    CompanyName,
    s.Sector,
    s.Industry,
    City,
    ZipCode,
    State,
    Region,
    ProjectCompleteDate,
    DaysToComplete , ProductKey, ProductCategory,
    ProductSubCategory,
    Consultant,
    Manager,
    HourlyWage,
    RowCount,
    WageMargin
    from cleansed_sales s
    left join cleansed_clients c on s.companyname = c.name;

