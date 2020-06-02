CREATE DATABASE Cover;

CREATE TABLE install (
Userid INT NOT Null primary key, 
Gender CHAR(1),
Age INT,
Installation_date DATETIME);



INSERT INTO install VALUES (001, 'M', 34, '2019-10-09 23:20'),
						   (002, 'F', 54, '2019-09-08 18:22'),
						   (003, 'F', 55, '2019-10-23 20:56'),
						   (004, 'M', 45, '2018-08-08 10:15'),
						   (005, 'M', 33, '2017-12-14 19:54');

CREATE TABLE quote (
Quoteid INT NOT Null primary key,
Userid INT NOT Null, 
QuoteType VARCHAR(10),
Quote_date DATETIME);

ALTER TABLE quote ADD FOREIGN KEY (Userid) REFERENCES install(Userid);

INSERT INTO quote VALUES (123, 001, 'Auto', '2019-10-09 23:54'),
						 (124, 001, 'Home', '2019-10-10 00:15'),
						 (125, 003, 'Auto', '2019-10-23 22:10'),
						 (126, 003, 'Home', '2019-10-23 22:45'),
						 (127, 003, 'Health', '2019-10-23 23:00'),
						 (128, 003, 'Life', '2019-10-23 23:10'),
						 (129, 005, 'Home', '2017-12-14 20:15');



CREATE TABLE contact (
contactid INT NOT Null primary key,
Quoteid INT NOT Null, 
contact_date DATETIME);

ALTER TABLE contact ADD FOREIGN KEY (Quoteid) REFERENCES quote(Quoteid);

INSERT INTO contact VALUES (555, 123, '2019-10-10 17:54'),
					   	   (561, 123, '2019-10-11 18:00'),
						   (556, 124, '2019-10-10 17:54'),
						   (557, 125, '2019-10-25 20:00'),
						   (558, 126, '2019-10-25 20:10'),
						   (559, 127, '2019-10-25 20:20'),
						   (560, 128, '2019-10-25 20:30'),
						   (562, 129, '2017-12-14 21:40'),
						   (563, 129, '2017-12-15 21:40');

DROP TABLE install;
DROP TABLE quote;
DROP TABLE contact;


CREATE TABLE sale (
Saleid INT NOT Null primary key,
contactid INT NOT Null, 
sold_date DATETIME);

ALTER TABLE sale ADD FOREIGN KEY (contactid) REFERENCES contact(contactid);

INSERT INTO sale VALUES (1000, 555, '2019-10-10 18:45'),
					   	(1001, 557, '2019-10-25 20:50');

SELECT * FROM install;
SELECT AVG(Age) FROM install;

SELECT Userid, COUNT(Userid) AS qty_user FROM quote
GROUP BY Userid;

SELECT Q.quoteid, contactid, QuoteType, Quote_date, contact_date FROM 
	quote Q JOIN contact C
	ON Q.Quoteid = C.Quoteid
	WHERE QuoteType = 'Home';

CREATE VIEW rate AS
SELECT 
COUNT(MONTH(contact_date)) AS M_contact, 
COUNT(MONTH(sold_date)) AS M_sale
FROM contact C
LEFT JOIN sale S
ON C.contactid = S.contactid
GROUP BY MONTH(contact_date);

SELECT * FROM rate;


SELECT *, M_sale*1.0/M_contact AS Rate, M_contact+M_sale, M_contact*M_sale, M_sale%M_contact
FROM rate;













