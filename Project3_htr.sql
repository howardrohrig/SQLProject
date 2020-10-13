spool Project3_htr.txt
SET echo ON

--Howard Rohrig
--Project 3

COLUMN FeeCode FORMAT A8
COLUMN RentalDate FORMAT A12
COLUMN GenreID FORMAT A8
COLUMN RatingID FORMAT A10
COLUMN FormatCode FORMAT A12
COLUMN CustPhone FORMAT A15

SET LINESIZE 100
SET PAGESIZE 100

--1
INSERT INTO Fee_htr VALUES('C',2.50);

--2
UPDATE RentalDetail_htr
	SET FeeCode = 'A'
	WHERE DiskID = 191 AND RentalID = 1;

COMMIT;

--3
UPDATE RentalDetail_htr
	SET FeeCode = 'C'
	WHERE DiskID = 421 AND RentalID = 11;

COMMIT;

--4
ALTER TABLE Rating_htr
	MODIFY RatingDesc VARCHAR(50);

UPDATE Rating_htr
	SET RatingDesc = 'May Not be Suitable for Children Under 13'
	WHERE RatingID = 'PG-13';

COMMIT;

--5
INSERT INTO Customer_htr VALUES((SELECT MAX(CustID) FROM Customer_htr)+1,
	'Mary','Jones','2145552020');

COMMIT;

--6
SELECT CustID,CustFName,CustLName FROM Customer_htr
	WHERE CustPhone is NULL
	ORDER BY CustID;
	
--7
SELECT AVG(FeeAmt) AS "AvgFee" FROM Fee_htr;

--8
SELECT COUNT(DISTINCT TitleID) AS "TitleCount" FROM Disk_htr;

--9
SELECT GenreID AS "GenreID", COUNT(TitleID) AS "TitleCount"
	FROM Title_htr
	GROUP BY GenreID;
	
--10
SELECT RD.RentalID AS "RentalID", RentalDate AS "Date", TO_CHAR(SUM(FeeAmt), '$999,999.99') AS "RentalTotal"
	FROM Rental_htr R, RentalDetail_htr RD, Fee_htr F
	WHERE RD.RentalID = R.RentalID AND RD.RentalID = 10
	GROUP BY RD.RentalID, RentalDate;
	
--11(A)
SELECT R.CustID AS "CustomerID", CustFName || ' ' || CustLName AS "CustomerName", COUNT(RentalID) AS "RentalCount"
	FROM Rental_htr R, Customer_htr C
	WHERE R.CustID = C.CustID
	GROUP BY R.CustID, CustFName, CustLName
	ORDER BY "RentalCount" DESC, R.CustID;
	
--11(B)
SELECT RentalID AS "RentalID", DiskID AS "DiskID", FeeCode AS "FeeCode"
	FROM RentalDetail_htr
	ORDER BY RentalID, DiskID;
	
--12
SELECT D.TitleID AS "TitleID", Title AS "Title", COUNT(FormatCode) AS "Formats"
	FROM Disk_htr D, Title_htr T
	WHERE D.TitleID = T.TitleID 
	GROUP BY D.TitleID, Title
	ORDER BY "Formats" DESC;
	
--13
SELECT CustID AS "Customer_ID", CustFName AS "First_Name", CustLName AS "Last_Name",
('(' || SUBSTR(CustPhone, 1,3) || ')' || SUBSTR(CustPhone, 4,3) || '-' || SUBSTR(CustPhone, 7,4)) AS "Phone"
	FROM Customer_htr
	ORDER BY CustID;
	
--14
SELECT RD.RentalID AS "RentalID", T.GenreID AS "GenreID", GenreDesc AS "Genre", D.TitleID AS "TitleID",
Title AS "Title", TO_CHAR(FeeAmt, '$999.99') AS "Fee"
	FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Genre_htr G, Fee_htr F
	WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			T.GenreID = G.GenreID AND
			(RentalID, FeeAmt) IN
			(SELECT RentalID, MIN(FeeAmt)
				FROM RentalDetail_htr RD, Fee_htr F
				WHERE RD.FeeCode = F.FeeCode
				GROUP BY RentalID)
	ORDER BY "Fee" DESC;

