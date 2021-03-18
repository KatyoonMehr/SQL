

CREATE DATABASE Cover;

USE Cover;
----------------------------------------
-- Creating tables
----------------------------------------

CREATE TABLE install(
	Userid INT NOT NULL PRIMARY KEY, 
	Gender CHAR(1),
	Age INT,
	Installation_date DATETIME
	);

INSERT INTO install VALUES (001, 'M', 34, '2019-10-09 23:20'),
						   (002, 'F', 54, '2019-09-08 18:22'),
						   (003, 'F', 55, '2019-10-23 20:56'),
						   (004, 'M', 45, '2018-08-08 10:15'),
						   (005, 'M', 33, '2017-12-14 19:54');

SELECT * FROM install;
----------------------------------------

CREATE TABLE quote (
	Quoteid INT NOT NULL PRIMARY KEY,
	Userid INT NOT NULL, 
	QuoteType VARCHAR(10),
	Quote_date DATETIME
	);

ALTER TABLE quote ADD FOREIGN KEY (Userid) REFERENCES install(Userid);

INSERT INTO quote VALUES (123, 001, 'Auto', '2019-10-09 23:54'),
						 (124, 001, 'Home', '2019-10-10 00:15'),
						 (125, 003, 'Auto', '2019-10-23 22:10'),
						 (126, 003, 'Home', '2019-10-23 22:45'),
						 (127, 003, 'Health', '2019-10-23 23:00'),
						 (128, 003, 'Life', '2019-10-23 23:10'),
						 (129, 005, 'Home', '2017-12-14 20:15'),
						 (130, 002, 'Auto', '2019-08-09 20:54');
SELECT * FROM quote;
----------------------------------------

CREATE TABLE contact (
	contactid INT NOT Null primary key,
	Quoteid INT NOT Null, 
	contact_date DATETIME
	);

ALTER TABLE contact ADD FOREIGN KEY (Quoteid) REFERENCES quote(Quoteid);

INSERT INTO contact VALUES (555, 123, '2019-10-10 17:54'),
					   	   (561, 123, '2019-10-11 18:00'),
						   (556, 124, '2019-10-10 17:54'),
						   (557, 125, '2019-10-25 20:00'),
						   (558, 126, '2019-10-25 20:10'),
						   (559, 127, '2019-10-25 20:20'),
						   (560, 128, '2019-10-25 20:30'),
						   (562, 129, '2017-12-14 21:40'),
						   (563, 129, '2017-12-15 21:40'),
						   (564, 127, '2019-11-20 17:54');

SELECT * FROM contact;

SELECT * FROM contact
ORDER BY Quoteid;

SELECT *, MONTH(contact_date) AS Month FROM contact;
----------------------------------------

CREATE TABLE sale (
	Saleid INT NOT Null primary key,
	contactid INT NOT Null, 
	sold_date DATETIME);

ALTER TABLE sale ADD FOREIGN KEY (contactid) REFERENCES contact(contactid);

INSERT INTO sale VALUES (1000, 555, '2019-10-10 18:45'),
					   	(1001, 557, '2019-10-25 20:50'),
					    (1002, 561, '2019-11-20 08:45'),
					   	(1003, 563, '2019-12-12 20:50');

SELECT * FROM sale;
SELECT *, MONTH(sold_date) AS Month FROM sale;
----------------------------------------
-- DROP TABLE install;
-- DROP TABLE quote;
-- DROP TABLE contact;
-- DROP TABLE sale;


----------------------------------------
--Queries
----------------------------------------

SELECT * FROM Quote Q 
	FULL JOIN Contact C
		ON Q.Quoteid=C.Quoteid;

ALTER TABLE install ALTER COLUMN Age DECIMAL(4,2);

--What is average age of the users?
SELECT AVG(Age) AS 'Average Age' FROM install;

SELECT Gender, AVG(Age) AS 'Average Age' FROM install
	GROUP BY Gender;

-- How many quots each user got?
SELECT COUNT(Userid) AS qty_user FROM quote;

SELECT Userid, COUNT(Userid) AS quote_no FROM quote
GROUP BY Userid;

SELECT Userid, COUNT(Quoteid) AS quote_no FROM quote
GROUP BY Userid;

				
-- The detail for specific type of quotes
CREATE VIEW View_1 AS
SELECT Q.userid, Q.quoteid, contactid, QuoteType, Quote_date, contact_date FROM 
	quote Q 
		LEFT JOIN contact C
			ON Q.Quoteid = C.Quoteid
				;

SELECT * FROM View_1
	WHERE QuoteType = 'Home';


-- Count number of quote, contact and sale in each month

CREATE VIEW View_2 AS
	SELECT 
	MONTH(quote_date) AS M_quote, COUNT(quoteid) AS NumberOfQuote
	FROM quote
	GROUP BY MONTH(quote_date);

SELECT * FROM View_2;


SELECT MONTH(quote_date) AS M_quote, COUNT(quoteid) AS NumberOfQuote
	FROM quote
	GROUP BY MONTH(quote_date)
	HAVING MONTH(quote_date) >=10;


CREATE VIEW View_3 AS
	SELECT 
	MONTH(contact_date) AS M_contact, COUNT(contactid) AS NumberOfContact
	FROM contact
	GROUP BY MONTH(contact_date);

SELECT * FROM View_3;


CREATE VIEW View_4 AS
	SELECT 
	MONTH(sold_date) AS M_sold , COUNT(saleid) AS NumberOfSale
	FROM Sale
	GROUP BY MONTH(sold_date);

SELECT * FROM View_4;



-- what is the conversion rate (#ofsale/#ofcontact)

CREATE VIEW total_rate AS
	SELECT 
	COUNT(C.contactid) AS NumberOfContact, 
	COUNT(S.saleid) AS NumberOfSale
	FROM contact C
		LEFT JOIN sale S
			ON C.contactid = S.contactid
				;

SELECT * FROM total_rate;

SELECT *, ROUND(NumberOfSale*1.0/NumberOfContact,2) AS Total_Rate
FROM total_rate;


-- what is the conversion rate (#ofsale/#ofcontact) in each month

CREATE VIEW monthly_rate AS
SELECT *
FROM View_3
INNER JOIN View_4 ON View_3.M_contact = View_4.M_sold;


SELECT * FROM monthly_rate;


SELECT *, NumberOfSale*1.0/NumberOfContact AS Rate
FROM monthly_rate;
