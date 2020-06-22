---SQL Project 18-10-2019
--- Financial Service Database


CREATE DATABASE Financial_Ins;

----------------------------------------
-- Phase 1 Table Creation
----------------------------------------
-- Creating tables 1: 'LoginErrorLog';
----------------------------------------

CREATE TABLE LoginErrorLog
(
	ErrorLogID INT NOT NULL PRIMARY KEY,
	ErrorTime DATETIME,
    FailesTransactionXML VARCHAR(20)
    );
    
INSERT INTO LoginErrorLog (ErrorLogID, ErrorTime, FailesTransactionXML)
VALUES (100,'2019-01-01 02:10:56','Wonderful');
INSERT INTO LoginErrorLog (ErrorLogID, ErrorTime, FailesTransactionXML)
VALUES (101,'2019-10-11 04:45:06','Beautiful');
INSERT INTO LoginErrorLog (ErrorLogID, ErrorTime, FailesTransactionXML)
VALUES (102,'2018-12-15 10:17:15','Marvellous');
INSERT INTO LoginErrorLog (ErrorLogID, ErrorTime, FailesTransactionXML)
VALUES (103,'2017-03-11 08:23:42','Fascinating');

SELECT * FROM LoginErrorLog;


----------------------------------------------------
-- Creating tables 2: 'FailedTransactionErrorType';
----------------------------------------------------

CREATE TABLE FailedTransactionErrorType
(
	FailedTransactionErrorTypeID TINYINT NOT NULL PRIMARY KEY,
	FailedTransactionDescription VARCHAR(50)
    );

	
INSERT INTO FailedTransactionErrorType (FailedTransactionErrorTypeID, FailedTransactionDescription)
VALUES (12,'Out of Order');
INSERT INTO FailedTransactionErrorType (FailedTransactionErrorTypeID, FailedTransactionDescription)
VALUES (15,'too many attempts');
INSERT INTO FailedTransactionErrorType (FailedTransactionErrorTypeID, FailedTransactionDescription)
VALUES (17,'Insufficient fund');
INSERT INTO FailedTransactionErrorType (FailedTransactionErrorTypeID, FailedTransactionDescription)
VALUES (20,'Delayed');
INSERT INTO FailedTransactionErrorType (FailedTransactionErrorTypeID, FailedTransactionDescription)
VALUES (25,'No Connection');

SELECT * FROM FailedTransactionErrorType;


----------------------------------------------
-- Creating tables 3: 'FailedTransactionLog';
----------------------------------------------

CREATE TABLE FailedTransactionLog
(
	FailedTransactionID INT NOT NULL PRIMARY KEY,
	FailedTransactionErrorTypeID TINYINT,
    FailedTransactionErrorTime DATETIME,
    FailesTransactionXML VARCHAR(20)
    );

ALTER TABLE FailedTransactionLog
	ADD FOREIGN KEY (FailedTransactionErrorTypeID) 
		REFERENCES FailedTransactionErrorType (FailedTransactionErrorTypeID)
			ON DELETE CASCADE;
            
    
INSERT INTO FailedTransactionLog 
	(FailedTransactionID, FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailesTransactionXML)
	VALUES (200, 12, '2018-07-07 02:10:56','Cloudy');
INSERT INTO FailedTransactionLog 
	(FailedTransactionID, FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailesTransactionXML)
	VALUES (350, 25, '2017-09-17 10:10:05','Rainy');   
INSERT INTO FailedTransactionLog
	(FailedTransactionID, FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailesTransactionXML)
	VALUES (440, 25, '2017-12-15 11:16:16','Snowy');
INSERT INTO FailedTransactionLog
	(FailedTransactionID, FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailesTransactionXML)
	VALUES (510, 15, '2019-09-23 10:52:05','Windy');  
INSERT INTO FailedTransactionLog
	(FailedTransactionID, FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailesTransactionXML)
	VALUES (670, 20, '2016-10-22 11:22:15','Thunder');  
    

SELECT * FROM FailedTransactionLog; 
    

------------------------------------
-- Creating tables 4: 'AccountType';
------------------------------------

