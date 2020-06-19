
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

--------------------------------------------
-- Procedures
--------------------------------------------

Create Table tblMailingAddress
(
   AddressId int NOT NULL primary key,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(50),
   PostalCode nvarchar(50)
);

Insert into tblMailingAddress values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');


Create Table tblPhysicalAddress
(
 AddressId int NOT NULL primary key,
 EmployeeNumber int,
 HouseNumber nvarchar(50),
 StreetAddress nvarchar(50),
 City nvarchar(50),
 PostalCode nvarchar(50)
);

Insert into tblPhysicalAddress values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

select * from tblMailingAddress;
select * from tblPhysicalAddress


--procedure/no input/no output
Create Procedure spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction
   Update tblMailingAddress set City = 'LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  Rollback Transaction
 End Catch
End; 

execute spUpdateAddress;

select* from tblMailingAddress
select* from tblPhysicalAddress
-------------

Alter Procedure spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction
   Update tblMailingAddress set City = 'LONDON12' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON14' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  Rollback Transaction
 End Catch
End;

execute spUpdateAddress;

select* from tblMailingAddress;
select* from tblPhysicalAddress;

sp_helptext spUpdateAddress;

--------------------------------
Select* from tblEmployee;

Create Procedure spGetEmployees
as
Begin
  Select Name, Gender from tblEmployee
End;

execute spGetEmployees;

sp_helptext spGetEmployees;


---procedure with input
Create Procedure spGetEmployeesByGenderAndDepartment  
@Gender nvarchar(10)
as
Begin
  Select Name, Gender, DepartmentId from tblEmployee Where Gender = @Gender
End;

execute spGetEmployeesByGenderAndDepartment 'Male'; 





CREATE PROC DEPT @Dept_name NVARCHAR(20)
AS
BEGIN 
	SELECT D.*, E.*
		FROM tblDepartment D
			INNER JOIN tblEmployee E
				ON D.DeptId=E.DepartmentId 
					AND DeptName=@Dept_name
END;

EXECUTE DEPT 'Data';



----------------------------

--proc with return
Create Procedure spGetTotalCountOfEmployees2
as
Begin
 return (Select COUNT(ID) from tblEmployee)
End;

--execute spGetTotalCountOfEmployees2

Declare @TotalEmployees int; --- Defining a variable to receive the teruned value
Execute @TotalEmployees = spGetTotalCountOfEmployees2;
Select @TotalEmployees;

-----------------------

--With output 
Create Procedure spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int Output
as
Begin
 Select @EmployeeCount = COUNT(Id) 
 from tblEmployee 
 where Gender = @Gender
End ;

-- DROP PROC spGetEmployeeCountByGender;

Declare @EmployeeTotal int;
Execute spGetEmployeeCountByGender 'Male' , @EmployeeTotal output;
print @EmployeeTotal;



-------------- For Both Gender---------------
Declare @EmployeeTotal1 int;
Execute spGetEmployeeCountByGender 'Male' , @EmployeeTotal1 output;

Declare @EmployeeTotal2 int;
Execute spGetEmployeeCountByGender 'Female' , @EmployeeTotal2 output;

print CAST (@EmployeeTotal1 AS VARCHAR(5)) + '      ' + CAST(@EmployeeTotal2 AS VARCHAR(5));

---------------------------------------------

Declare @EmployeeTotal int;
Execute spGetEmployeeCountByGender 'Female', @EmployeeTotal output;
if(@EmployeeTotal =0)
 Print '@EmployeeTotal is null'
else
 Print '@EmployeeTotal is not null';

----------------------------------

--With  2 inputs Only
Create Procedure Namesalgen
@Gender nvarchar(20),
@Salary int
as
Begin
 Select Name FROM tblEmployee WHERE Gender=@Gender AND Salary> @Salary
End ;

EXECUTE Namesalgen 'Female', 3000;

----------------------------------

--With output and 2 inputs---- STILL HAS PROBLEM
Create Procedure GenderMinSalary
@Gender nvarchar(20),
@MinSalary int,
@EmployeeCount int Output
as
Begin
 Select @EmployeeCount = COUNT(Id)
 from tblEmployee 
 where Gender = @Gender AND Salary>@MinSalary
End ;


