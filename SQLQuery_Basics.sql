------------------------------------------------------------
-- Day 1 
------------------------------------------------------------

create database Leanna_2016;
alter database Leanna_2016 modify name=Meloryna_2018;

drop database Meloryna_2018;

create database Meloryna;

create table tblGender (ID int NOT Null primary key, Gender NVARCHAR(50));

INSERT INTO tblGender VALUES (001, 'Female'),
							 (002, 'Female'),
							 (003, 'Female'),
							 (004, 'Male');
				
SELECT * FROM tblGender;

ALTER TABLE tblGender ADD G_Code TINYINT;

UPDATE tblGender SET G_Code=2 WHERE ID=001;
UPDATE tblGender SET G_Code=2 WHERE ID IN (002, 003);
UPDATE tblGender SET G_Code=1 WHERE ID LIKE '4';

CREATE TABLE tblPerson (ID int NOT Null primary key, Name NVARCHAR(50), Last_Name NVARCHAR(50));
ALTER TABLE tblPerson ADD Email VARCHAR(100);
ALTER TABLE tblPerson ADD Phone CHAR(10);

DROP TABLE tblPerson;

INSERT INTO tblPerson VALUES (001, 'Kati', 'Mehr','kati_mehr@yahoo.com', '6478308228');
INSERT INTO tblPerson VALUES (002, 'Rayan', 'Massah', '', '');
INSERT INTO tblPerson VALUES (003, 'Leanna', 'Massah', '', '');
INSERT INTO tblPerson VALUES (004, 'Meloryna', 'Massah', 'rayan.massag@gmail.com', '6478718283');

SELECT * FROM tblPerson;

SELECT Email FROM tblPerson;


SELECT * FROM tblPerson WHERE ID=1;
	

SELECT * FROM tblPerson WHERE Name='Kati';

SELECT Gender FROM tblGender;


CREATE TABLE Price (Item varchar(20) NOT NULL, Wholesale float, QTY int);
DROP TABLE Price;

INSERT INTO Price VALUES ('Apple', 2.2, 6780);
INSERT INTO Price VALUES ('Orange', 1.3, 2000);
INSERT INTO Price VALUES ('Grape', 3.3, 5643);
INSERT INTO Price VALUES ('Banana', 1.1, 2000);
INSERT INTO Price VALUES ('Watermelon', 5.1, 5000);
INSERT INTO Price VALUES ('Potato', 1.9, 60987);
INSERT INTO Price VALUES ('Pomegrenade', 4.1, 150);
INSERT INTO Price VALUES ('Tangerine', 1.3, 56432);
INSERT INTO Price VALUES ('Tomato', 1.9, 7000);
INSERT INTO Price VALUES ('Peach', 3.7, 1000);

SELECT * FROM Price;

SELECT Item, wholesale, wholesale+0.5 AS 'added0.5' FROM Price;

SELECT *, wholesale*100 AS multiply100 FROM Price;

SELECT item as sales_item, sum(wholesale) as sum_sale FROM Price 
		GROUP BY item
		ORDER BY sum_sale;

INSERT INTO Price VALUES ('Apple', 2.2, 2000);
INSERT INTO Price VALUES ('Orange', 1.3, 2000);

SELECT item, sum(QTY) as sum_QTY FROM Price 
		GROUP BY item
		ORDER BY sum_QTY;

SELECT *, -wholesale AS negsale FROM Price;




-- Insert values from another table

CREATE TABLE sales (item varchar(50), sales_price float);

DROP TABLE sales;

SELECT * FROM Sales;

SELECT *, QTY/100 AS Reminder FROM Price;

SELECT * FROM Price 
		WHERE QTY >=3000;

SELECT * FROM Price WHERE item > 'BZ'
		ORDER BY item;


SELECT * FROM Price;

DELETE FROM Price
	WHERE item='Banana' OR item='Grape' OR item='Apple' OR item='Potato' OR item='Tomato';

DELETE FROM Price
	WHERE item='Pomegrenade' OR item='Tangerine';

DELETE FROM Price
	WHERE item='Tangerine';


