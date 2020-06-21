
USE Meloryna_7

--------------------------------------------
-- Index
--------------------------------------------

/* To retrieve information such as name in large datasets faster*/

SELECT * FROM tblEmployee;

SELECT * FROM tblEmployee WHERE Salary > 5000 AND Salary < 7000;

CREATE INDEX IX_tblEmployee_Salary ON tblEmployee(SALARY ASC);

sp_helpindex tblEmployee;

--------------
CREATE TABLE [tblEmployee_2]
(
 [Id] INT PRIMARY KEY, 
 [Name] NVARCHAR(50), 
 [Salary] INT,
 [Gender] NVARCHAR(10), 
 [City] NVARCHAR(50)
);

sp_helpindex tblEmployee_2;


INSERT INTO tblEmployee_2 VALUES(3,'John',4500,'Male','New York');
INSERT INTO tblEmployee_2 VALUES(1,'Sam',2500,'Male','London');
INSERT INTO tblEmployee_2 VALUES(4,'Sara',5500,'Female','Tokyo');
INSERT INTO tblEmployee_2 VALUES(5,'Todd',3100,'Male','Toronto');
INSERT INTO tblEmployee_2 VALUES(2,'Pam',6500,'Female','Sydney');


SELECT * FROM tblEmployee_2; --ordered

CREATE CLUSTERED INDEX IX_tblEmployee_Name ON tblEmployee(Name);
--error/only one clustered index allowed


DROP INDEX tblEmployee_2.PK__tblEmplo__3214EC07BF34ED04;
--error/ so delete it manually 

CREATE CLUSTERED INDEX IX_tblEmployee_Gender_Salary --composite clustered index
ON tblEmployee_2(Gender DESC, Salary ASC);

SELECT * FROM  tblEmployee_2;  --re-arranged!!

--non-clustered index

CREATE NONCLUSTERED INDEX IX_tblEmployee_Name --stored separately--does not affect the order of rows
ON tblEmployee_2(Name);

--------------------------------------------

USE Meloryna; 

CREATE CLUSTERED INDEX index1 ON price (wholesale);
CREATE NONCLUSTERED INDEX index2 ON price (item);
CREATE UNIQUE NONCLUSTERED INDEX index3 ON price (item); ----> Error

INSERT INTO Price VALUES ('Orange', 2, 7000);

SELECT * FROM price WHERE Wholesale = 2.2;

SELECT * FROM price;

DROP INDEX price.index1;
DROP INDEX price.index2;


sp_helpindex price;

sp_helpindex tblperson;


--------------------------------------------
-- views (Virtual Table)
--------------------------------------------

--SQL Script to create tblEmployee table:
CREATE TABLE tblEmployee
	(
	Id INT PRIMARY KEY,
	Name NVARCHAR(30),
	Salary INT,
	Gender NVARCHAR(10),
	DepartmentId INT
);

--SQL Script to create tblDepartment table: 
CREATE TABLE tblDepartment
	(
	 DeptId INT PRIMARY KEY,
	 DeptName NVARCHAR(20)
);

--Insert data into tblDepartment table
INSERT INTO tblDepartment VALUES (1,'IT');
INSERT INTO tblDepartment VALUES (2,'Payroll');
INSERT INTO tblDepartment VALUES (3,'HR');
INSERT INTO tblDepartment VALUES (4,'Admin');

--Insert data into tblEmployee table
INSERT INTO tblEmployee VALUES (1,'John', 5000, 'Male', 3);
INSERT INTO tblEmployee VALUES (2,'Mike', 3400, 'Male', 2);
INSERT INTO tblEmployee VALUES (3,'Pam', 6000, 'Female', 1);
INSERT INTO tblEmployee VALUES (4,'Todd', 4800, 'Male', 4);
INSERT INTO tblEmployee VALUES (5,'Sara', 3200, 'Female', 1);
INSERT INTO tblEmployee VALUES (6,'Ben', 4800, 'Male', 3);

SELECT * FROM tblDepartment;
SELECT * FROM tblEmployee;

SELECT Id, Name, Salary, Gender, DeptName
	FROM tblEmployee
		JOIN tblDepartment
			ON tblEmployee.DepartmentId = tblDepartment.DeptId;


CREATE VIEW firstview AS
	SELECT Id, Name, Salary, Gender, DeptName
		FROM tblEmployee
			JOIN tblDepartment
				ON tblEmployee.DepartmentId = tblDepartment.DeptId;


SELECT * FROM  firstview; --virtual table/doesnot store any data by default.

DROP VIEW firstview;


CREATE VIEW Secondview AS
	SELECT Id, Name, Salary, Gender, DeptName
		FROM tblEmployee
			FULL JOIN tblDepartment
				ON tblEmployee.DepartmentId = tblDepartment.DeptId;

SELECT * FROM Secondview;

DROP VIEW  Secondview;

UPDATE Secondview
	SET DeptName='Payroll' WHERE Name='Sara';