--15
	SELECT GenreDesc AS "Genre", Title AS "Title", R.RatingID AS "Rating"
		FROM Genre_htr G, Title_htr T, Rating_htr R
		WHERE T.GenreID = G.GenreID AND
			T.RatingID = R.RatingID
		ORDER BY GenreDesc, Title;
		
--16
	SELECT GenreDesc AS "GenreName", COUNT(TitleID) AS "TitleCount"
		FROM Genre_htr G, Title_htr T
		WHERE T.GenreID = G.GenreID
		GROUP BY GenreDesc
		ORDER BY "TitleCount" DESC;
		
--17
	SELECT RentalID AS "Rental_ID", RD.DiskID AS "Disk_ID", Title AS "Title", TO_CHAR(FeeAmt, '$999.99') AS "FeeAmt"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Fee_htr F
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			RD.FeeCode = F.FeeCode AND
			FeeAmt <=2.50
		ORDER BY "FeeAmt" DESC, Title;
		
--18
	SELECT RD.RentalID AS "Rental_ID", TO_CHAR(RentalDate, 'mm-dd-yyyy') AS "RentalDate", R.CustID AS "Cust_ID", CustFName AS "First Name", 
		   CustLName AS "Last Name", COUNT(DiskID) AS "Count"
		FROM RentalDetail_htr RD, Rental_htr R, Customer_htr C
		WHERE RD.RentalID = R.RentalID AND
			R.CustID = C.CustID
		GROUP BY RD.RentalID,RentalDate,R.CustID,CustFName,CustLName;
		ORDER BY RD.RentalID
		
--19
	SELECT RD.RentalID AS "Rental_ID", D.DiskID AS "DiskID", Title AS "Title", T.RatingID AS "Rating", 
		   FormatDesc AS "Format", TO_CHAR(FeeAmt, '$999.99') AS "Fee"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Format_htr F, Fee_htr FE
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND 
			D.FormatCode = F.FormatCode AND
			RD.FeeCode = FE.FeeCode AND
			RentalID = 3;
	
--20
	SELECT T.RatingID AS "Rating_ID", RatingDesc AS "Rating", COUNT(TitleID) AS "Count"
		FROM Title_htr T, Rating_htr R
		WHERE T.RatingID = R.RatingID 
		GROUP BY T.RatingID, RatingDesc;

--21
	SELECT RentalID AS "Rental_ID", RD.DiskID AS "Disk_ID", Title AS "Title", GenreDesc AS "Genre", 
		   RD.FeeCode AS "Fee_Code", FeeAmt AS "Fee"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Genre_htr G, Fee_htr F
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			T.GenreID = G.GenreID AND
			RD.FeeCode = F.FeeCode AND
			FeeAmt > (SELECT AVG(FeeAmt) FROM Fee_htr F, RentalDetail_htr RD 
						WHERE RD.FeeCode = F.FeeCode)
			ORDER BY Title;

--22
	SELECT DISTINCT(D.TitleID) AS "Title_ID", Title AS "Title", GenreDesc AS "Genre", T.RatingID AS "Rating_ID"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Genre_htr G, Rating_htr R
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			T.GenreID = G.GenreID AND
			T.RatingID = R.RatingID AND
			RD.FeeCode = 'B'
		ORDER BY Title;

--23
	SELECT RD.RentalID AS "RentalID", TO_CHAR(RentalDate, 'mm/dd/yy') AS "Date", TO_CHAR(SUM(FeeAmt), '$999.99') AS "Fee"
		FROM RentalDetail_htr RD,Rental_htr R, Fee_htr F
		WHERE RD.RentalID = R.RentalID AND
			RD.FeeCode = F.FeeCode AND
			RD.RentalID = 3
		GROUP BY RD.RentalID, RentalDate;
	
