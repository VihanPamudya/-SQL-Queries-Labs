CREATE DATABASE Tutorial_08
USE Tutorial_08

CREATE TABLE Status ( 
code INTEGER, 
description CHAR(30), 
PRIMARY KEY (code) 
);

CREATE TABLE Media( 
media_id INTEGER, 
code INTEGER, 
PRIMARY KEY (media_id),
FOREIGN KEY (code) REFERENCES Status
);
CREATE TABLE Book(
ISBN CHAR(14), 
title CHAR(128), 
author CHAR(64),
year INTEGER, 
dewey INTEGER, 
price REAL, 
--PRIMARY KEY (ISBN) 
);
CREATE TABLE BookMedia( 
media_id INTEGER, 
ISBN CHAR(14), 
PRIMARY KEY (media_id),
FOREIGN KEY (media_id) REFERENCES Media,
--FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);
CREATE TABLE Customer( 
ID INTEGER, name CHAR(64),
addr CHAR(256), 
DOB CHAR(10),
phone CHAR(30), 
username CHAR(16), 
password CHAR(32), 
PRIMARY KEY (ID),
UNIQUE (username) 
);
CREATE TABLE Card( 
num INTEGER, 
fines REAL, 
ID INTEGER, 
PRIMARY KEY (num),
FOREIGN KEY (ID) REFERENCES Customer 
);
CREATE TABLE Checkout( 
media_id INTEGER, 
num INTEGER, 
since CHAR(10),
until CHAR(10), 
PRIMARY KEY (media_id),
FOREIGN KEY (media_id) REFERENCES Media,
FOREIGN KEY (num) REFERENCES Card 
);
CREATE TABLE Location(
name CHAR(64), 
addr CHAR(256), 
phone CHAR(30),
PRIMARY KEY (name) 
);
CREATE TABLE Hold( 
media_id INTEGER, 
num INTEGER, 
name CHAR(64), 
until CHAR(10),
queue INTEGER, 
PRIMARY KEY (media_id, num),
FOREIGN KEY (name) REFERENCES Location,
FOREIGN KEY (num) REFERENCES Card,
FOREIGN KEY (media_id) REFERENCES Media 
);
CREATE TABLE Stored_In( 
media_id INTEGER, 
name char(64), 
PRIMARY KEY (media_id),
FOREIGN KEY (media_id) REFERENCES Media ON DELETE CASCADE,
FOREIGN KEY (name) REFERENCES Location 
);
CREATE TABLE Librarian( 
eid INTEGER, 
ID INTEGER NOT NULL, 
Pay REAL,
Loc_name CHAR(64) NOT NULL, 
PRIMARY KEY (eid),
FOREIGN KEY (ID) REFERENCES Customer ON DELETE CASCADE,
FOREIGN KEY (Loc_name) REFERENCES Location(name) 
);
CREATE TABLE Video( 
title CHAR(128), 
year INTEGER, 
director CHAR(64),
rating REAL, 
price REAL, 
PRIMARY KEY (title, year) 
);
CREATE TABLE VideoMedia( 
media_id INTEGER, 
title CHAR(128), 
year INTEGER,
PRIMARY KEY (media_id),
 FOREIGN KEY (media_id) references Media(media_id)
 );


 --Populate Customer Table
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
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(93265, 'David Bain', '4356 Pooh Bear Lane, Travelers Rest, SC
29690','08/10/1947', '864-610-9558', 'dbain', 'password6');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(58359, 'Ruth P. Alber', '3842 Willow Oaks Lane, Lafayette, LA
70507','02/18/1976', '337-316-3161', 'rpalber', 'password7');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(88564, 'Sally J. Schilling', '1894 Wines Lane, Houston, TX
77002','07/02/1954', '832-366-9035', 'sjschilling', 'password8');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(57054, 'John M. Byler', '279 Raver Croft Drive, La Follette, TN
37766','11/27/1954', '423-592-8630', 'jmbyler', 'password9');
INSERT INTO Customer(ID, name, addr, DOB, phone, username, password)
VALUES(49312, 'Kevin Spruell', '1124 Broadcast Drive, Beltsville, VA
20705','03/04/1984', '703-953-1216', 'kspruell', 'password10');

--Populate Card Table
INSERT INTO Card(num, fines, ID) VALUES ( 5767052, 0.0, 60201);
INSERT INTO Card(num, fines, ID) VALUES ( 5532681, 0.0, 60201);
INSERT INTO Card(num, fines, ID) VALUES ( 2197620, 10.0, 89682);
INSERT INTO Card(num, fines, ID) VALUES ( 9780749, 0.0, 64937);
INSERT INTO Card(num, fines, ID) VALUES ( 1521412, 0.0, 31430);
INSERT INTO Card(num, fines, ID) VALUES ( 3920486, 0.0, 79916);
INSERT INTO Card(num, fines, ID) VALUES ( 2323953, 0.0, 93265);
INSERT INTO Card(num, fines, ID) VALUES ( 4387969, 0.0, 58359);
INSERT INTO Card(num, fines, ID) VALUES ( 4444172, 0.0, 88564);
INSERT INTO Card(num, fines, ID) VALUES ( 2645634, 0.0, 57054);
INSERT INTO Card(num, fines, ID) VALUES ( 3688632, 0.0, 49312);
--Note:
--If you have already identified that the Card table only allows recording only a single fine, change
--your database to rectify the issue. Accordingly, change the insert into statements

--Populate Location Table
INSERT INTO Location(name, addr, phone) VALUES ('Texas Branch',
'4832 Deercove Drive, Dallas, TX 75208', '214-948-7102');
INSERT INTO Location(name, addr, phone) VALUES ('Illinois Branch',
'2888 Oak Avenue, Des Plaines, IL 60016', '847-953-8130');
INSERT INTO Location(name, addr, phone) VALUES ('Louisiana Branch',
'2063 Washburn Street, Baton Rouge, LA 70802', '225-346-0068');

--Populate Status Table
INSERT INTO Status(code, description) VALUES (1, 'Available');
INSERT INTO Status(code, description) VALUES (2, 'In Transit');
INSERT INTO Status(code, description) VALUES (3, 'Checked Out');
INSERT INTO Status(code, description) VALUES (4, 'On Hold');

--Populate Media Table
INSERT INTO Media( media_id, code) VALUES (8733, 1);
INSERT INTO Media( media_id, code) VALUES (9982, 1);
INSERT INTO Media( media_id, code) VALUES (3725, 1);
INSERT INTO Media( media_id, code) VALUES (2150, 1);
INSERT INTO Media( media_id, code) VALUES (4188, 1);
INSERT INTO Media( media_id, code) VALUES (5271, 2);
INSERT INTO Media( media_id, code) VALUES (2220, 3);
INSERT INTO Media( media_id, code) VALUES (7757, 1);
INSERT INTO Media( media_id, code) VALUES (4589, 1);
INSERT INTO Media( media_id, code) VALUES (5748, 1);
INSERT INTO Media( media_id, code) VALUES (1734, 1);
INSERT INTO Media( media_id, code) VALUES (5725, 1);
INSERT INTO Media( media_id, code) VALUES (1716, 4);
INSERT INTO Media( media_id, code) VALUES (8388, 1);
INSERT INTO Media( media_id, code) VALUES (8714, 1);

--Populate Book Table
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0743289412', 'Lisey''s Story', 'Stephen King', 2006, 813, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-1596912366', 'Restless: A Novel', 'William Boyd', 2006, 813, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0312351588', 'Beachglass', 'Wendy Blackburn', 2006, 813, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0156031561', 'The Places In Between', 'Rory Stewart', 2006, 910, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0060583002', 'The Last Season', 'Eric Blehm', 2006, 902, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0316740401', 'Case Histories: A Novel', 'Kate Atkinson', 2006, 813,
10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0316013949', 'Step on a Crack', 'James Patterson, et al.', 2007, 813,
10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0374105235', 'Long Way Gone: Memoirs of a Boy Soldier', 'Ishmael Beah',
2007, 916, 10.0);
INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('978-0385340229', 'Sisters', 'Danielle Steel', 2006, 813, 10.0);

--Populate BookMedia Table
INSERT INTO BookMedia(media_id, ISBN) VALUES (8733, '978-0743289412');
INSERT INTO BookMedia(media_id, ISBN) VALUES (9982, '978-1596912366');
INSERT INTO BookMedia(media_id, ISBN) VALUES (3725, '978-1596912366');
INSERT INTO BookMedia(media_id, ISBN) VALUES (2150, '978-0312351588');
INSERT INTO BookMedia(media_id, ISBN) VALUES (4188, '978-0156031561');
INSERT INTO BookMedia(media_id, ISBN) VALUES (5271, '978-0060583002');
INSERT INTO BookMedia(media_id, ISBN) VALUES (2220, '978-0316740401');
INSERT INTO BookMedia(media_id, ISBN) VALUES (7757, '978-0316013949');
INSERT INTO BookMedia(media_id, ISBN) VALUES (4589, '978-0374105235');
INSERT INTO BookMedia(media_id, ISBN) VALUES (5748, '978-0385340229');

--Populate Checkout Table
INSERT INTO Checkout(media_id, num, since, until) VALUES
(2220, 9780749, '02/15/2007', '03/15/2007');

--Populate Video Table
INSERT INTO Video(title, year, director, rating, price) VALUES
('Terminator 2: Judgment Day', 1991, 'James Cameron', 8.3, 20.0);
INSERT INTO Video(title, year, director, rating, price) VALUES
('Raiders of the Lost Ark', 1981, 'Steven Spielberg', 8.7, 20.0);
INSERT INTO Video(title, year, director, rating, price) VALUES
('Aliens', 1986, 'James Cameron', 8.3, 20.0);
INSERT INTO Video(title, year, director, rating, price) VALUES
('Die Hard', 1988, 'John McTiernan', 8.0, 20.0);

--Populate VideoMedia Table
INSERT INTO VideoMedia(media_id, title, year) VALUES
( 1734, 'Terminator 2: Judgment Day', 1991);
INSERT INTO VideoMedia(media_id, title, year) VALUES
( 5725, 'Raiders of the Lost Ark', 1981);
INSERT INTO VideoMedia(media_id, title, year) VALUES
( 1716, 'Aliens', 1986);
INSERT INTO VideoMedia(media_id, title, year) VALUES
( 8388, 'Aliens', 1986);
INSERT INTO VideoMedia(media_id, title, year) VALUES
( 8714, 'Die Hard', 1988);

--Populate Hold Table
INSERT INTO Hold(media_id, num, name, until, queue) VALUES
(1716, 4444172, 'Texas Branch', '02/20/2008', 1);

--Populate Librarian Table
INSERT INTO Librarian(eid, ID, pay, Loc_name) Values
(2591051, 88564, 30000.00, 'Texas Branch');
INSERT INTO Librarian(eid, ID, pay, Loc_name) Values
(6190164, 64937, 30000.00, 'Illinois Branch');
INSERT INTO Librarian(eid, ID, pay, Loc_name) Values
(1810386, 58359, 30000.00, 'Louisiana Branch');

--Populate Stored_In Table
INSERT INTO Stored_In(media_id, name) VALUES(8733, 'Texas Branch');
INSERT INTO Stored_In(media_id, name) VALUES(9982, 'Texas Branch');
INSERT INTO Stored_In(media_id, name) VALUES(1716, 'Texas Branch');
INSERT INTO Stored_In(media_id, name) VALUES(1734, 'Texas Branch');
INSERT INTO Stored_In(media_id, name) VALUES(4589, 'Texas Branch');
INSERT INTO Stored_In(media_id, name) VALUES(4188, 'Illinois Branch');
INSERT INTO Stored_In(media_id, name) VALUES(5271, 'Illinois Branch');
INSERT INTO Stored_In(media_id, name) VALUES(3725, 'Illinois Branch');
INSERT INTO Stored_In(media_id, name) VALUES(8388, 'Illinois Branch');
INSERT INTO Stored_In(media_id, name) VALUES(5748, 'Illinois Branch');
INSERT INTO Stored_In(media_id, name) VALUES(2150, 'Louisiana Branch');
INSERT INTO Stored_In(media_id, name) VALUES(8714, 'Louisiana Branch');
INSERT INTO Stored_In(media_id, name) VALUES(7757, 'Louisiana Branch');
INSERT INTO Stored_In(media_id, name) VALUES(5725, 'Louisiana Branch');

--CREATE CLUSTERED INDEX 
CREATE CLUSTERED INDEX idx_ISBN ON Book(ISBN)

SELECT *
FROM Book
WHERE ISBN ='978-0312351588'

--CREATE NONCLUSTERED INDEX
CREATE NONCLUSTERED INDEX idx_Title ON Book(Title) 

--Delete the index
DROP INDEX idx_Title ON Book

--Can see the all index in system
SELECT * FROM sys.indexes
WHERE object_id = (select object_id from sys.objects where name = 'Book')

exec sp_helpindex Book

--Create index for multiple column
CREATE nonclustered index nyIndex01 ON Book (
	year asc,
	price asc
)

--Create unique index
CREATE UNIQUE nonclustered INDEX myUnitIndex ON Book (
	title
)

INSERT INTO Book(ISBN, title, author, year, dewey, price) VALUES
('111', 'Sisters', 'Danielle Steel', 2006, 813, 10.0);


CREATE DATABASE TestIndexDB
USE TestIndexDB
GO


CREATE TABLE Booking
(
ID INT IDENTITY(1,1), -- IDENTITY(1,1) : start from 1 and then increment by 1
FlightCode VARCHAR(20),
Price FLOAT(53),
DateTransaction DATETIME
);


select * from Booking

CREATE PROCEDURE InsertBookings
AS
SET NOCOUNT ON --try to count. therefore it take additional time. 
BEGIN
	DECLARE @FC VARCHAR(20)='EK232'
	DECLARE @Price INT = 50
	DECLARE @COUNT INT = 0
	WHILE @COUNT<200000
	BEGIN
		SET @FC=@FC+CAST(@COUNT AS VARCHAR(20))
		SET @Price=@Price+@COUNT
		INSERT INTO Booking VALUES (@FC,@Price,GETDATE())
		SET @FC='EK232'
		SET @Price=50
		SET @COUNT+=1
	END
END

EXEC InsertBookings