CREATE TABLE AccountType
(
	AccountTypeID TINYINT NOT NULL PRIMARY KEY,
    AccountTypeDescription VARCHAR(30)
    );
    

INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (1, 'Chequing');
INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (2, 'Saving');    
INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (3, 'High Interest Saving');
INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (4, 'Tax Free Saving');
INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (5, 'RRSP');
INSERT INTO AccountType (AccountTypeID, AccountTypeDescription)
	VALUES (6, 'RESP');

SELECT * FROM AccountType;



------------------------------------------
-- Creating tables 5: 'AccountStatusType';
------------------------------------------

CREATE TABLE AccountStatusType
(
	AccountStatusTypeID TINYINT NOT NULL PRIMARY KEY,
    AccountStatusTypeDescription VARCHAR(30)
    );
    

INSERT INTO AccountStatusType
	(AccountStatusTypeID, AccountStatusTypeDescription)
	VALUES (1, 'Actice');
INSERT INTO AccountStatusType
	(AccountStatusTypeID, AccountStatusTypeDescription)
	VALUES (2, 'Inactive');    
INSERT INTO AccountStatusType
	(AccountStatusTypeID, AccountStatusTypeDescription)
	VALUES (3, 'Blocked');
INSERT INTO AccountStatusType
	(AccountStatusTypeID, AccountStatusTypeDescription)
	VALUES (4, 'Close');


SELECT * FROM AccountStatusType;


-----------------------------------
-- Creating tables 6: 'UserLogins';
-----------------------------------

CREATE TABLE UserLogins
(
	UserLoginID SMALLINT NOT NULL PRIMARY KEY,
    UserLogin CHAR(30),
    UserPassword VARCHAR(20)
    );
    

INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001013, 'Alice_Polite', 'Alllisp2017');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001017, 'Peterggg', 'jurassic*j');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001011, 'KatiaMerci', 'KM_3000_2000C');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001014, 'Shane.Moris', 'SHMES*SHMES**');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001015, 'Sara.Copler', 'Solar*System');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001016, 'David Humings', 'DHUMDHUM29');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001012, 'Daisy Better', 'Flower456');
INSERT INTO UserLogins
	(UserLoginID, UserLogin, UserPassword)
	VALUES (001018, 'MikeyMouse', 'Hollywood123');


SELECT * FROM UserLogins;


---------------------------------------------
-- Creating tables 7: 'UserSecurityQuestions';
---------------------------------------------

CREATE TABLE UserSecurityQuestions
(
	UserSecurityQuestionID TINYINT NOT NULL PRIMARY KEY,
    UserSecurityQuestion VARCHAR(50)
    );


INSERT INTO UserSecurityQuestions
	(UserSecurityQuestionID, UserSecurityQuestion)
	VALUES (10, 'What is your first pet''s name?');
INSERT INTO UserSecurityQuestions
	(UserSecurityQuestionID, UserSecurityQuestion)
	VALUES (20, 'Where is the first county you have visited?');
INSERT INTO UserSecurityQuestions
	(UserSecurityQuestionID, UserSecurityQuestion)
	VALUES (30, 'What is your mom''s middle name');
INSERT INTO UserSecurityQuestions
	(UserSecurityQuestionID, UserSecurityQuestion)
	VALUES (40, 'What is your favorite color?');


SELECT * FROM UserSecurityQuestions;
    
--DELETE FROM UserSecurityQuestions WHERE UserSecurityQuestionsID=20;

----------------------------------------------
-- Creating tables 8: 'SavingsInterestRates';
----------------------------------------------

CREATE TABLE SavingsInterestRates
(
	InterestSavingsRateID INT NOT NULL PRIMARY KEY,
    InterestRateValue NUMERIC(9,9),
	InterestRateDescription VARCHAR(20)
    );  

-- DROP TABLE SavingsInterestRates;

INSERT INTO SavingsInterestRates
	(InterestSavingsRateID, InterestRateValue,InterestRateDescription)
	VALUES
		(999,  0.000, 'No Interest'), 
		(1000, 0.0075, 'Low Interest'),
		(1001, 0.0125, 'High Interest'),
		(1002, 0.0310, 'Mutual Fund'),
		(1003, 0.0225, 'Bond');
	
		
