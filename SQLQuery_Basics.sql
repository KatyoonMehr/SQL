------------------------------------------------------------
-- Day 1 of Learning SQL Server Management Studio 07-10-2019
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
-- Day 2 of Learning SQL Server Management Studio 08-10-2019
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
-- Day 3 of Learning SQL Server Management Studio 09-10-2019
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
	ADD bno char(2);

SELECT bno, COUNT(sno) AS Qty, SUM(Salary) AS 'Total_Salary' FROM employees
	GROUP BY bno
	ORDER BY bno;

SELECT bno, COUNT(sno) AS Qty, SUM(Salary) AS 'Total_Salary' FROM employees
	GROUP BY bno
	HAVING COUNT(bno)<=2
	ORDER BY bno;

ALTER TABLE employees
	ADD Gender char(1) CHECK( Gender IN ('M', 'F', 'X'));

ALTER TABLE employees
	ADD City varchar(20);


SELECT UPPER(bno), * FROM employees;---> This is temporary just in output

SELECT REPLACE (BNO, 'b2', 'B2') FROM employees; ---> This is temporary just in output

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







	 