------------------------------------------------------------
-- Day 2 
------------------------------------------------------------

SELECT * FROM Price
	WHERE item LIKE '%PP%';

SELECT * FROM Price
	WHERE item LIKE 'P%';

SELECT * FROM Price
	WHERE item LIKE '%E';

SELECT * FROM Price WHERE item LIKE 'A____';
SELECT * FROM Price WHERE item LIKE '%P%';
SELECT * FROM Price WHERE item LIKE 'P%';

INSERT INTO sales 
	SELECT * FROM Price;

SELECT  Max(QTY) AS Maximum FROM Price;

SELECT * FROM Price WHERE Wholesale IS NOT NULL;

SELECT * FROM Price WHERE item IN ('Apple', 'Potato');

SELECT * FROM Price WHERE QTY IN (1000, 7000);

SELECT * FROM Price WHERE Wholesale BETWEEN 1 AND 4;

SELECT COUNT(Item) AS Total FROM Price;
SELECT COUNT(DISTINCT Item) AS Total FROM Price;

SELECT SUM(QTY) AS Total, AVG(QTY) AS Average FROM Price;

INSERT INTO Price VALUES ('Fresh Almond', 10, 1000);
SELECT * FROM Price WHERE Wholesale>=5;
SELECT SUM(QTY) AS Total FROM Price 
		WHERE Wholesale>=5;

SELECT *, QTY/Wholesale AS SSS FROM Price 
		ORDER BY  SSS DESC;

SELECT item, SUM(QTY) AS Total , AVG(Wholesale) AS Average FROM Price 
		GROUP BY item
		ORDER BY item;

SELECT item, COUNT(item) AS Qty , ROUND(AVG(Wholesale),1) AS Average FROM Price 
		GROUP BY item
		ORDER BY item;

SELECT item, COUNT(Wholesale) AS Qty FROM Price 
		GROUP BY item
		ORDER BY item;

SELECT item, COUNT(DISTINCT Wholesale) AS Qty FROM Price 
		GROUP BY item
		ORDER BY item;

SELECT ROUND(MAX(QTY/Wholesale),1) AS 'Maximum' FROM Price;
SELECT ROUND(MIN(QTY/Wholesale),1) AS 'Minimum' FROM Price;
SELECT ROUND(AVG(QTY/Wholesale),1) AS 'Mean' FROM Price;

SELECT getdate();
SELECT datEPART(year, '2017/08/25');
SELECT datEPART(month, '2017/08/25');
SELECT datEPART(day, '2017/08/25');

SELECT datEPART(YEAR, GETDATE()) AS Today_Year;

SELECT ABS(-100);
SELECT FLOOR(1.7);
SELECT CEILING(2.3);


UPDATE Price
	SET QTY=25000 WHERE item='watermelon';

CREATE TABLE New
				(ID int NOT NULL Primary Key, 
				Name Varchar(60) NOT NULL, 
				Gender CHAR(1) NOT NULL, 
				Gender_ID tinyint NOT NULL);

ALTER TABLE New ADD FOREIGN KEY (Gender_ID) REFERENCES tblGender(G_Code);

DROP TABLE New;
SELECT * FROM New;


-- Give the placement of the first apperance of letter in a string
SELECT CHARINDEX('a', 'Katayoon');
SELECT CHARINDEX('a', 'Katayoon', 3);

SELECT LOWER ('KATAYOON');
SELECT UPPER ('katayoon');
SELECT REPLACE ('katayoun', 'ou', 'oo');
SELECT UPPER(LEFT('katayoon',1))+LOWER(SUBSTRING('katayoon',2,LEN('katayoon')));
SELECT REPLICATE ('Katayoon ', 3);
SELECT RTRIM ('Katayoon      ') + ' Mehr';
SELECT LTRIM ('      Katayoon') + ' Mehr';
SELECT LTRIM (RTRIM('      Katayoon       ')) + ' Mehr';
SELECT ('Katayoon      ') + ' Mehr';
SELECT SOUNDEX ('Juice'), SOUNDEX ('Jucy');
SELECT SOUNDEX ('Juice'), SOUNDEX ('Banana');
SELECT SOUNDEX ('Katayoon'), SOUNDEX ('Kataun');
SELECT SOUNDEX ('car'), SOUNDEX ('war');
SELECT SOUNDEX ('Leanna'), SOUNDEX ('Meloryna');

