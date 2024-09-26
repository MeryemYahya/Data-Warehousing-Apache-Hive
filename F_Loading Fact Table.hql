--Create Fact Table
create table default.sales_all_years (
    RowID smallint,
    ClientID int,
    OrderID int,
    OrderDate date,
    OrderMonthYear date,
    Quantity int,Quote float,DiscountPct float,Rate float,SaleAmount float,
    CustomerName string,
    CompanyName string,Sector string,
    Industry string,City string,
    ZipCode string,
    State string,
    Region string,
    ProjectCompleteDate date,DaystoComplete int,ProductKey string,
    ProductCategory string, ProductSubCategory string, Consultant string,Manager string,
    HourlyWage float,
    RowCount int,
    WageMargin float);


    --load cleansed data
insert overwrite table default.sales_all_years
select RowID,ClientID,
    OrderID,
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
    City,
    ZipCode,
    State,
    Region,
    ProjectCompleteDate,
    DaysToComplete, ProductKey,ProductCategory,
    ProductSubCategory,
    Consultant,
    Manager,
    HourlyWage,
    RowCount,
    WageMargin
from backoffice.cleansed_sales;