CREATE DATABASE Tutorial_07
USE Tutorial_07

CREATE TABLE Customer(
ID INTEGER PRIMARY KEY,
name CHAR(64), addr
CHAR(256), DOB CHAR(10),
phone CHAR(30), username
CHAR(16)UNIQUE, password
CHAR(32));
CREATE TABLE Account (
AccNo INTEGER PRIMARY KEY,
CustomerID INTEGER FOREIGN KEY REFERENCES Customer(ID),
DateOpened datetime,
Balance money CHECK (Balance>=0));
GO
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password) VALUES
(60201, 'Jason L. Gray', '2087 Timberbrook Lane, Gypsum, CO 81637',
'09/09/1958', '970-273-9237', 'jlgray', 'password1');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password) VALUES
(89682, 'Mary L. Prieto', '1465 Marion Drive, Tampa, FL 33602',
'11/20/1961', '813-487-4873', 'mlprieto', 'password2');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(64937, 'Roger Hurst', '974 Bingamon Branch Rd, Bensenville, IL
60106','08/22/1973', '847-221-4986', 'rhurst', 'password3');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(31430, 'Warren V. Woodson', '3022 Lords Way, Parsons, TN
38363','03/07/1945', '731-845-0077', 'wvwoodson', 'password4');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(79916, 'Steven Jensen', '93 Sunny Glen Ln, Garfield Heights, OH
44125','12/14/1968', '216-789-6442', 'sjensen', 'password5');
GO
INSERT INTO Account VALUES ( 100, 31430, '12/04/2012', 10000);
INSERT INTO Account VALUES ( 101, 79916, '06/09/2012', 25000);
INSERT INTO Account VALUES ( 102, 64937, '12/04/2012', 14000);
INSERT INTO Account VALUES ( 103, 60201, '12/04/2012', 36000);
INSERT INTO Account VALUES ( 104, 89682, '12/04/2012', 28000); 


select * from Customer
select * from Account


-- First
BEGIN TRANSACTION
UPDATE Account set Balance=Balance+10000 where AccNo=101
UPDATE Account set Balance=Balance-10000 where AccNo=100

if @@ERROR !=0
	BEGIN
		print 'Error'
		ROLLBACK TRANSACTION
	END
ELSE
	BEGIN
		COMMIT TRANSACTION
	END



-- Second
BEGIN TRANSACTION
UPDATE Account set Balance=Balance-10000 where AccNo=100
if @@ERROR !=0 goto MyErrorHandler
	
UPDATE Account set Balance=Balance+10000 where AccNo=101
if @@ERROR !=0 goto MyErrorHandler

COMMIT TRANSACTION
RETURN;

MyErrorHandler:
print 'Error'
ROLLBACK TRANSACTION



-- Third
BEGIN TRANSACTION
UPDATE Account set Balance=Balance+10000 where AccNo=101
if @@ROWCOUNT =0 goto MyErrorHandler
	
UPDATE Account set Balance=Balance-10000 where AccNo=100
if @@ROWCOUNT =0 goto MyErrorHandler

COMMIT TRANSACTION
RETURN;

MyErrorHandler:
print 'Error'
ROLLBACK TRANSACTION

-- transaction through the stored procedure

go

CREATE PROCEDURE TransferMoney
@Acc01 int,
@Acc02 int,
@amount money
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Account set Balance=Balance+@amount where AccNo=@Acc02
	if @@ROWCOUNT =0 goto MyErrorHandler
	
	UPDATE Account set Balance=Balance-@amount where AccNo=@Acc01
	if @@ROWCOUNT =0 goto MyErrorHandler

	COMMIT TRANSACTION
	RETURN;

	MyErrorHandler:
	print 'Error'
	ROLLBACK TRANSACTION
END

exec TransferMoney 101,100,20000

select * from Account