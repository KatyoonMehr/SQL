
CREATE DATABASE Emp;

USE Emp;

CREATE TABLE Emp_Mod (emp_no INT NOT NULL PRIMARY KEY,
			 birth_date DATETIME,
			 first_name NVARCHAR(50),
			 last_name NVARCHAR(50),
			 gender CHAR(1),
			 hire_date DATETIME)
			 ;

-- 1000 rows of Data imported from Excel file

SELECT COUNT(DISTINCT emp_no) FROM Employees_Mod$; --Make sure we don't have duplicate contracts

SELECT *, YEAR(hire_date) AS YearOfHiring FROM Employees_Mod$;

SELECT YEAR(hire_date) AS YearOfHiring, gender, COUNT(DISTINCT emp_no) AS NumberOfEmployees 
	FROM Employees_Mod$
		GROUP BY YEAR(hire_date), gender
		HAVING YEAR(hire_date) >= 1990
		ORDER BY YEAR(hire_date)
;


ALTER TABLE Employees_Mod$ ALTER COLUMN emp_no INT NOT NULL;
ALTER TABLE DeptManager_Mod$ ALTER COLUMN emp_no INT NOT NULL;
ALTER TABLE Employees_Mod$ ADD PRIMARY KEY (emp_no);
ALTER TABLE Departments_Mod$ ADD PRIMARY KEY (dept_no);
ALTER TABLE DeptManager_Mod$ ADD FOREIGN KEY (emp_no) REFERENCES Employees_Mod$(emp_no);

SELECT * FROM DeptManager_Mod$
	ORDER BY emp_no;
SELECT * FROM Departments_Mod$;
SELECT * FROM EmpDept_Mod$
	ORDER BY emp_no;
SELECT * FROM Salary_Mod$
	ORDER BY emp_no;
SELECT * FROM DeptManager_Mod$
	ORDER BY emp_no;


-- Create the table to be used for Visulization in Tableau

-- Chart 1
SELECT *, 
CASE
	WHEN YEAR(to_date) = 9999 THEN GETDATE()
	ELSE to_date
	END AS end_date
		FROM DeptEmp_Mod$;

-- For all the employees
CREATE VIEW VIEW_1 AS
SELECT DISTINCT E.emp_no, E.first_name, E.last_name, E.gender, 
D.dept_no, D.dept_name, ED.from_date, ED.to_date, YEAR(E.hire_date) AS YearOfHiring,
CASE
	WHEN YEAR(to_date) = 9999 THEN GETDATE()
	ELSE to_date
	END AS end_date,
CASE
	WHEN YEAR(ED.from_date) <= YEAR(E.hire_date)
	AND YEAR(ED.to_date) >= YEAR(E.hire_date)
	THEN 1
	ELSE 0
	END AS Active
FROM Employees_Mod$ E
	LEFT JOIN EmpDept_Mod$ ED
		ON E.emp_no = ED.emp_no
			LEFT JOIN Departments_Mod$ D
				ON ED.dept_no = D.dept_no
;

SELECT * FROM View_1;

SELECT YearOfHiring, dept_name, gender, COUNT(Active) AS NumerOfActiveEmployees FROM View_1 
GROUP BY YearOfHiring, dept_name, gender
ORDER BY YearOfHiring;



--Chart 2
-- For the managers
CREATE VIEW VIEW_2 AS
SELECT DISTINCT E.emp_no, E.first_name, E.last_name, E.gender, 
D.dept_no, D.dept_name, DM.Salary, DM.from_date, DM.to_date, YEAR(E.hire_date) AS YearOfHiring,
CASE
	WHEN YEAR(DM.from_date) <= YEAR(E.hire_date)
	AND YEAR(DM.to_date) >= YEAR(E.hire_date)
	THEN 1
	ELSE 0
	END AS Active
FROM Employees_Mod$ E
	JOIN DeptManager_Mod$ DM
		ON E.emp_no = DM.emp_no
			JOIN EmpDept_Mod$ ED
				ON ED.emp_no = DM.emp_no
					JOIN Departments_Mod$ D
						ON D.dept_no = ED.dept_no
;

SELECT * FROM View_2;

SELECT YearOfHiring, dept_name, gender, COUNT(Active) AS NumerOfActiveManagers FROM View_2 
GROUP BY YearOfHiring, dept_name, gender
ORDER BY YearOfHiring;