Declare @EmployeeTotal int;
Execute GenderMinSalary 'Male', 5000 , @EmployeeTotal output;
PRINT @EmployeeTotal;



--With output and 2 inputs
Create Procedure GenderAVGSalary
@Gender nvarchar(20),
@EmployeeCount int Output,
@AVGSalary int Output

as
Begin
 Select @EmployeeCount = COUNT(Id), @AVGSalary=AVG(Salary)
 from tblEmployee 
 where Gender = @Gender AND Salary >= @AVGSalary
End ;


Declare @EmployeeTotal int;
Execute GenderAVGSalary 'Male', AVG(Salary), @EmployeeTotal output;
PRINT @EmployeeTotal;

Declare @EmployeeAvgSalary int; 
Execute GenderAVGSalary 'Male', @EmployeeAvgSalary output;
PRINT @EmployeeAvgSalary;



--Return vs Output

Create Procedure spGetNameById1
@Id int,
@Name nvarchar(20) Output
as
Begin
 Select @Name = Name from tblEmployee Where Id = @Id
End;

Declare @EmployeeName nvarchar(20)
Execute spGetNameById1 3, @EmployeeName out
Print 'Name of the Employee = ' + @EmployeeName

-----------------------------
Create Procedure spGetNameById2
@Id int
as
Begin
 Return (Select Name from tblEmployee Where Id = @Id)
End

Declare @EmployeeName nvarchar(20)
Execute @EmployeeName = spGetNameById2 1
Print 'Name of the Employee = ' + @EmployeeName

--So, using return values, we can only return integers!!!



----------------------------
BEGIN TRAN
UPDATE price SET item = 'grape' WHERE wholesale = 2;
SAVE TRAN Savepoint1
DELETE FROM price WHERE item = 'apple';
ROLLBACK TRAN Savepoint1
ROLLBACK
SELECT * FROM price;
-------------------------------

CREATE FUNCTION StripWWWandCom (@input VARCHAR(250))
RETURNS VARCHAR(250)
AS 
BEGIN
    DECLARE @Work VARCHAR(250)
    SET @Work = @Input
    SET @Work = REPLACE(@Work, 'www.', '')
    SET @Work = REPLACE(@Work, '.com', '')
    RETURN @work
END;

Select dbo.StripWWWandCom('www.amazon.com') as output2

---------------- 1 Input
CREATE FUNCTION AveragePi1 (@price float = 0.0) 
RETURNS table
AS 
RETURN (SELECT * FROM price
	WHERE Wholesale  >  @price);
				   
select* from AveragePi1(3);


select* from AveragePi1(default);


---------------- 2 inputs
CREATE FUNCTION AveragePi2 (@price1 float , @price2 float)
RETURNS table
AS 
RETURN (SELECT * FROM price
	WHERE Wholesale  BETWEEN @price1 AND @price2);
				   
select* from AveragePi2(3,5);


---------------- 2 inputs
CREATE FUNCTION AveragePi2 (@price1 float , @price2 float)
RETURNS table
AS 
RETURN (SELECT * FROM price
	WHERE Wholesale  BETWEEN @price1 AND @price2);
				   
select* from AveragePi2(3,5);




--------------
CREATE FUNCTION AveragePricebyItems2 (@price float = 0.0) 
RETURNS @table table (Description varchar(50) null, Price float null) AS
	   begin 
	      insert @table SELECT item, wholesale
		           	      FROM price
		                    WHERE wholesale  >  @price 
	      return 
	end 

select * from AveragePricebyItems2(2)



Select Name, DateOfBirth, dbo.Age(DateOfBirth) as Age 
from tblEmployees
Where dbo.Age(DateOfBirth) > 30




Create Procedure sp_sum
@x int, @y int
as
Begin
 return(Select @x + @y)
End

Declare @z int
Execute @z = sp_sum 10,20
Print @z


Create Procedure sp_sum2
@x int, @y int,
@v int output
as
Begin
 Select @v = @x + @y
End

Declare @z int
Execute sp_sum2 10,20, @z out
Print @z




--
create procedure p_x
as
begin
declare @t table(col1 varchar(10), col2 float, col3 float, col4 float)
insert @t values('a', 1,1,1)
insert @t values('b', 2,2,2)

select * from @t
end
go

declare @t table(col1 varchar(10), col2 float, col3 float, col4 float)
insert @t
exec p_x
select * from @t


