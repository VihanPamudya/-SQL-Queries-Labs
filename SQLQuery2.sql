CREATE DATABASE Tutorial_02
use Tutorial_02

create table client(
clientNo varchar(6) primary key,
name varchar(20),
city varchar(20),
date_joined datetime,
balance_due money
);
create table product(
 productNo varchar(6) primary key,
 description1 varchar(50),
 profit_margin int ,
 qty_available int,
 re_order_level int,
 item_cost money,
 selling_price money,
 CONSTRAINT chk_Product CHECK (profit_margin>=0 AND profit_margin<=100)
 );
 insert into client values ('C001','Sagara','Colombo','2010-12-20', $25000);
 insert into client values ('C002','Nisansala','Galle','05-08-2014', $12000);
 insert into client values ('C003','Pamith','Piliyandala','2014-01-30', 4500);
 insert into client values ('C004','Amali','Moratuwa','2015-06-15',20000);
 insert into client values ('C005','Nayana','Nugegoda','2011-12-18', 16500);
 insert into client values ('C006','Krishan','Anuradapura','04-03-2014', 22000);
 insert into client values ('C007','Ruwanthi','Maharagama','04-05-2015', 8500);
 insert into client values ('C008','Nalaka','Colombo','20-MAY-2016', $25000);
 insert into client values ('C009','Janaka','Colombo','20-MAY-2016', $25000);
insert into product values ('p0001','FlashDrive 8 GB',5,100, 30,1000,1050);
insert into product values ('p0002','Keyboard',10,25, 5,3500,3850);
insert into product values ('p0003','Mouse',10,50, 15,1200,1320);
insert into product values ('p0004','HardDisk 400 GB',15,20, 5,10000,11500);
insert into product values ('p0005','HardDisk 1 TB',15,35, 3,15000,17250);
insert into product values ('p0006','FlashDrive 32 GB',60,100, 25,1100,1155);
insert into product values ('p0007','LED Monitor 15"',15,15, 5,18000,20700);
insert into product values ('p0008','LED Monitor 17"',20,10, 2,30000,34500);
insert into product values ('p0009','Mouse Pad"',50,10, 2,30,40);
create table Sales_Order
(
Sales_Order_No int primary key,
Sales_Order_Date date,
Order_Taken_By varchar(20),
ClientNo varchar(6),
Delivery_Address varchar(255),
constraint sales_order_fk foreign key(ClientNo) references Client(ClientNo)
)
create table Sales_Order_Details
(
Sales_Order_No int primary key,
Product_No varchar(6),
Quantity int,
constraint order_Details_fk foreign key(Sales_Order_No) references
Sales_Order(Sales_Order_No),
constraint order_Details_fk2 foreign key(Product_No) references Product(ProductNo)
)
create table Items_to_Order
(
NoticeNo int primary key,
Product_No varchar(6),
DateNotified date,
constraint Items_to_order_fk foreign key(Product_No) references Product(ProductNo)
)
insert into Sales_Order values(1,'12-Jan-2010','Nuwani','C001','Homagama')
insert into Sales_Order values(2,'12-Feb-2010','Thushari','C002','Badulla')
insert into Sales_Order values(3,'12-Mar-2010','Sunil','C003','Narahenpita')
insert into Sales_Order values(4,'12-Apr-2010','Chamari','C004','Piliyandala')
insert into Sales_Order values(5,'12-May-2010','Nimal','C005','Moratuwa')
insert into Sales_Order values(6,'12-Jun-2010','Hiran','C005','Katubedda')
insert into Sales_Order values(7,'12-Jul-2010','Tharindu','C007','Kelaniya')
insert into Sales_Order values(8,'12-Aug-2010','Nishadi','C005','Katubedda')
insert into Sales_Order values(9,'12-Aug-2010','Chamari','C008','Colombo')
insert into Sales_Order values(10,'12-Aug-2010','Sunil','C009','Colombo')
insert into Sales_Order values(11,'12-Aug-2010','Sunil','C009','Colombo')
insert into Sales_Order_Details values(1,'p0001',10)
insert into Sales_Order_Details values(2,'p0002',20)
insert into Sales_Order_Details values(3,'p0004',30)
insert into Sales_Order_Details values(4,'p0003',40)
insert into Sales_Order_Details values(5,'p0006',50)
insert into Sales_Order_Details values(6,'p0005',60)
insert into Sales_Order_Details values(7,'p0006',20)
insert into Sales_Order_Details values(9,'p0009',100)
insert into Items_to_Order values(1,'p0007','12-Dec-2015')
insert into Items_to_Order values(2,'p0006','12-Nov-2015')
insert into Items_to_Order values(3,'p0005','12-Oct-2015')
insert into Items_to_Order values(4,'p0004','12-Sep-2015')