SELECT * FROM  SavingsInterestRates;


----------------------------------------------
-- Creating tables 9: 'UserSecurityAnswer';
----------------------------------------------

CREATE TABLE UserSecurityAnswer
(
	UserLoginID SMALLINT NOT NULL PRIMARY KEY,
    UserSecurityAnswer VARCHAR(25),
	UserSecurityQuestionID TINYINT 
    ); 

ALTER TABLE UserSecurityAnswer
	ADD FOREIGN KEY (UserLoginID) 
		REFERENCES UserLogins (UserLoginID) 
			ON DELETE CASCADE;	

ALTER TABLE UserSecurityAnswer
	ADD FOREIGN KEY (UserSecurityQuestionID) 
		REFERENCES UserSecurityQuestions (UserSecurityQuestionID) 
			ON DELETE CASCADE;	

INSERT INTO UserSecurityAnswer
	(UserLoginID, UserSecurityAnswer,UserSecurityQuestionID)
	VALUES 
		(001011, 'Rover',10),
		(001012, 'SnowBall',10),
		(001013, 'Japan',20),
		(001014, 'Melani',30),
		(001015, 'Peach', 40),
		(001016, 'Natali', 30),
		(001017, 'Turkey', 20);


SELECT * FROM UserSecurityAnswer;


--INSERT INTO UserSecurityAnswer
--	(UserLoginID, UserSecurityAnswer,UserSecurityQuestionID)
--	VALUES (001012, 'Rover',50);--->Ends in Error Constraint Works, no question 50


----------------------------------------------
-- Creating tables 10: 'TransactionType';
----------------------------------------------

CREATE TABLE TransactionType
(
	TransactionTypeID TINYINT NOT NULL PRIMARY KEY,
    TransactionTypeName VARCHAR(50),
	TransactionFeeAmount SMALLMONEY
    ); 

INSERT INTO TransactionType
	(TransactionTypeID, TransactionTypeName, TransactionFeeAmount)
	VALUES 
		(11, 'Express', 2.5),
		(12, 'Easy', 1.1),
		(13, 'Next Day', 0.89),
		(14, 'Clients', 0),
		(15, 'Business', 4.9);


SELECT * FROM TransactionType;


----------------------------------------------
-- Creating tables 11: 'Employee';
----------------------------------------------

CREATE TABLE Employee
(
	EmployeeID INT NOT NULL PRIMARY KEY,
    EmployeeFirstName VARCHAR(25),
	EmployeeMiddleInitial CHAR(1),
	EmployeeLastName VARCHAR(25),
	EmployeeManager BIT
); 

--- DROP TABLE Employee;

INSERT INTO Employee
	VALUES 
	(12345, 'Kati', NULL , 'Mehr', 1),
	(12346, 'Leanna', 'D', 'Massah', 0),
	(12347, 'Meloryna', 'I', 'Massah', 0),
	(12348, 'Karen', NULL , 'Honar', 0),
	(12349, 'Peter', 'J', 'Tolkin', 1),
	(12350, 'Sheida', NULL , 'Rostam', 0),
	(12351,	'David', 'L', 'Louis', 1),
	(12352,	'Natan', 'F', 'Graham', 0);

SELECT * FROM Employee;


----------------------------------------------
-- Creating tables 12: 'Account';
----------------------------------------------

CREATE TABLE Account
(
	AccountID INT NOT NULL PRIMARY KEY,
    CurrentBalance INT,
	AccountTypeID TINYINT FOREIGN KEY REFERENCES AccountType (AccountTypeID),
	AccountStatusTypeID TINYINT FOREIGN KEY REFERENCES AccountStatusType (AccountStatusTypeID),
	InterestSavingsRateID INT FOREIGN KEY REFERENCES SavingsInterestRates (InterestSavingsRateID)
); 

