CREATE DATABASE Tutorial_04
USE Tutorial_04

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


select * from product
select * from Items_to_Order

GO

-- Q1 Write an Update trigger for the Products table to insert a record to the
-- Items_to_Order table if the Quantity available of a given product falls below the reorder level

CREATE TRIGGER Trigger_1
on product
after UPDATE
AS
BEGIN
	DECLARE @qtyAvl int
	DECLARE @rol int
	DECLARE @pno varchar(6)
	select @qtyAvl=qty_available,@rol=re_order_level,@pno=productNo from inserted
	if @qtyAvl<@rol
		DECLARE @maxNoteNo int
		select @maxNoteNo=max(NoticeNo) from Items_to_Order
		set @maxNoteNo=@maxNoteNo+1
		insert into Items_to_Order values(@maxNoteNo,@pno,GETDATE())

END

go

select * from product
select * from Sales_Order_Details

go

-- Q2 Write an Insert trigger to Sales_Order _Detail to update the Product table according
-- to the products and the quantities ordered in a given sale. (Eg. If sales order detail
-- table gets a new record for 25 items of product P0001, the Qty_Available in the
-- product table should be updated accordingly

CREATE TRIGGER Trigger_2
on Sales_Order_Details
after INSERT
AS
BEGIN
	DECLARE @qty int
	DECLARE @pno varchar(6)
	select @qty=Quantity,@pno=Product_No from inserted
	update product set qty_available=qty_available-@qty where productNo=@pno
END