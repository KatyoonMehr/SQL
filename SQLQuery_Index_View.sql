
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
--------------------------------------------




