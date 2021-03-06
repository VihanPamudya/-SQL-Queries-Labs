CREATE DATABASE Tutorial_05
USE Tutorial_05


go
create table Customers
(
    cid char(4) primary key,
    name VARCHAR(50),
    phone char(10),
    country VARCHAR(20)
)

create table Employees
(
    eid char(4) primary key,
    ename varchar(50),
    phone char(10),
    birthdate date
)

create table Products
(
    productId char(4) primary key,
    productName varchar(15),
    unitPrice real,
    unitInStock int,
    ROL int
)

create table Orders
(
    oid int primary key,
    eid char(4) references Employees(eid),
    cid char(4) references Customers(cid),
    orderDate date,
    requiredDate date,
    shippedDate date,
    cost real
)

create table orderDetails
(
    oid int,
    productId char(4) references Products(productId),
    quantity int,
    discount real,
    constraint orderDetails_pk PRIMARY KEY(oid,productId)
)

insert into Customers values('C001','Saman','0772446552','Sri Lanka')
insert into Customers values('C002','John','0987665446','USA')
insert into Customers values('C003','Mashato','0927665334','Japan')

insert into Employees values('E001','Kasun Weerasekara','0702994459','07-Apr-1997')
insert into Employees values('E002','Sathira Wijerathna','0760510056','05-Feb-1996')

insert into Products values('P001','Hard Disk',12000,80,50)
insert into Products values('P002','Flash Drive',3200,60,20)
insert into Products values('P003','LCD Monitor',24000,35,15)


INSERT into Orders VALUES(1,'E001','C001','01-Sep-2020','09-Sep-2020','02-Sep-2020',null)

INSERT into orderDetails VALUES(1,'P001',3,0.1);
INSERT into orderDetails VALUES(1,'P002',5,0.15);
INSERT into orderDetails VALUES(1,'P003',2,0.15);

go

-- Q1
CREATE FUNCTION calcCost (@ordid int)
RETURNS REAL
AS
BEGIN
	Declare @totalCost real
	select @totalCost=sum(od.quantity*p.unitPrice)
	from orderDetails od, Products p
	where p.productId=od.productId and od.oid=@ordid
	return @totalCost
END

declare @grand real
exec @grand=calcCost 1
print @grand
 

-- Q2 Write a table valued function named productsOfOrder which accepts the order id and returns all
-- product names of the order with quantity
CREATE FUNCTION productsOfOrder (@ordid int)
RETURNS @myTable TABLE
(
	productName varchar(15),
	qty int
)
AS
BEGIN
	INSERT into @myTable
		SELECT p.productName,od.quantity
		FROM Products p,orderDetails od
		where p.productId=od.productId and od.oid=@ordid
	RETURN
END    

SELECT *
from productsOfOrder(1)


-- Q3 Modify the table valued function you wrote in question 2 to display records with only product name has ?disk?.
-- Hint: delete the records of the table with product name does not like ?disk? inside the function
alter FUNCTION productsOfOrder (@ordid int)
RETURNS @myTable TABLE
(
	productName varchar(15),
	qty int
)
AS
BEGIN
	INSERT into @myTable
		SELECT p.productName,od.quantity
		FROM Products p,orderDetails od
		where p.productId=od.productId and od.oid=@ordid and p.productName like '%disk%'

		DELETE FROM @myTable where productName not like '%disk%'
	RETURN
END    

GO

-- Q4
CREATE FUNCTION orderInfo (@ordid int)
RETURNS @myTable1 TABLE
(
	prodUCTName varchar(15),
	qty int,
	unitAmt real,
	totAmt real,
	discount real,
	payAmt real
)
AS
BEGIN
	INSERT into @myTable1
		SELECT p.productName,
		od.quantity,
		p.unitPrice,
		od.quantity*p.unitPrice,
		od.discount*od.quantity*p.unitPrice,
		od.quantity*p.unitPrice-(od.discount*od.quantity*p.unitPrice)
		FROM Products p,orderDetails od
		where p.productId=od.productId and od.oid=@ordid
	RETURN
END

SELECT *
from orderInfo(1)

go

-- Q5
ALTER FUNCTION orderInfo (@ordid int)
RETURNS @myTable1 TABLE
(
	prodUCTName varchar(15),
	qty int,
	unitAmt real,
	totAmt real,
	discount real,
	payAmt real
)
AS
BEGIN
	INSERT into @myTable1
		SELECT p.productName,
		od.quantity,
		p.unitPrice,
		od.quantity*p.unitPrice,
		od.discount*od.quantity*p.unitPrice,
		od.quantity*p.unitPrice-(od.discount*od.quantity*p.unitPrice)
		FROM Products p,orderDetails od
		where p.productId=od.productId and od.oid=@ordid

		UPDATE @myTable1 set discount=0,payAmt=totAmt where qty<=2
	RETURN
END

SELECT *
from orderInfo(1)