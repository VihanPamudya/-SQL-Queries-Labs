CREATE DATABASE Tutorial_04_part02
USE Tutorial_04_part02

create table department
(
 did varchar(5),
 dname varchar(20),
 budget money,
 mgrid varchar(5),
 constraint department_pk primary key(did)
)
create table employee
(
 eid varchar(5),
 ename varchar(20),
 age int,
 salary money,
 did varchar(5),
 supervId varchar(5),
 constraint employee_pk primary key(eid),
 constraint employee_fk1 foreign key (did) REFERENCES department(did),
 constraint employee_fk2 foreign key (supervId) REFERENCES employee(eid)
)
alter table department add constraint department_fk foreign key (mgrid) REFERENCES employee(eid)
insert into department values ('d001','HR',250000,null)
insert into department values ('d002','Sales',340000,null)
insert into department values ('d003','Accounts',560000,null)
insert into department values ('d004','IT',590000,null)
insert into employee values('e001','Saman',23,70000,'d001',null)
insert into employee values('e002','Kamal',31,34000,'d001','e001')
insert into employee values('e003','Nipun',22,56000,'d003','e001')
insert into employee values('e004','Kasun',23,54000,'d002','e003')
insert into employee values('e005','Heshan',31,60000,'d002','e001')
insert into employee values('e006','Aruni',25,47000,'d004','e003')
insert into employee values('e007','Sachini',21,32000,'d002','e004')
update department set mgrid='e002' where did='d001'
update department set mgrid='e001' where did='d002'
update department set mgrid='e001' where did='d003'
update department set mgrid='e003' where did='d004'go-- Q1CREATE TRIGGER Trigger_3
on employee
after INSERT,UPDATE
AS
BEGIN
	
	declare @salary money
	declare @superid varchar(5)
	declare @supersal money
	select @salary=salary,@superid=supervId from inserted
	select @supersal=salary from employee where eid=@superid
	if @supersal<@salary
		BEGIN
			rollback transaction
		END
END

select * from employee

go

-- Q2CREATE View DeptMgr_Details
AS

select d.did,d.dname,d.budget,d.mgrid,e.ename,e.age,e.salary,e.supervId
from department d, employee e
where e.eid=d.mgrid


go

-- Q3
CREATE TRIGGER Trigger_4
on DeptMgr_Details
instead of INSERT
AS
BEGIN
	DECLARE @did VARCHAR(5)
	DECLARE @dname VARCHAR(20)
	DECLARE @budget money
	DECLARE @mgrid VARCHAR(5)
	DECLARE @mgrName VARCHAR(5)
	DECLARE @age int
	DECLARE @salary money
	DECLARE @superId VARCHAR(5)
	select @did=did,@dname=dname,@budget=budget,@mgrid=mgrid,@mgrName=ename,@age=age,@salary=salary,@superId=supervId from inserted
	if not exists(select * from department where did=@did) and not exists (select * from employee where eid=@mgrid)
	BEGIN
		if exists(select * from employee where eid=@superId)
		BEGIN
			insert into department values(@did,@dname,@budget,null)
			insert into employee values(@mgrid,@mgrName,@age,@salary,@did,@superId)
			update department set mgrid=@mgrid where did=@did 
		END
	END
END 

go

-- Q4
create view Low_budgeted_departments
as
select *
from department
where budget<500000


go
create trigger readOnlyView
on Low_budgeted_departments
INSTEAD of INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT 'BLA BLA'
END