INSERT INTO Account
	VALUES 
	(21200, 2000, 1, 1, 999),
	(21210, 23050, 2, 4, 1000),
	(21212, 34098, 1, 1, 999),
    (21215, 560, 2, 1, 1000),
    (21220, 350987, 2, 2, 1000),
    (21232, 10000, 5, 1, 1003),
    (21254, 230500, 6, 4, 1002),
	(21260, 20000, 1, 1, 999),
    (21270, 56000, 2, 1, 1000),
    (21280, 35098, 2, 2, 1000),
    (21290, 10000, 1, 1, 999),
	(21312, 2000, 2, 1, 1000),
    (21315, 56000, 5, 1, 1002),
    (21320, 3000, 1, 2, 999),
    (21332, 100000, 1, 1, 999),
    (21354, 230, 4, 4, 1002),
	(21360, 200000, 5, 1, 1003),
	(21380, 2000, 1, 1,999);


SELECT * FROM Account;


----------------------------------------------
-- Creating tables 13: 'OverDraftLog';
----------------------------------------------

CREATE TABLE OverDraftLog
(
	AccountID INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Account (AccountID),
    OverDraftDate DATETIME,
	OverDraftAmount MONEY,
	OverDraftTransactionXML VARCHAR(20)
); 

INSERT INTO OverDraftLog
	VALUES 
	(21212, '2018-10-25 02:23:56', 2500, 'Wrong'),
    (21215, '2019-05-06 01:34:12', 1234, 'Wrong'),
    (21220, '2016-11-14 12:45:07', 34.50, 'Wrong'),
    (21232, '2019-08-14 13:56:48', 100, 'Invalid Pin'),
    (21254, '2018-10-05 23:45:16', 1345, 'Wrong');


SELECT * FROM OverDraftLog;


----------------------------------------------
-- Creating tables 14: 'Customer';
----------------------------------------------

CREATE TABLE Customer
(
	CustomerID INT NOT NULL PRIMARY KEY,
    CustomerAddress1 VARCHAR (30),
	CustomerAddress2 VARCHAR (30),
	CustomerFirstName VARCHAR (30),
	CustomerMiddleName CHAR (1),
	CustomerLastName VARCHAR (30),
	City VARCHAR (20),
	Province CHAR (2),
	ZipCode VARCHAR (10),
	EmailAddress VARCHAR (40),
	HomePhone CHAR(10),
	CellPhone CHAR(10),
	WorkPhone CHAR(10),
	SSN CHAR(9),
	UserLoginID SMALLINT FOREIGN KEY REFERENCES Userlogins (UserLoginID)
); 


INSERT INTO Customer
	VALUES 
	(50000, '10 Grenoble Dr', 'Apt 600', 'Lauren', 'K', 'Foster', 'Toronto', 'ON', 'M3C1C6', 
		'LAUREN_F@yahoo.com', 6476476470, NULL ,NULL , NULL , 001012),
	(50001, '10 Milway Rd', NULL, 'Samoel', 'L', 'Jackson', 'Toronto', 'ON', 'G3R5T6', 
		'Samoel_lj@yahoo.com', 6478541234, 4168790134 , 4164157890 , 222 , 001011),
	(50002, '176 Shoorby Dr', NULL, 'Jenny', 'p', 'Thompson', 'Toronto', 'ON', 'K8Y5T6', 
		'Jenny_j@yahoo.com', 6474567345, NULL , NULL , NULL , 001013),
	(50003, '76 Maisonove St', NULL, 'Soheil', NULL, 'Hesari', 'Montreal', 'QC', 'H4B1N9', 
		'SoheilHesari@yahoo.com', 5143678654, NULL , NULL , NULL , 001018),
	(50004, '100 Shonas St', 'Apt 45', 'Gery', 'T', 'Mollan', 'Victoria', 'BC', 'P8Y6G8', 
		'SoheilHesari@yahoo.com', 645378654, NULL , NULL , NULL , 001014),
	(50005, '100 Shonas St', 'Apt 45', 'Gery', 'T', 'Mollan', 'Victoria', 'BC', 'P8Y6G8', 
		'SoheilHesari@yahoo.com', 645378654, NULL , NULL , NULL , 001014),
	(50006, '1280 Donmills Rd', 'Apt 150', 'Mira', 'R', 'Potamous', 'Toronto', 'ON', 'M3C6W8', 
		'MiraPotamous@yahoo.com', 6478900654, NULL , NULL , NULL , 001015),
	(50007,	'23 Tirol Rd', '', 'Tiana', 'A', 'Moslen', 'Toronto', 'ON',	'K8Y5T6', 'Tiana_m@gmail.com', 6471111111, 
	4161111111, Null, 111, 1016),
    (50008,	'55 Broad St', 'Apt 100', 'Robert', 'E', 'Labeuff', 'Montreal', 'QC', 'H5R4E6', 'Robert_ll@yahoo.com', 
	5145145144, NULL, NULL, 333, 1017);