-- Q1 Prepare a list of sales orders placed by the client C005
CREATE VIEW view_1
as
SELECT *
FROM Sales_Order
WHERE ClientNo='C005'

-- Q2 Print the description and total quantity sold from each product
CREATE VIEW view_2
as
SELECT p.description1,sum(sod.Quantity) as totalQty
FROM product p,Sales_Order_Details sod 
where p.productNo=sod.Product_No
group by description1

select * from view_4

-- Q3 Find the names of sales persons who have sold HardDisk I TB
CREATE VIEW view_3
as
select so.Order_Taken_By
from product p,Sales_Order so,Sales_Order_Details sod
where p.productNo=sod.Product_No and so.Sales_Order_No=sod.Sales_Order_No and p.description1='HardDisk 1 TB'

-- Q4 Display the sales order no and the day the customer placed their order
CREATE VIEW view_4
as
select Sales_Order_No,DATENAME(DW,Sales_Order_Date) Day
from Sales_Order

-- Q5 Display the orders to be delivered in a given day 
CREATE VIEW view_5
as
select Sales_Order_No,DATENAME(DW,Sales_Order_Date) Day
from Sales_Order
where DATENAME(DW,Sales_Order_Date)='friday'

-- Q6  Find the bill value of a given Sales_Order
alter VIEW view_6
AS
select so.Sales_Order_No,(sod.Quantity*p.selling_price) as bill_VAL
from product p,Sales_Order so,Sales_Order_Details sod
where p.productNo=sod.Product_No and so.Sales_Order_No=sod.Sales_Order_No

-- Q7
CREATE VIEW view_7
AS
SELECT * FROM Sales_order WHERE ClientNo IN
(SELECT ClientNo FROM client WHERE Date_Joined='2016-05-20')


UPDATE view_7 SET Delivery_Address = '58, Main Road, Colombo 8' WHERE
Delivery_Address LIKE '%Colombo%'

select * from Sales_Order
select * from view_8

-- Q8
CREATE VIEW view_8
AS
SELECT product.ProductNo, product.Selling_Price,product.Selling_Price*
Sales_Order_Details.Quantity as Billvalue FROM
Sales_Order_Details, product
WHERE Sales_Order_Details.Product_No = Product.ProductNo AND Selling_Price* Quantity >1000

UPDATE view_8 SET Selling_Price = 25 WHERE Selling_Price = 40

UPDATE view_8 SET Selling_Price = 30 WHERE productNo = 'p0002'


-- Q9
CREATE VIEW view_9
AS
SELECT * FROM Product WHERE Profit_Margin>10

UPDATE view_9 SET Qty_Available = 1500 WHERE Profit_Margin >50;

select * from view_9

-- Q10
create view Sales_Details
as
SELECT so.Sales_Order_No,so.ClientNo,sod.Product_No,sod.Quantity
from Sales_Order so, Sales_Order_Details sod
WHERE so.Sales_Order_No=sod.Sales_Order_No

insert into Sales_Details (Sales_Order_No,ClientNo) VALUES(12,'C008')
INSERT into Sales_Details (Sales_Order_No,ClientNo,Product_No,Quantity) VALUES(14,'C007','p0006',20)

select * from Sales_Details
select * from Sales_Order


-- Q11
create view view_test
as
select *
from Sales_Order
where Order_Taken_By='Sunil'

select * from view_test
select * from Sales_Order

update view_test set Order_Taken_By='Kamal'
where sales_order_No='10'