--Chart 4
SELECT gender, dept_name, ROUND(AVG(salary),2), YearOfHiring FROM View_2 
GROUP BY dept_name, YearOfHiring, gender
ORDER BY gender, dept_name;


--Chart 5
SELECT MIN(salary) FROM Salary_Mod$;
SELECT MAX(salary) FROM Salary_Mod$;


CREATE PROC SalaryRang @MinSal FLOAT, @MaxSal FLOAT AS
BEGIN
	SELECT E.gender, D.dept_name, AVG(S.Salary) AS AvgSalary
	FROM Employees_Mod$ E
		JOIN Salary_Mod$ S
			ON E.emp_no = S.emp_no
				JOIN EmpDept_Mod$ ED
					ON E.emp_no = ED.emp_no
						JOIN Departments_Mod$ D
							ON ED.dept_no = D.dept_no
								WHERE S.Salary BETWEEN @MinSal AND @MaxSal
								GROUP BY E.gender, D.dept_name
END;

EXECUTE SalaryRang 50000, 90000;



---Codes in My SQL
DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);



-- Quiz
--1 Find the average salary of the male and female employees in each department. 
SELECT gender, dept_name, ROUND(AVG(salary),2) FROM View_2 
GROUP BY dept_name, gender
ORDER BY dept_name, gender;

--2 Find the lowest department number encountered in the 'dept_emp' table. Then, find the highest
--department number. 

SELECT dept_name, COUNT(dept_name)AS NumberOfEmployees FROM View_2
GROUP BY dept_name
ORDER BY COUNT(dept_name);

--3 Obtain a table containing the following three fields for all individuals whose employee number is not
--greater than 10040.-- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020,
--and '110039' to those whose number is between 10021 and 10040 inclusive. SELECT emp_no FROM Employees_Mod$WHERE emp_no <= 10040ORDER BY emp_no;SELECT E.emp_no, ED.dept_no, E.First_name, E.Last_name, CASE 	WHEN E.emp_no <= 10020 THEN 110022	ELSE 110039END AS Manager	FROM Employees_Mod$ E 		JOIN EmpDept_Mod$ ED			ON E.emp_no = ED.Emp_no			WHERE E.emp_no <= 10040; --4 Retrieve a list of all employees that have been hired in 2000. CREATE PROC YearHire @InputYear INT ASBEGIN	SELECT emp_no, First_name, Last_name, YEAR(hire_date) AS HiringYear
	FROM Employees_Mod$
	WHERE Year(hire_date) = @InputYear
END;

EXECUTE YearHire 2000;

--5 Create a procedure that asks you to insert an employee number and that will obtain an output containing
--the same number, as well as the number and name of the last department the employee has worked in. 

CREATE PROCEDURE Last_dept @inemp_no INT AS
BEGIN
SELECT E.emp_no, D.dept_no, D.dept_name
FROM Employees_Mod$ E
	JOIN EmpDept_Mod$ ED 
		ON E.emp_no = ED.emp_no
			JOIN Departments_Mod$ D
				ON ED.dept_no = D.dept_no
				WHERE E.emp_no = @inemp_no

				AND ED.from_date = (SELECT MAX(from_date) FROM EmpDept_Mod$
					WHERE emp_no = @inemp_no);
END;

EXECUTE Last_dept 10040;



--6 How many contracts have been registered in the ‘salaries’ table with duration of more than one year and
-- of value higher than or equal to $100,000? 

SELECT COUNT(*)
FROM Salary_Mod$
WHERE salary >= 100000 AND DATEDIFF(YEAR, from_date, to_date) >= 1;


--7 Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set the
--hire date to equal the current date. Format the output appropriately (YY-mm-dd). 

INSERT INTO Employees_Mod$ VALUES (244831, '1977-12-14', 'Suzy', 'Mahock', 'F', '2021-01-12');
INSERT INTO Employees_Mod$ VALUES (244830, '1978-06-11', 'Kati', 'Mehr', 'F', '2030-11-22');

DELETE FROM Employees_Mod$ WHERE emp_no=244830;


SELECT * FROM Employees_Mod$;

UPDATE Employees_Mod$ 
SET hire_date = GETDATE()
WHERE hire_date > GETDATE();

