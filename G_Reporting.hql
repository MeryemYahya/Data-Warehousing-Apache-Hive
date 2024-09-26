use default;

-------- Total sales avg quantity

------------------------------per mounth per year
create view vw_sales_mountly as 
select OrderMonth
, OrderYear
,count(*) as OrderCount
,sum(SaleAmount) as SalesTotal
,avg(Quantity) as AvgOrderSize
from
(select month(orderdate) as OrderMonth
,year(orderdate) as OrderYear
,SaleAmount
,Quantity
from sales_all_years) a group by OrderMonth, OrderYear;


-------------------------per year
create view vw_sales_yearly as 
select 
 OrderYear
,count(*) as OrderCount
,sum(SaleAmount) as SalesTotal
,avg(Quantity) as AvgOrderSize
from
(
select 
year(orderdate) as OrderYear
,SaleAmount
,Quantity
from sales_all_years) a group by OrderYear;
---------- per companyname sorted desc
create view vw_sales_companyname_desc as 
select 
 companyname
,count(*) as OrderCount
,sum(SaleAmount) as SalesTotal
,avg(Quantity) as AvgOrderSize
from
(
select 
companyname
,SaleAmount
,Quantity
from sales_all_years) a group by companyname sort by SalesTotal;

--per productsubcategory sorted desc
create view vw_sales_categorie_desc as 
select 
 productsubcategory as ProductCategory
,count(*) as OrderCount
,sum(SaleAmount) as SalesTotal
,avg(Quantity) as AvgOrderSize
from
(
select 
productsubcategory 
,SaleAmount
,Quantity
from sales_all_years) a
group by productsubcategory 
sort by SalesTotal;

-------------------------------total wage
--totalwage per companyname sorted desc
create view vw_wage_companyname as 
select 
 companyname
,sum(hourlywage) as WageTotal
from
(
select 
companyname,
hourlywage
from sales_all_years) a
group by companyname
sort by WageTotal desc;


--totalwage per year sorted desc
create view vw_wage_year as 
select 
OrderYear
 companyname
,sum(hourlywage) as WageTotal
from
(
select 
year(orderdate) as OrderYear,
hourlywage
from sales_all_years
) a
group by OrderYear
sort by WageTotal desc;

--totalwage per productsubcategory sorted desc
create view vw_wage_productsubcategory as 
select 
productsubcategory as ProductCategory
,sum(hourlywage) as WageTotal
from
(
select 
productsubcategory , hourlywage
from sales_all_years ) a
group by productsubcategory sort by WageTotal desc;