-- UPDATE Customer SET UserLoginID=001013 WHERE CustomerID=50005;


SELECT * FROM Customer;



----------------------------------------------
-- Creating tables 15: 'CustomerAccount';
----------------------------------------------

CREATE TABLE CustomerAccount
(
    AccountID INT FOREIGN KEY REFERENCES Account (AccountID),
	CustomerID INT FOREIGN KEY REFERENCES Customer (CustomerID)
);

INSERT INTO CustomerAccount
	VALUES (21210, 50000),
		   (21212, 50001),
		   (21312, 50001),
		   (21215, 50002),
		   (21315, 50002),
		   (21220, 50003),
		   (21320, 50003),
		   (21232, 50004),
		   (21260, 50004),
		   (21270, 50008),
		   (21280, 50008),
		   (21290, 50006),
		   (21254, 50007),
		   (21380, 50007);

-- DELETE FROM CustomerAccount
-- WHERE AccountID=21332;

SELECT * FROM CustomerAccount
	ORDER BY AccountID;

----------------------------------------------
-- Creating tables 16: 'LoginAccount';
----------------------------------------------

CREATE TABLE LoginAccount
(
    UserLoginID SMALLINT FOREIGN KEY REFERENCES UserLogins (UserLoginID),
	AccountID INT FOREIGN KEY REFERENCES Account (AccountID)
);

INSERT INTO LoginAccount
	VALUES 
		(001011, 21212),
		(001012, 21215),
		(001013, 21220),
		(001014, 21220),
		(001015, 21232),
		(001016, 21232),
		(001017, 21254);


SELECT * FROM LoginAccount;


----------------------------------------------
-- Creating tables 17: 'TransactionLog';
----------------------------------------------

CREATE TABLE TransactionLog
(
    TransactionID INT NOT NULL PRIMARY KEY,
	TransactionDate DATETIME,
	TransactionTypeID TINYINT FOREIGN KEY REFERENCES TransactionType (TransactionTypeID),
	TransactionAmount MONEY,
	NewBalance MONEY,
	AccountID INT FOREIGN KEY REFERENCES Account (AccountID),
	CustomerID INT FOREIGN KEY REFERENCES Customer (CustomerID),
	EmployeeID INT FOREIGN KEY REFERENCES Employee (EmployeeID),
	UserLoginID SMALLINT FOREIGN KEY REFERENCES Userlogins (UserloginID)
);

--- DROP TABLE TransactionLog;

INSERT INTO TransactionLog
	VALUES 
		(991, '2018-09-18 08:56:10', 11, 200, 23450, 21212, 50001, 12345, 001011),
		(992, '2019-04-26 10:40:20', 12, 400, 1570, 21220, 50002, 12346, 001012),
		(993, '2009-05-21 11:25:25', 13, 500, 1245677, 21232, 50003, 12346, 001013),
		(994, '2010-12-16 16:46:22', 12, 1000, 23560, 21254, 50004, 12347, 001014),
		(995, '2011-04-11 20:11:06', 14, 450, 10000, 21232, 50005, 12347, 001015),
		(996, '2012-09-23 22:18:17', 15, 5550, 1200000, 21212, 50006, 12348, 001016),
		(997, '2017-09-19 23:23:16', 11, 1150, 170000, 21254, 50006, 12349, 001017);


SELECT * FROM TransactionLog;


--------------------------------------------------------------------------------
-- Phase 2 Queries
--------------------------------------------------------------------------------
--1- Create a view to get all customers with checking account from ON province.
---- Create a view to get all customers with SAVING account from ON or QC province.
--------------------------------------------------------------------------------

