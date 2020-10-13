spool project2_htr.txt
SET echo ON

--Howard Rohrig 
--INSY 3304 - 02
--Project 2

--PART 1 Drop, Create and Describe Tables
--Drop table if it exists 


DROP TABLE RentalDetail_htr ;
DROP TABLE Rental_htr ;
DROP TABLE Customer_htr ;
DROP TABLE Clerk_htr ;
DROP TABLE Disk_htr ;
DROP TABLE Format_htr ;
DROP TABLE Title_htr ;
DROP TABLE Rating_htr ;
DROP TABLE Genre_htr ;
DROP TABLE Fee_htr ;

COMMIT;

CREATE TABLE Clerk_htr(
	ClerkID		NUMBER(3,0) not null,
	ClerkFName	VARCHAR(20) not null, 
	ClerkLName	VARCHAR(20) not null, 
	PRIMARY KEY(ClerkID) 
	);
	
CREATE TABLE Customer_htr(
	CustID		NUMBER(4,0) not null,
	CustFName	VARCHAR(20) not null,
	CustLName	VARCHAR(20) not null,
	CustPhone	CHAR(10),  
	PRIMARY KEY(CustID)
	);
	
CREATE TABLE Rental_htr(
	RentalID	NUMBER(5,0) not null,
	RentalDate	DATE not null, 
	CustID		NUMBER(4,0) not null,
	ClerkID		NUMBER(3,0) not null,
	PRIMARY KEY(RentalID),
	FOREIGN KEY(CustID)
			REFERENCES Customer_htr(CustID),
	FOREIGN KEY(ClerkID)
			REFERENCES Clerk_htr(ClerkID)
	);

CREATE TABLE Fee_htr(
	FeeCode	CHAR(1),
	FeeAmt	NUMBER(3,2), 
	PRIMARY KEY(FeeCode)
	);
	
CREATE TABLE Genre_htr(
	GenreID		VARCHAR(2) not null,
	GenreDesc	VARCHAR(15) not null, 
	PRIMARY KEY(GenreID)
	);

CREATE TABLE Rating_htr(
	RatingID	VARCHAR(6) not null,
	RatingDesc	VARCHAR(30) not null,
	PRIMARY KEY(RatingID)
	);
	
CREATE TABLE Title_htr(
	TitleID	NUMBER(4,0) not null,
	Title	VARCHAR(40) not null,
	RatingID	VARCHAR(6) not null,
	GenreID	VARCHAR(2) not null,
	PRIMARY KEY(TitleID),
	FOREIGN KEY(RatingID)
			REFERENCES Rating_htr(RatingID),
	FOREIGN KEY(GenreID)
			REFERENCES Genre_htr(GenreID)
	);
			
CREATE TABLE Format_htr(
	FormatCode	CHAR(1) not null,
	FormatDesc	VARCHAR(10) not null,
	PRIMARY KEY(FormatCode)
	);
		
CREATE TABLE Disk_htr(
	DiskID		NUMBER(4,0) not null,
	TitleID		NUMBER(4,0) not null,
	FormatCode	CHAR(1) not null,
	PRIMARY KEY(DiskID),
	FOREIGN KEY(TitleID)
			REFERENCES Title_htr(TitleID),
	FOREIGN KEY(FormatCode)
			REFERENCES Format_htr(FormatCode)
	);
	
CREATE TABLE RentalDetail_htr(
	RentalID	NUMBER(5,0) not null,
	DiskID	NUMBER(4,0) not null,
	FeeCode	CHAR(1) not null,
	CONSTRAINT RentalDetailPK 
			PRIMARY KEY(DiskID,RentalID),
	FOREIGN KEY(FeeCode)
			REFERENCES	Fee_htr(FeeCode)
	);
	
COMMIT;

DESCRIBE	Clerk_htr ;
DESCRIBE	Customer_htr ;
DESCRIBE	Rental_htr ;
DESCRIBE	Fee_htr ;
DESCRIBE	Genre_htr ;
DESCRIBE	Rating_htr ;
DESCRIBE	Title_htr ;
DESCRIBE	Format_htr ;
DESCRIBE	Disk_htr ;
DESCRIBE	RentalDetail_htr ;

COMMIT;

--Part 2 Inserting data and using Select

INSERT INTO Clerk_htr VALUES (15,'Mary','Jones');
INSERT INTO Clerk_htr VALUES (21,'Mark','White');
INSERT INTO Clerk_htr VALUES (30,'Renee','Smith');
INSERT INTO Clerk_htr VALUES (12,'Tim','Shore');
INSERT INTO Clerk_htr VALUES (42,'Nicole','Walker');