SELECT DIFFERENCE('Katayoon', 'Kataun');
SELECT DIFFERENCE('Leanna', 'Meloryna');


SELECT 'Kati' + SPACE (10) + 'Mehr';

SELECT STUFF ('KatiMehr', 4,1,'ayoon');
--- Starting from character number 4 and change 1 character with 'ayoon', some characters will be added

SELECT STUFF ('KatayoonMehr', 4,5,'i');
--- Starting from character number 4 and change 5 characters with 'i', some characters will be droped

SELECT UNICODE('K');
SELECT UNICODE('');

SELECT SUBSTRING ('abcdefg', 3, 2);
--- Get a substring from the original string starting at character number 3 and just picks 2 characters


------------------------------------------------------------
-- Day 3 
------------------------------------------------------------

CREATE TABLE employees (
						sno char(5) NOT NULL PRIMARY KEY, 
						F_Name varchar(50) NOT NULL, 
						L_Name varchar(60) NOT NULL,
						Salary float,
						Position varchar(15))
						;

DROP TABLE employees;

INSERT INTO employees 
	VALUES ('SL100', 'John', 'White', 30000.00, 'Manager'),
		   ('SL101', 'Susan', 'Brand', 24000.00, 'Manager'),
	       ('SL102', 'David', 'Ford', 12000.00, 'Project Manager'),
	       ('SL103', 'Ann', 'Beach', 12000.00, 'Project Manager'),
	       ('SL104', 'Mary', 'Howe', 9000.00, 'Project Manager');

SELECT * FROM employees;

SELECT Position, COUNT(sno) AS '#employee', SUM(Salary) AS 'Total_Salary' FROM employees
	GROUP BY Position;
	 
ALTER TABLE employees
	ADD bno char(5);

ALTER TABLE employees
	DROP bno;

SELECT bno, COUNT(sno) AS Qty, SUM(Salary) AS 'Total_Salary' FROM employees
	GROUP BY bno
	ORDER BY bno;

SELECT bno, COUNT(sno) AS Qty, SUM(Salary) AS 'Total_Salary' FROM employees
	GROUP BY bno
	HAVING COUNT(sno)>=2
	ORDER BY bno;

ALTER TABLE employees
	ADD Gender char(1) CHECK( Gender IN ('M', 'F', 'X'));

ALTER TABLE employees
	ADD City varchar(20);


SELECT UPPER(bno), * FROM employees;---> This is temporary just in output


/* Important: how to replace a wrong value */

SELECT REPLACE (bno, 'b2', 'B2') FROM employees; ---> This is temporary just in output

UPDATE employees SET bno='B2' WHERE bno='b2'; ---> This changes the data


SELECT * FROM employees
		ORDER BY City DESC, L_Name;

--If at the time of table creation, forget to set the primary key
ALTER TABLE employees 
	ADD Primary key (sno);

ALTER TABLE employees 
	DROP FOREIGN KEY employees_ibfk_1;

ALTER TABLE employees 
	DROP PRIMARY KEY;

---- Conversion
---- CAST and CONVERT are the same, CAST is ANSI but CONVERT can be used just in SQL Server Management

SELECT CONVERT ( varchar(30), 56);
SELECT CONVERT ( varchar(5), 2019 ) + ' ' +'Kati';

SELECT CONVERT ( int, '12')

SELECT CONVERT ( int, 'Kati') ----> Error


SELECT item, item + ' - ' + CAST(wholesale AS nvarchar) + ' - ' + CAST(QTY AS nvarchar) AS [item-wholesale] FROM Price;

SELECT REPLACE(Wholesale, '.', ',') FROM Price;


SELECT CONVERT( nvarchar(30), getdate(), 100);
SELECT CONVERT( nvarchar(30), getdate(), 120);
SELECT CONVERT( nvarchar(30), getdate(), 130);