INSERT INTO Secondview
		(Id, Name, Salary, Gender) VALUES (20, 'Mikey', 5650, 'Male'); 


--View that returns only IT department employees:
CREATE VIEW IT_view AS
	SELECT Id, Name, Salary, Gender, DeptName
		FROM tblEmployee
			JOIN tblDepartment
				ON tblEmployee.DepartmentId = tblDepartment.DeptId
				WHERE tblDepartment.DeptName = 'IT' AND gender IS NOT NULL;

SELECT * FROM IT_view;

DROP VIEW IT_view;



SELECT SUM(Salary) AS total, DeptName
	FROM Secondview
	WHERE salary IS NOT NULL
	GROUP BY DeptName;


CREATE VIEW ThirdView (c1, c2, c3, c4, c5) AS --To change the columns' name.
	SELECT Id, Name, Salary, Gender, DeptName
		FROM tblEmployee
			JOIN tblDepartment
				ON tblEmployee.DepartmentId = tblDepartment.DeptId
				WHERE tblDepartment.DeptName LIKE 'HR';

SELECT * FROM Thirdview
	ORDER BY c3 DESC;

DROP VIEW ThirdView;

UPDATE tblEmployee
	SET Salary=6525
	WHERE Name='Selina';

UPDATE tblEmployee
	SET Salary=7555
	WHERE Name='Kati';

UPDATE Thirdview
SET C2='Celin' WHERE C1=6;


--Total number of employees by Department.
CREATE VIEW CountByDepartment AS
	SELECT DeptName, COUNT(Id) AS TotalEmployees
		FROM tblEmployee
			JOIN tblDepartment
				ON tblEmployee.DepartmentId = tblDepartment.DeptId
				GROUP BY DeptName;

SELECT * FROM CountByDepartment;
DROP VIEW CountByDepartment;



--Views can be used to update the original table
--View, which returns all the columns from the tblEmployees table, except Salary column.

CREATE VIEW V_ExceptSalary AS
	SELECT Id, Name, Gender, DepartmentId
		FROM tblEmployee;

SELECT * FROM V_ExceptSalary;

UPDATE V_ExceptSalary 
SET Name = 'Mikey' WHERE Id = 2;

SELECT * FROM tblEmployee; --The original table updated

DELETE FROM V_ExceptSalary WHERE Id = 2;

INSERT INTO V_ExceptSalary VALUES (2, 'Mikey', 'Male', 2);



--------------------------------------------
-- Transaction
--------------------------------------------

SELECT * FROM price;

BEGIN TRANSACTION;
INSERT INTO price (item, wholesale) VALUES ('fffff', 1.2), ('rrrrr', 1.6);
COMMIT; -- After commit can not rollback
         
ROLLBACK TRAN;
SELECT * FROM price;


BEGIN TRANSACTION;
INSERT INTO price (item, wholesale) VALUES ('xxxx', 5.2), ('yyyy', 6.9);
       
ROLLBACK TRAN;
SELECT * FROM price;




-- Isolation\Lock

CREATE TABLE ValueTable (id INT);  
BEGIN TRANSACTION;  
INSERT INTO ValueTable VALUES(1), (2), (3);
COMMIT;
SELECT * FROM valuetable;   
ROLLBACK; 

DROP TABLE ValueTable;

-- Savepoint

BEGIN TRANSACTION;
CREATE TABLE ValueTable (id INT);
       INSERT INTO ValueTable VALUES(1);  
	   SAVE TRAN Savepoint1;
       INSERT INTO ValueTable VALUES(2);
	   SAVE TRAN Savepoint2;
	   INSERT INTO ValueTable VALUES(3); 
	   SAVE TRAN Savepoint3;
ROLLBACK TRAN Savepoint2;
COMMIT TRAN;
SELECT * FROM valuetable;

DROP TABLE valuetable;
	 
-- If ROLLBACK at savepoint1 we will keep only value 1
-- If ROLLBACK at savepoint2 we will keep values 1 and 2  
-- If ROLLBACK at savepoint3 we will keep all values, there is no other transaction after it.



BEGIN TRAN
UPDATE price SET item = 'grape' WHERE wholesale = 2;
SAVE TRAN Savepoint1;
DELETE FROM price WHERE item = 'apple';
ROLLBACK TRAN Savepoint1;
ROLLBACK;
SELECT * FROM price;



--------------------------------------------
-- Procedures
--------------------------------------------

CREATE TABLE  tblMailingAddress
(
   AddressId INT NOT NULL PRIMARY KEY,
   EmployeeNumber INT,
   HouseNumber NVARCHAR(50),
   StreetAddress NVARCHAR(50),
   City NVARCHAR(50),
   PostalCode NVARCHAR(50)
);

INSERT INTO tblMailingAddress VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');


CREATE TABLE tblPhysicalAddress
(
 AddressId INT NOT NULL PRIMARY KEY,
 EmployeeNumber INT,
 HouseNumber NVARCHAR(50),
 StreetAddress NVARCHAR(50),
 City NVARCHAR(50),
 PostalCode NVARCHAR(50)
);