INSERT INTO Customer_htr VALUES (23,'Jean','Mackey','9725551143');
INSERT INTO Customer_htr VALUES (102,'Jack','Hughes','2145552014');
INSERT INTO Customer_htr VALUES (154,'Alicia','Moore','8175551919');
INSERT INTO Customer_htr VALUES (83,'Carrie','Brown',Null);
INSERT INTO Customer_htr VALUES (53,'Ashleigh','Hayes','9725550628');
INSERT INTO Customer_htr VALUES (72,'Shane','Wesley','8175550112');
INSERT INTO Customer_htr VALUES (68,'Anthony','Smith',Null);

INSERT INTO Rental_htr VALUES (1,'02-SEP-2017',23,15);
INSERT INTO Rental_htr VALUES (2,'02-SEP-2017',102,15);
INSERT INTO Rental_htr VALUES (3,'02-SEP-2017',154,21);
INSERT INTO Rental_htr VALUES (4,'03-SEP-2017',83,30);
INSERT INTO Rental_htr VALUES (5,'03-SEP-2017',23,15);
INSERT INTO Rental_htr VALUES (6,'04-SEP-2017',83,12);
INSERT INTO Rental_htr VALUES (7,'04-SEP-2017',154,15);
INSERT INTO Rental_htr VALUES (8,'05-SEP-2017',53,12);
INSERT INTO Rental_htr VALUES (9,'05-SEP-2017',68,15);
INSERT INTO Rental_htr VALUES (10,'05-SEP-2017',23,21);
INSERT INTO Rental_htr VALUES (11,'05-SEP-2017',72,42);

INSERT INTO Fee_htr VALUES ('A',3);
INSERT INTO Fee_htr VALUES ('B',2);

INSERT INTO Genre_htr VALUES ('AC','Action');
INSERT INTO Genre_htr VALUES ('CL','Classics');
INSERT INTO Genre_htr VALUES ('FM','Family');
INSERT INTO Genre_htr VALUES ('HR','Horror');

INSERT INTO Rating_htr VALUES ('R','Restricted Under 17');
INSERT INTO Rating_htr VALUES ('PG-13','Inappropriate Under 13');
INSERT INTO Rating_htr VALUES ('PG','Parental Guidance');

INSERT INTO Title_htr VALUES (12,'Casa Blanca','PG','CL');
INSERT INTO Title_htr VALUES (29,'Despicable Me 2','PG','FM');
INSERT INTO Title_htr VALUES (35,'Minions','PG','FM');
INSERT INTO Title_htr VALUES (42,'Frozen','PG','FM');
INSERT INTO Title_htr VALUES (58,'The Specialist','R','AC');
INSERT INTO Title_htr VALUES (76,'Avengers: Infinity War','PG-13','AC');
INSERT INTO Title_htr VALUES (92,'Hacksaw Ridge','R','AC');
INSERT INTO Title_htr VALUES (119,'Insurgent','PG-13','AC');
INSERT INTO Title_htr VALUES (159,'Boss Baby','PG','FM');
INSERT INTO Title_htr VALUES (218,'Gone With The Wind','PG','CL');
INSERT INTO Title_htr VALUES (230,'Lone Survivor','R','AC');
INSERT INTO Title_htr VALUES (240,'It','R','HR');
INSERT INTO Title_htr VALUES (245,'Moana','PG','FM');
INSERT INTO Title_htr VALUES (296,'The Hurt Locker','R','AC');

INSERT INTO Format_htr VALUES ('D','DVD');
INSERT INTO Format_htr VALUES ('B','BLU-RAY');

INSERT INTO Disk_htr VALUES (86,58,'B');
INSERT INTO Disk_htr VALUES (89,12,'D');
INSERT INTO Disk_htr VALUES (96,29,'D');
INSERT INTO Disk_htr VALUES (97,29,'D');
INSERT INTO Disk_htr VALUES (152,42,'D');
INSERT INTO Disk_htr VALUES (153,42,'D');
INSERT INTO Disk_htr VALUES (191,76,'D');
INSERT INTO Disk_htr VALUES (202,159,'D');
INSERT INTO Disk_htr VALUES (203,159,'D');
INSERT INTO Disk_htr VALUES (215,92,'D');
INSERT INTO Disk_htr VALUES (216,92,'B');
INSERT INTO Disk_htr VALUES (259,119,'B');
INSERT INTO Disk_htr VALUES (260,119,'D');
INSERT INTO Disk_htr VALUES (299,35,'D');
INSERT INTO Disk_htr VALUES (301,230,'B');
INSERT INTO Disk_htr VALUES (376,245,'B');
INSERT INTO Disk_htr VALUES (381,218,'D');
INSERT INTO Disk_htr VALUES (402,240,'B');
INSERT INTO Disk_htr VALUES (421,296,'D');