SELECT CONVERT(decimal(6,4), 9.5) ----> 9.5000
SELECT CAST(9.5 AS decimal(6,4)) ----> 9.5000




------------------------------------------------------------
-- Day 4 
------------------------------------------------------------

---- All, any, some ----

CREATE TABLE T1_YourName (ID int);
INSERT into T1_YourName VALUES (1) ; 
INSERT into T1_YourName VALUES (2) ; 
INSERT into T1_YourName VALUES (3) ; 
INSERT into T1_YourName VALUES (4) ;


----Nested Query -----

select * from T1_YourName;

SELECT COUNT(ID) AS Total, 
	(SELECT COUNT(ID) FROM T1_YourName WHERE ID>2) AS Conditional_Total
			FROM T1_YourName;


---- IF / ELSE ---- PRINT ----

IF 3 < SOME (SELECT ID FROM T1_YourName) 
		PRINT 'TRUE' 
	ELSE 
		PRINT 'FALSE' ;

IF 3 < Any (SELECT ID FROM T1_YourName) 
		PRINT 'TRUE' 
	ELSE 
		PRINT 'FALSE' ;

IF 3 < ALL (SELECT ID FROM T1_YourName) 
		PRINT 'TRUE' 
	ELSE 
		PRINT 'FALSE' ;

IF 4 >= ALL (SELECT ID FROM T1_YourName) 
		PRINT 'TRUE' 
	ELSE 
		PRINT 'FALSE' ;

print 'A'
go 4


---- CASE ---- WHEN ----

/* This is just to view and o change on the table */
SELECT ID, CASE 
	WHEN ID=1
		THEN 'First One'
			WHEN ID=2
				THEN 'Second One'
					ELSE 'Other'
						END AS  Result FROM T1_YourName;

/* To add a new coulmn permanently with those values: */	
ALTER TABLE T1_YourName ADD Def varchar (15);

UPDATE T1_YourName SET Def='First' WHERE ID=1;
UPDATE T1_YourName SET Def='Second' WHERE ID=2;
UPDATE T1_YourName SET Def='Third' WHERE ID=3;
UPDATE T1_YourName SET Def='Forth' WHERE ID=4;


SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails; 

---------------------------------
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END); 


----------------------------------------------	
USE Meloryna_7

--SQL Script to create tblEmployee table:

CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
);

--SQL Script to create tblDepartment table: 

CREATE TABLE tblDepartment
(
 DeptId int Primary Key,
 DeptName nvarchar(20)
);

--Insert data into tblDepartment table
Insert into tblDepartment values (1,'IT');
Insert into tblDepartment values (2,'Payroll');
Insert into tblDepartment values (3,'HR');
Insert into tblDepartment values (4,'Admin');
Insert into tblDepartment values (5,'Marketing');

--Insert data into tblEmployee table
Insert into tblEmployee values (1,'John', 5000, 'Male', 3);
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2);
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1);
Insert into tblEmployee values (4,'Todd', 4800, 'Male', 4);
Insert into tblEmployee values (5,'Sara', 3200, 'Female', 1);
Insert into tblEmployee values (6,'Ben', 4800, 'Male', 3);
Insert into tblEmployee values (7,'James', 4800, 'Male', Null);
Insert into tblEmployee values (8,'Tom', 4800, 'Male', Null);

select * from tblDepartment;

select * from tblEmployee;


-- Subquery (Nested Query)

select Name, Gender from 
	(
	select * from tblEmployee
	) AS A


--- Subquery with WITH

WITH Name_tbl (Name, Gender)
AS
	(
	select Name, Gender from tblEmployee
	)
		select * from Name_tbl;


WITH Name_tbl_M
AS
	(
	select * from tblEmployee
	)
		select * from Name_tbl_M
			WHERE Gender='Male';	
	 
------------------------------------------------------------
-- Day 5 
------------------------------------------------------------


---- Self Join -----

USE Meloryna

SELECT * FROM employees;

SELECT E.sno, CONCAT(E.F_NAME, ' ', E.L_Name) AS Employee,
	   CONCAT(M.F_NAME, ' ', M.L_Name) AS Manager
			FROM Employees E
			INNER JOIN Employees M
				ON M.sno=E.bno;