--24
	SELECT RD.DiskID AS "DiskID", D.TitleID AS "TitleID", Title AS "Title", RD.FeeCode AS "FeeCode", 
		   TO_CHAR(FeeAmt, '$999.99') AS "FeeAmt"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Fee_htr F
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			RD.FeeCode = F.FeeCode AND
			RentalID = 10 AND
			FeeAmt IN (SELECT MAX(FeeAmt) FROM Fee_htr);

--25
	SELECT RentalID AS "Rental_ID", RentalDate AS "Date", R.CustID AS "Customer_ID", CustLName AS "Customer LName",
		   R.ClerkID AS "Clerk_ID", ClerkLName AS "Clerk LName"
		FROM Rental_htr R, Customer_htr C, Clerk_htr CL
		WHERE  R.CustID = C.CustID AND
			R.ClerkID = CL.ClerkID AND 
			RentalDate < '05-SEP-2017'
		ORDER BY RentalDate, RentalID;
		
--26
	SELECT RD.DiskID AS "Disk_ID", D.TitleID AS "Title_ID", Title AS "Title", FeeAmt AS "Fee"
		FROM RentalDetail_htr RD, Disk_htr D, Title_htr T, Fee_htr F
		WHERE RD.DiskID = D.DiskID AND
			D.TitleID = T.TitleID AND
			RD.FeeCode = F.FeeCode AND
			FeeAmt > (SELECT AVG(FeeAmt) FROM Fee_htr) 
		ORDER BY FeeAmt DESC, RD.DiskID;
		
--27
	SELECT R.CustID AS "Customer_ID", CustFName || ' ' || CustLName AS "Customer_Name", TO_CHAR(SUM(FeeAmt), '$999.99') AS "FeeAmt"
		FROM RentalDetail_htr RD, Rental_htr R, Customer_htr C, Fee_htr F
		WHERE RD.RentalID = R.RentalID AND
			R.CustID = C.CustID AND
			RD.FeeCode = F.FeeCode AND
			R.CustID = 23
		GROUP BY R.CustID, CustFName, CustLName;
			
--28
	SELECT RD.RentalID AS "RentalID", TO_CHAR(RentalDate, 'mm/dd/yy') AS "Date", R.CustID AS "CustID", 
		   CustFName AS "First Name", CustLName AS "Last Name", 
		   ('(' || SUBSTR(CustPhone, 1,3) || ')' || SUBSTR(CustPhone, 4,3) || '-' || SUBSTR(CustPhone, 7,4)) AS "Phone"
		FROM RentalDetail_htr RD, Rental_htr R, Customer_htr C
		WHERE RD.RentalID = R.RentalID AND
			  R.CustID = C.CustID AND
			  RentalDate <= '04-SEP-2017'
		ORDER BY RentalDate, R.CustID;
		   
--29
	SELECT R.ClerkID AS "EmployeeID", ClerkFName AS "FirstName", ClerkLName AS "LastName", COUNT(R.ClerkID) AS "RentalCount"
		FROM Rental_htr R, Clerk_htr C
		WHERE R.ClerkID = C.ClerkID
		HAVING COUNT(R.ClerkID) > 1
		GROUP BY R.ClerkID, ClerkFName, ClerkLName
		ORDER BY "RentalCount" DESC, "EmployeeID";
	
--30 
	SELECT CustID AS "Customer_ID", CustFName AS "First_Name", CustLName AS "Last_Name"
		FROM Customer_htr F
		WHERE CustFName LIKE 'J%' OR CustLName LIKE 'J%'
		ORDER BY "Last_Name";
		
--31
	SELECT CustID AS "CustID", CustFName AS "FirstName", CustLName AS "LastName"
		FROM Customer_htr 
		WHERE CustID NOT IN (SELECT CustID FROM Rental_htr);
		
			
			
	
	
SET echo OFF
spool OFF