INSERT INTO tblPhysicalAddress VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;


-- Procedure/no input/no output
CREATE PROCEDURE spUpdateAddress AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE tblMailingAddress SET City = 'LONDON' 
			WHERE AddressId = 1 AND EmployeeNumber = 101
        COMMIT TRAN
	END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END;

EXECUTE spUpdateAddress;

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;


ALTER PROCEDURE spUpdateAddress AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE tblMailingAddress SET City = 'LONDON12' 
			WHERE AddressId = 1 AND EmployeeNumber = 101
   
		UPDATE tblMailingAddress SET City = 'LONDON14' 
			WHERE AddressId = 1 AND EmployeeNumber = 101
        COMMIT TRAN
	END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END;

EXECUTE spUpdateAddress;

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;


sp_helptext spUpdateAddress;

--------------------------------------------


SELECT * FROM tblEmployee;

CREATE PROCEDURE spGetEmployees AS
BEGIN
	SELECT Name, Gender FROM tblEmployee
END;

EXECUTE spGetEmployees;

sp_helptext spGetEmployees;


---Procedure with input
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment @Gender NVARCHAR(10) AS
BEGIN
	SELECT Name, Gender, DepartmentId FROM tblEmployee 
		WHERE Gender = @Gender
END;

EXECUTE spGetEmployeesByGenderAndDepartment 'Male'; 





CREATE PROC dept @Dept_name NVARCHAR(20) AS
BEGIN 
	SELECT D.*, E.*
		FROM tblDepartment D
			INNER JOIN tblEmployee E
				ON D.DeptId=E.DepartmentId 
					AND DeptName=@Dept_name
END;

EXECUTE dept 'HR';

-- Similarly 
CREATE VIEW v_dept AS 
	SELECT D.*, E.*
		FROM tblDepartment D
			INNER JOIN tblEmployee E
				ON D.DeptId=E.DepartmentId;
					
SELECT * FROM v_dept
	WHERE DeptName = 'HR';

--------------------------------------------

--Procedure with return
CREATE PROC spGetTotalCountOfEmployees2 AS
BEGIN
	RETURN (SELECT COUNT(ID) FROM tblEmployee)
END;

--execute spGetTotalCountOfEmployees2;

DECLARE @TotalEmployees INT; -- Defining a variable to receive the retuned value
EXECUTE @TotalEmployees = spGetTotalCountOfEmployees2;
SELECT @TotalEmployees;

-- All 3 lines should be selected and run together
--------------------------------------------

--With output 
CREATE PROC spGetEmployeeCountByGender @Gender NVARCHAR(20), @EmployeeCount INT OUTPUT AS
BEGIN
	SELECT @EmployeeCount = COUNT(Id) 
		FROM tblEmployee 
			WHERE Gender = @Gender
END;

DROP PROC spGetEmployeeCountByGender;

DECLARE @EmployeeTotal INT;
EXECUTE spGetEmployeeCountByGender 'Male' , @EmployeeTotal OUTPUT;
PRINT @EmployeeTotal;

-- Similarly
CREATE VIEW v_countgender AS
	SELECT Gender FROM tblEmployee;

SELECT COUNT(Gender)FROM v_countgender
		WHERE Gender = 'Male';

--------------------------------------------

DECLARE @EmployeeTotal INT;
EXECUTE spGetEmployeeCountByGender 'Female' , @EmployeeTotal OUTPUT;
IF(@EmployeeTotal = 0)
 PRINT '@EmployeeTotal is null'
ELSE
 PRINT '@EmployeeTotal is not null';

--------------------------------------------

--With  2 inputs Only
CREATE PROC Namesalgen @Gender NVARCHAR(20), @Salary INT AS
BEGIN
	SELECT Name FROM tblEmployee WHERE Gender = @Gender AND Salary > @Salary
END;

EXECUTE Namesalgen 'Female', 3000;

--------------------------------------------

--With output and 2 inputs
CREATE PROC GenderMinSalary @Gender NVARCHAR(20), @Salary INT, @EmployeeCount INT OUTPUT AS
BEGIN
	SELECT @EmployeeCount = COUNT(Id)
		FROM tblEmployee 
			WHERE Gender = @Gender AND Salary = @Salary
END;

DECLARE @EmployeeTotal INT;
EXECUTE GenderMinSalary 'Male', 5000 , @EmployeeTotal OUTPUT;
PRINT @EmployeeTotal;



--Return vs Output
CREATE PROC spGetNameById1 @Id INT, @Name NVARCHAR(20) OUTPUT AS
BEGIN
	SELECT @Name = Name FROM tblEmployee 
		WHERE Id = @Id
END;

DECLARE @EmployeeName NVARCHAR(20);
EXECUTE spGetNameById1 3, @EmployeeName OUT;
PRINT 'Name of the Employee = ' + @EmployeeName;