/*Without Cancat */
SELECT E.sno, E.F_NAME AS Employee_Name , E.L_Name AS Employee_LastName,
	   M.F_NAME AS Manager_Name, M.L_Name AS Manager_LastName
			FROM Employees E
			INNER JOIN Employees M
				ON M.sno=E.bno;

--Inner join
Select Id, Name, Salary, Gender, DeptName, DepartmentId
from tblEmployee
join tblDepartment
on DepartmentId = DeptId;

-------OR--------

Select E.* , D.*
from tblEmployee E
join tblDepartment D
on E.DepartmentId = D.DeptId;

-----OLD VERSION ------

SELECT Id, Name, Salary, Gender, DeptName, DepartmentId
	FROM tblEmployee, tblDepartment
		WHERE DepartmentId = DeptId;


SELECT * FROM tblEmployee;
SELECT * FROM tblDepartment;

--Left join

Select Id, Name, Salary, Gender, DeptName, DepartmentId
from tblEmployee
left join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId;

--WHERE tblEmployee.DepartmentId IS NULL

--Right join

Select Id, Name, Salary, Gender, DeptName, DepartmentId, DeptId
from tblEmployee
right join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId;



-- Full outer join/ Full join
Select Id, Name, Salary, Gender, DeptName
from tblEmployee
full join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId;


--cross join...??!!
SELECT Name, Gender, Salary, DeptName
FROM tblEmployee
CROSS JOIN tblDepartment;

select* from tblEmployee, tblDepartment;




/*
Consider you have Car table which holds model information Car(Make, Model) and AvaliableColorOption(Color)
All available car options can be achieved by cross join..
Car table:
1. Benz C-Class
2. Benz S-Class

AvaliableColorOption:
1. Red
2. Green

Cartesian Product of the tables will yield:
1. Benz C-Class Red
2. Benz S-Class Red
3. Benz C-Class Green
4. Benz S-Class Green*/


--subqueries
Create Table tblProducts
(
 Id int identity primary key,
 Name nvarchar(50),
 Description nvarchar(250)
);

Create Table tblProductSales
(
 Id int primary key identity,
 ProductId int foreign key references tblProducts(Id),
 UnitPrice int,
 QuantitySold int
) ;

select* from tblProducts;
select* from tblProductSales;

Insert into tblProducts values ('TV', '52 inch black color LCD TV');
Insert into tblProducts values ('Laptop', 'Very thin black color acer laptop');
Insert into tblProducts values ('Desktop', 'HP high performance desktop');

Insert into tblProductSales values(3, 450, 5);
Insert into tblProductSales values(2, 250, 7);
Insert into tblProductSales values(3, 450, 4);
Insert into tblProductSales values(3, 450, 9);


SELECT P.*, S.*
	FROM tblProducts P
		INNER JOIN tblProductSales S
			ON P.Id=S.ProductId;

SELECT P.*, S.*
	FROM tblProducts P
		LEFT JOIN tblProductSales S
			ON P.Id=S.ProductId;

SELECT P.*, S.*
	FROM tblProducts P
		RIGHT JOIN tblProductSales S
			ON P.Id=S.ProductId;

SELECT P.*, S.*
	FROM tblProducts P
		FULL JOIN tblProductSales S
			ON P.Id=S.ProductId;




--retrieve products that are not at all sold?
Select Id, Name, Description
from tblProducts
where Id NOT IN (Select Distinct ProductId from tblProductSales);


-----IMPORTANT--------------
-----Correlated Query ------
-----WHAT IS THE TOTAL QUANTITY OF SALE PER ITEM?

SELECT Name, (SELECT SUM(QuantitySold) FROM tblProductSales  	
	WHERE ProductId=tblProducts.Id) AS TotalQty
		FROM tblProducts;	

SELECT * FROM tblProducts;

---  OR By Left Join -----
SELECT P.Name, SUM(S.QuantitySold)
	FROM tblProducts P
		LEFT JOIN tblProductSales S
			ON P.Id=S.ProductId
			GROUP BY P.Name;


