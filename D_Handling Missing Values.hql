insert overwrite table cleansed_sales
select  RowID, null, 
    OrderID,
    case when OrderDate = '' then '9999-12-31' 
         else OrderDate end as OrderDate,
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
    DaysToComplete,
    case when ProductKey = '' then '#Unknown' 
         else ProductKey end as ProductKey,
    ProductCategory,
    ProductSubCategory,
    Consultant,
    Manager,
    HourlyWage,
    RowCount,
    WageMargin
    from backoffice.stage_sales
    where OrderID <> '';