--OR

CREATE TRIGGER trig_hiredate ON Employees_Mod$
FOR UPDATE 
AS
BEGIN
  ALTER TABLE Employees_Mod$
  SET hire_date EQ GETDATE()
  WHERE hire_date > GETDATE()
END;



--8 Define a function that retrieves the largest contract salary value of an employee. 
--Apply it to employee number 11356. 

SELECT * FROM  Salary_Mod$;
INSERT INTO Salary_Mod$  VALUES (39051, 55900, '1992-07-2', '1997-05-11');

CREATE FUNCTION F_MaxSalary (@emp_no INT)
RETURNS DECIMAL(10,2) AS
BEGIN

DECLARE @MaxSalary DECIMAL(10,2)

SELECT @MaxSalary = MAX(Salary)
	FROM Salary_Mod$
	WHERE emp_no = @emp_no
RETURN @MaxSalary 
END;

SELECT dbo.F_MaxSalary (39256);
SELECT dbo.F_MaxSalary (39051);


CREATE FUNCTION F_MinSalary (@emp_no INT) 
RETURNS DECIMAL(10,2)
BEGIN

DECLARE @MinSalary DECIMAL(10,2)

SELECT @MinSalary = Min(Salary)
	FROM Salary_Mod$ 
	WHERE emp_no = @emp_no;
RETURN @MinSalary
END;

SELECT dbo.F_MinSalary (39256);
SELECT dbo.F_MinSalary (39051);


--9 Based on the previous exercise, you can now try to create a third function that also accepts 
--a second parameter. Let this parameter be a character sequence. Evaluate if its value is 'min' 
--or 'max' and based on that retrieve either the lowest or the highest salary, respectively (using 
--the same logic and code structure from Exercise 9). If the inserted value is any string value 
--different from ‘min’ or ‘max’, let the function return the difference between the highest and 
--the lowest salary of that employee. 


-- My Solution
CREATE FUNCTION F_salary (
						  @min_or_max VARCHAR(10),
						  @Column_name VARCHAR(10)
						  ) 
RETURNS DECIMAL(10,2) AS
BEGIN
DECLARE @Salary_info DECIMAL(10,2)
	SET @Salary_info = @Column_name
						
    IF (@min_or_max = 'min') 
		SET @Salary_info = MIN(@Column_name)
    IF (@min_or_max = 'max') 
		SET @Salary_info = MAX(@Column_name)
	
 
    RETURN @Salary_info
END;


SELECT dbo.F_salary('max', Salary) FROM Salary_Mod$
WHERE emp_no=39256;

SELECT emp_no, Salary FROM Salary_Mod$
WHERE emp_no = 39256;


--OR (Still Not Working)

CREATE FUNCTION F_salary2(@emp_no INT,
						  @min_or_max VARCHAR(10)
						  ) 
RETURNS DECIMAL(10,2) AS
BEGIN
DECLARE @Salary_info DECIMAL(10,2)
SELECT
    CASE
        WHEN @min_or_max = 'max' THEN MAX(salary)
        WHEN @min_or_max = 'min' THEN MIN(salary)
        ELSE MAX(salary) - MIN(salary)
    END AS salary_info		
	FROM Salary_Mod$
	WHERE emp_no = @emp_no		
  
RETURN @Salary_info 	
END;


SELECT dbo.F_salary('max', Salary) FROM Salary_Mod$
WHERE emp_no=39256;

SELECT emp_no, Salary FROM Salary_Mod$
WHERE emp_no = 39256;


-- Codes for MySQL

DELIMITER $$
CREATE FUNCTION f_salary (
	p_emp_no INTEGER, 
	p_min_or_max varchar(10)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_salary_info DECIMAL(10,2);

SELECT
    CASE
        WHEN p_min_or_max = 'max' THEN MAX(s.salary)
        WHEN p_min_or_max = 'min' THEN MIN(s.salary)
        ELSE MAX(s.salary) - MIN(s.salary)
    END AS salary_info
INTO v_salary_info 
FROM employees e
        JOIN salaries s 
			ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;

RETURN v_salary_info;
END$$

DELIMITER ;

SELECT employees.f_salary(11356, 'min');
SELECT employees.f_salary(11356, 'max');
SELECT employees.f_salary(11356, 'mmm');

---------