CREATE VIEW View_1 AS
SELECT C.CustomerID, CustomerFirstName, CustomerLastName, City, Province, UserLoginID, CA.AccountID, AT.AccountTypeDescription
	FROM Customer C
		JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				JOIN Account A
					ON A.AccountID=CA.AccountID
						JOIN AccountType AT
							ON AT.AccountTypeID=A.AccountTypeID
								WHERE A.AccountTypeID=1 AND Province='ON'
								;									
CREATE VIEW View_11 AS
SELECT C.CustomerID, CustomerFirstName, CustomerLastName, City, Province, UserLoginID, CA.AccountID, AT.AccountTypeDescription
	FROM Customer C
		LEFT JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				LEFT JOIN Account A
					ON A.AccountID=CA.AccountID
						LEFT JOIN AccountType AT
							ON AT.AccountTypeID=A.AccountTypeID
								WHERE A.AccountTypeID=2 AND (Province='ON' or Province='QC')
								;	
--- DROP VIEW View_11;

SELECT * FROM View_1;
SELECT * FROM View_11;



--------------------------------------------------------------------------------
--2- Create a view to get all customers with total account balance 
---- (including interest rate) greater than 5000
--------------------------------------------------------------------------------

CREATE VIEW View_2 AS
SELECT C.CustomerID, CustomerFirstName, CustomerLastName, UserLoginID, CA.AccountID, A.AccountTypeID,
A.CurrentBalance, SIR.InterestRateValue,
	(A.CurrentBalance+A.CurrentBalance * SIR.InterestRateValue) AS Account_Balance_With_Interest
	FROM Customer C
		LEFT JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				LEFT JOIN Account A
					ON A.AccountID=CA.AccountID
						LEFT JOIN SavingsInterestRates SIR
							ON A.InterestSavingsRateID = SIR.InterestSavingsRateID
							;							
--- DROP VIEW View_2;

SELECT * FROM View_2;


SELECT CustomerFirstName, CustomerLastName, SUM(Account_Balance_With_Interest) As Total_Balance_With_Intetest
	FROM View_2
		GROUP BY  CustomerFirstName, CustomerLastName
			HAVING SUM(Account_Balance_With_Interest) > 5000
			;

--------------------------------------------------------------------------------
--3- Create a view to get counts of checking and savings accounts by customer.
---- Create a view to get counts of any accounts by customer.
--------------------------------------------------------------------------------

CREATE VIEW View_3 AS
SELECT C.CustomerID, COUNT(AccountTypeID) AS NumberOfAccounts
	FROM Customer C
		LEFT JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				LEFT JOIN Account A
					ON A.AccountID=CA.AccountID
						WHERE AccountTypeID=1 OR AccountTypeID=2
						GROUP BY C.CustomerID;

CREATE VIEW View_33 AS
SELECT C.CustomerID, COUNT(AccountTypeID) AS NumberOfAccounts
	FROM Customer C
		LEFT JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				LEFT JOIN Account A
					ON A.AccountID=CA.AccountID
						GROUP BY C.CustomerID;

SELECT * FROM View_3;
SELECT * FROM View_33;

--------------------------------------------------------------------------------
--4- Create a view to get any particular user’s login and password using AccountId.
--------------------------------------------------------------------------------

CREATE VIEW View_4 AS
SELECT LA.AccountID, UserLogin, UserPassword --, EmployeeFirstName, EmployeeLastName
	FROM UserLogins UL
		LEFT JOIN LoginAccount LA
			ON UL.UserLoginID = LA.UserLoginID;

	--			JOIN TransactionLog TL
	--				ON TL.UserLoginID = LA.UserLoginID
	--					JOIN Employee E
	--						ON E.EmployeeID = TL.EmployeeID

SELECT * FROM View_4;


--------------------------------------------------------------------------------
--5- Create a view to get all customers’ overdraft amount.
--------------------------------------------------------------------------------

CREATE VIEW View_5 AS
SELECT C.CustomerID, CustomerFirstName, CustomerLastName, CA.AccountID, OverDraftAmount 
	FROM Customer C
		LEFT JOIN CustomerAccount CA
			ON C.CustomerID = CA.CustomerID
				LEFT JOIN Account A
					ON A.AccountID=CA.AccountID
						LEFT JOIN OverDraftLog ODL
							ON A.AccountID=ODL.AccountID;
							
	
