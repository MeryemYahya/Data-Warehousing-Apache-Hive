-- create table for cleansed sales data with correct types
create table cleansed_sales (
    RowID smallint,
    ClientID int,
    OrderID int,
    OrderDate date,
    OrderMonthYear date,
    Quantity int,
    Quote float,
    DiscountPct float,
    Rate float,
    SaleAmount float,
    CustomerName string,
    CompanyName string,
    Sector string,
    Industry string,
    City string,
    ZipCode string,
    State string,
    Region string,
    ProjectCompleteDate date,
    DaystoComplete int,
    ProductKey string,
    ProductCategory string,
    ProductSubCategory string,
    Consultant string,
    Manager string,
    HourlyWage float,
    RowCount int,
    WageMargin float);

-- Insert data into cleansed_sales table
insert into cleansed_sales
select cast(RowID as smallint) as RowID,
    cast(null as int) as ClientID,
    cast(OrderID as int) as OrderID,
    cast(OrderDate as date) as OrderDate,
    cast(OrderMonthYear as date) as OrderMonthYear,
    cast(Quantity as int) as Quantity,
    cast(Quote as float) as Quote,
    cast(DiscountPct as float) as DiscountPct,
    cast(Rate as float) as Rate,
    cast(SaleAmount as float) as SaleAmount,
    CustomerName,
    CompanyName,
    Sector,
    Industry,
    City,
    ZipCode,
    State,
    Region,
    cast(ProjectCompleteDate as date) as ProjectCompleteDate,
    cast(DaystoComplete as int) as DaysToComplete,
    ProductKey,
    ProductCategory,
    ProductSubCategory,
    Consultant,
    Manager,
    cast(HourlyWage as float) as HourlyWage,
    cast(RowCount as int) as RowCount,
    cast(WageMargin as float) as WageMargin
    from backoffice.stage_sales;

-- do a row count for the new table
select count(*) from cleansed_sales; --8316
insert into table audit.audit_log
select 'backoffice'
, 'cleansed_sales'
, 'table row count'
, cast(null as string)
, 'orderid'
, count(*)
, from_unixtime(unix_timestamp())
from backoffice.cleansed_sales;
