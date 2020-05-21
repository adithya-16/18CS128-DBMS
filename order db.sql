use orderdb;

CREATE TABLE SALESMAN (
	SALESMAN_ID integer, 
	NAME varchar(20), 
	CITY varchar(20), 
	COMMISSION varchar(20), 
	PRIMARY KEY (SALESMAN_ID)
);

CREATE TABLE CUSTOMER (
	CUSTOMER_ID integer,
	CUST_NAME varchar(20), 
	CITY varchar(20), 
	GRADE integer,
    SALESMAN_ID integer,
	PRIMARY KEY (CUSTOMER_ID), 
	foreign key (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE SET NULL
);

CREATE TABLE ORDERS (
	ORD_NO integer, 
	PURCHASE_AMT integer, 
	ORD_DATE DATE, 
	CUSTOMER_ID integer,
    SALESMAN_ID integer,
	PRIMARY KEY (ORD_NO), 
	foreign key (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID) ON DELETE CASCADE, 
	foreign key (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE
);

DESC SALESMAN;
DESC CUSTOMER;
DESC ORDERS;

INSERT INTO SALESMAN VALUES (1000, 'JOHN', 'BANGALORE', '25%'); 
INSERT INTO SALESMAN VALUES (2000, 'RAVI', 'BANGALORE', '20%'); 
INSERT INTO SALESMAN VALUES (3000, 'KUMAR', 'MYSORE', '15%'); 
INSERT INTO SALESMAN VALUES (4000, 'SMITH', 'DELHI', '30%'); 
INSERT INTO SALESMAN VALUES (5000, 'HARSHA', 'HYDRABAD', '15%'); 

INSERT INTO CUSTOMER VALUES (10, 'PREETHI', 'BANGALORE', 100, 1000); 
INSERT INTO CUSTOMER VALUES (11, 'VIVEK', 'MANGALORE', 300, 1000); 
INSERT INTO CUSTOMER VALUES (12, 'BHASKAR', 'CHENNAI', 400, 2000); 
INSERT INTO CUSTOMER VALUES (13, 'CHETHAN', 'BANGALORE', 200, 2000); 
INSERT INTO CUSTOMER VALUES (14, 'MAMATHA', 'BANGALORE', 400, 3000); 

INSERT INTO ORDERS VALUES (50, 5000, '04-05-17', 10, 1000); 
INSERT INTO ORDERS VALUES (51, 450, '20-01-17', 10, 2000);
INSERT INTO ORDERS VALUES (52, 1000, '24-02-17', 13, 2000); 
INSERT INTO ORDERS VALUES (53, 3500, '13-04-17', 14, 3000); 
INSERT INTO ORDERS VALUES (54, 550, '09-03-17', 12, 2000);

#1 Count the customers with grades above Bangalore’s average. 
SELECT GRADE, COUNT(*) 
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE > (
	SELECT AVG(GRADE)
    FROM CUSTOMER
    WHERE CITY = 'BANGALORE'
    );

#2 Find the name and numbers of all salesmen who had more than one customer. 
SELECT C.SALESMAN_ID, S.NAME 
FROM SALESMAN S, CUSTOMER C
WHERE C.SALESMAN_ID = S.SALESMAN_ID
GROUP BY NAME
HAVING COUNT(C.SALESMAN_ID) > 1;

#3 List all salesmen and indicate those who have and don’t have customers in their cities. (Use UNION operator) 
SELECT S.SALESMAN_ID, NAME, CUST_NAME, COMMISSION 
FROM SALESMAN S, CUSTOMER C
WHERE S.CITY = C.CITY
UNION
SELECT SALESMAN_ID, NAME, 'NO MATCH', COMMISSION
FROM SALESMAN 
WHERE CITY NOT IN (
	SELECT CITY
    FROM CUSTOMER
    )
ORDER BY COMMISSION DESC;

#4 Create a view that finds the salesman who has the customer with the highest order of a day.
CREATE VIEW ELITSALESMAN AS 
SELECT O.ORD_DATE, A.SALESMAN_ID, A.NAME 
FROM SALESMAN A, ORDERS O
WHERE A.SALESMAN_ID = O.SALESMAN_ID 
GROUP BY PURCHASE_AMT
HAVING PURCHASE_AMT = MAX(PURCHASE_AMT);

SELECT * FROM ELITSALESMAN;

#5 Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted. 
DELETE FROM SALESMAN 
WHERE SALESMAN_ID = 1000;