SELECT * FROM View_5
	WHERE OverDraftAmount IS NOT NULL;

--- DROP VIEW View_5;

--------------------------------------------------------------------------------
--6- Create a stored procedure to add “User_” as a prefix to everyone’s login 
---- Create a stored procedure to remove “User_” as a prefix from everyone’s login 
--------------------------------------------------------------------------------

CREATE PROC Proc_1 AS
BEGIN
	UPDATE  UserLogins 
		SET UserLogin = 'User_' + UserLogin 
END;

EXECUTE Proc_1;

SELECT * FROM UserLogins;




CREATE PROC Proc_11 AS
BEGIN
	UPDATE  UserLogins 
		SET UserLogin = REPLACE (UserLogin, 'User_', '')  
END;

EXECUTE Proc_11;

SELECT * FROM UserLogins;


--------------------------------------------------------------------------------
--7- Create a stored procedure that accepts AccountId as a parameter and returns 
---- customer’s full name. 
--------------------------------------------------------------------------------

CREATE PROC Proc_2 @AccountID INT AS
BEGIN
	SELECT DISTINCT AccountID, CustomerFirstName, CustomerMiddleName, CustomerLastName
		FROM Customer C
			LEFT JOIN CustomerAccount CA
				ON C.CustomerID = CA.CustomerID
				WHERE AccountID = @AccountID
END;

EXECUTE Proc_2 '21280';

-- DROP PROC Proc_2;


--------------------------------------------------------------------------------
--8- Create a stored procedure that takes a deposit as a parameter and updates 
---- CurrentBalance value for that particular account.
--------------------------------------------------------------------------------

CREATE PROC Proc_3 @Deposit FLOAT, @New_Balance FLOAT OUTPUT AS
BEGIN
 SELECT AccountID, CurrentBalance, @Deposit AS Deposit, New_Balance = CurrentBalance + @Deposit FROM Account
END;

-- DROP PROC Proc_3;


DECLARE @New_Total_Balane FLOAT;
EXECUTE Proc_3 1000, @New_Total_Balane OUTPUT;
PRINT @New_Total_Balane;


--------------------------------------------------------------------------------
--9- Create a stored procedure that takes a withdrawal amount as a parameter for
---- specifict account and updates CurrentBalance value. 
---- Create a stored procedure that takes a withdrawal amount as a parameter for
---- all the accounts and updates CurrentBalance value. 
--------------------------------------------------------------------------------

CREATE PROC Proc_4 @WithdrawalAmount FLOAT, @AccountID INT, @NewBalance FLOAT OUTPUT AS
BEGIN
	UPDATE Account
	SET CurrentBalance = CurrentBalance - @WithdrawalAmount 
		WHERE AccountID=@AccountID
END;


-- DROP PROC Proc_4;


DECLARE @New_Balane FLOAT;
EXECUTE Proc_4 200, 21200, @New_Balane OUTPUT;
PRINT @New_Balane;

SELECT AccountID, CurrentBalance FROM Account;

-- deduct For all the users
CREATE PROC Proc_44 @WithdrawalAmount FLOAT, @New_Balance FLOAT OUTPUT AS
BEGIN
 SELECT AccountID, CurrentBalance, @WithdrawalAmount AS Withdrawal, 
		New_Balance = CurrentBalance - @WithdrawalAmount FROM Account
END;

DECLARE @New_Total_Balane FLOAT;
EXECUTE Proc_44 200, @New_Total_Balane OUTPUT;
PRINT @New_Total_Balane;


--------------------------------------------------------------------------------
--10- Write a query to remove SSN column from Customer table. 
--------------------------------------------------------------------------------

-- ALTER TABLE Customer
-- ADD SSN1 int NULL;

-- SELECT * FROM Customer;

ALTER TABLE Customer
	DROP COLUMN SSN;
	

------------------------THE END -------------------------------------------------	
	
	
	
	
	
	
	
	



------------------------THE END ------------------------------ 