INSERT INTO RentalDetail_htr VALUES (1,191,'B');
INSERT INTO RentalDetail_htr VALUES (1,215,'A'); 
INSERT INTO RentalDetail_htr VALUES (2,259,'A');
INSERT INTO RentalDetail_htr VALUES (3,89,'B');
INSERT INTO RentalDetail_htr VALUES (3,96,'B');
INSERT INTO RentalDetail_htr VALUES (3,152,'B');
INSERT INTO RentalDetail_htr VALUES (4,86,'A');
INSERT INTO RentalDetail_htr VALUES (5,260,'A');
INSERT INTO RentalDetail_htr VALUES (6,301,'A');
INSERT INTO RentalDetail_htr VALUES (7,153,'B');
INSERT INTO RentalDetail_htr VALUES (7,376,'A');
INSERT INTO RentalDetail_htr VALUES (8,202,'B');
INSERT INTO RentalDetail_htr VALUES (8,402,'A');
INSERT INTO RentalDetail_htr VALUES (9,216,'A');
INSERT INTO RentalDetail_htr VALUES (9,381,'A');
INSERT INTO RentalDetail_htr VALUES (10,97,'A');
INSERT INTO RentalDetail_htr VALUES (10,203,'B');
INSERT INTO RentalDetail_htr VALUES (11,299,'A');
INSERT INTO RentalDetail_htr VALUES (11,376,'B');
INSERT INTO RentalDetail_htr VALUES (11,421,'A');

COMMIT;

SELECT * FROM Clerk_htr
	ORDER BY ClerkID;
SELECT * FROM Customer_htr
	ORDER BY CustID;
SELECT * FROM Rental_htr
	ORDER BY RentalID;
SELECT * FROM Fee_htr;
SELECT * FROM Genre_htr;
SELECT * FROM Rating_htr;
SELECT * FROM Title_htr
	ORDER BY TitleID;
SELECT * FROM Format_htr;
SELECT * FROM Disk_htr
	ORDER BY DiskID;
SELECT * FROM RentalDetail_htr
	ORDER BY RentalID;

COMMIT;

--PART 3 Modify data in the table

UPDATE Customer_htr
SET CustFName = 'Kerry'
WHERE CustID = 83;
 
UPDATE Customer_htr
SET CustPhone = '2146881234'
WHERE CustID = 23;
 
INSERT INTO Customer_htr VALUES (100,'Amanda','Green',Null);
 
INSERT INTO Genre_htr VALUES ('DR','Drama');
INSERT INTO Title_htr VALUES (279,'Hidalgo', 'PG-13','DR');
 
INSERT INTO Disk_htr VALUES (327,92,'D');
INSERT INTO Disk_htr VALUES (382,119,'B');
INSERT INTO Disk_htr VALUES (406,29,'D');

UPDATE RentalDetail_htr 
SET FeeCode = 'B'
WHERE RentalID = 1 AND DiskID = 215;

INSERT INTO RentalDetail_htr VALUES (12,376,'A');
INSERT INTO RentalDetail_htr VALUES (12,406,'B');

INSERT INTO RentalDetail_htr VALUES (13,382,'A');
INSERT INTO RentalDetail_htr VALUES (13,215,'B');
INSERT INTO RentalDetail_htr VALUES (13,327,'A');

INSERT INTO Rating_htr VALUES ('NR','Not Rated');

COMMIT;

--PART 4 Execute select statement 

SELECT * FROM Clerk_htr
	ORDER BY ClerkID;
SELECT * FROM Customer_htr
	ORDER BY CustID;
SELECT * FROM Rental_htr
	ORDER BY RentalID;
SELECT * FROM Fee_htr;
SELECT * FROM Genre_htr;
SELECT * FROM Rating_htr;
SELECT * FROM Title_htr
	ORDER BY TitleID;
SELECT * FROM Format_htr;
SELECT * FROM Disk_htr
	ORDER BY DiskID;
SELECT * FROM RentalDetail_htr
	ORDER BY RentalID;
	
COMMIT;

SET echo OFF
spool OFF