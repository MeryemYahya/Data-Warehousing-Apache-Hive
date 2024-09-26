--create audit database and audit log table to stare our quality testing query result
create database audit;

create table audit.audit_log
(db string,
tbl string,
audit_type string,
message string,
tbl_key string,
cnt int,
ts timestamp);


--B-Data Quality Testing

--blank orderid 
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null business key count'
, 'business key is orderid'
, 'orderid'
, count(*)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where orderid = '';

--blank orderdate 
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null value'
, 'orderdate is null table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where orderdate = '';


--blank saleamount 
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null value'
, 'saleamount is null table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where saleamount = '';


--missing city 
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null value'
, 'city is null table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where city = '';


--missing state 

insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null value'
, 'state is null table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where state = '';


--missing zipcode 

insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null value'
, 'zipcode is null table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where zipcode = '';

-- invalid orderdate 
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null/invalid value'
, 'orderdate is null/invalid table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where from_unixtime(unix_timestamp(orderdate, 'yyyy-MM-dd')) is null;


-- invalid projectcompletedate
insert into table audit.audit_log
select 'backoffice'
, 'stage_sales'
, 'null/invalid value'
, 'projectcompletedate is null/invalid table key is orderid'
, orderid
, cast(null as int)
, from_unixtime(unix_timestamp())
from backoffice.stage_sales
where from_unixtime(unix_timestamp(projectcompletedate, 'yyyy-MM-dd')) is null;