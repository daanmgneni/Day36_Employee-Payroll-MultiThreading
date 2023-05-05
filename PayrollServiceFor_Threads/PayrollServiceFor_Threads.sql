--UC1 Creating Database

CREATE DATABASE payroll_service_ForThreads;
USE payroll_service_ForThreads;

--UC2 Creating Table
CREATE TABLE employee_Payroll_T
(
EmployeeId INT IDENTITY(1,1),
EmployeeName VARCHAR(30) NOT NULL,
Salary MONEY,
StartDate DATETIME NOT NULL
);

--To check Columns Created Successfully in Table.
SELECT * FROM employee_Payroll_T;

--UC3 Inserting Values into Table
INSERT INTO employee_Payroll_T(EmployeeName,Salary,StartDate)
VALUES
('Bill',1000000,'2022/3/22'),
('Terisa',2000000,'2022/3/21'),
('Charlie',3000000,'2022/3/20');

--Altering the DateTime Format to Date Only
ALTER TABLE employee_Payroll_T
ALTER COLUMN StartDate DATE;

--UC4 Retreive All Data
SELECT * FROM employee_Payroll_T;

--UC5 Retrieve Salary Data for particular Employee
SELECT Salary FROM employee_Payroll_T WHERE EmployeeName = 'Bill';
SELECT * FROM employee_Payroll_T
WHERE StartDate BETWEEN CAST('2022/3/21' AS DATE) AND GETDATE();

--UC6 Ability to Add Gender Column & Update it
ALTER TABLE employee_Payroll_T
ADD Gender CHAR(1);

UPDATE employee_Payroll_T SET Gender = 'M' WHERE EmployeeName = 'Bill' OR EmployeeName = 'Charlie';
UPDATE employee_Payroll_T SET Gender = 'M' WHERE EmployeeName = 'Terisa';
UPDATE employee_Payroll_T SET Gender = 'F' WHERE EmployeeName = 'Terisa';

--UC7 Using SUM,AVG,MIN,MAX,COUNT in table
SELECT SUM(Salary) AS SumOfSalariesofMales FROM employee_Payroll_T WHERE Gender = 'M';
SELECT SUM(Salary) AS SumOfSalariesofFemales FROM employee_Payroll_T WHERE Gender = 'F';
SELECT Gender,AVG(Salary) AS AverageSalariesofMalesAndFemales FROM employee_Payroll_T GROUP BY Gender;
SELECT Gender,COUNT(Gender) AS CountingofMaleFemale FROM employee_Payroll_T GROUP BY Gender;

--UC8 Adding Employee Additional Information
USE payroll_service_ForThreads
ALTER TABLE employee_Payroll_T ADD PhoneNo BIGINT;
UPDATE employee_Payroll_T SET PhoneNo = 7206594149 WHERE EmployeeId = 1;
ALTER table employee_payroll_T ADD EmployeeAddress VARCHAR(100) NOT NULL DEFAULT 'INDIA';
ALTER TABLE employee_payroll_T ADD Department VARCHAR(30) NOT NULL DEFAULT 'Research';
SELECT * FROM employee_Payroll_T

--UC9 Adding Pays Columns further to te table
EXEC SP_RENAME 'employee_Payroll.Salary', 'BasicPay', 'COLUMN';
ALTER TABLE employee_payroll_T ADD Deductions FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE employee_payroll_T ADD TaxablePay FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE employee_payroll_T ADD IncomeTax FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE employee_payroll_T ADD NetPay FLOAT NOT NULL DEFAULT 0.00;

UPDATE employee_payroll_T SET NetPay = (BasicPay - Deductions - TaxablePay - IncomeTax);

--UC10 Adding Department of Terisa as Sales & Marketing Both
UPDATE employee_payroll_T SET Department = 'Sales' WHERE EmployeeName = 'Terisa';
INSERT INTO employee_payroll_T 
VALUES
('Terisa',2000000,'2022-03-21','F','INDIA',NULL,'Marketing',0.00,0.00,0.00,2000000)

--UC11 Creating ER Diagrams
--Employee Table, Company Table, Payroll Table, Department Table(CFor Joining many to many Relationship), Employee Department Table will be the entities..
DROP TABLE employee_payroll_T;
--Creating Compay Table
CREATE TABLE CompanyTable
(
CompanyID INT IDENTITY(1,1) PRIMARY KEY,
CompanyName VARCHAR(100)
)
INSERT INTO CompanyTable
VALUES
('ROOP AUTO'),('KORLOY INDIA')
SELECT * FROM CompanyTable
CREATE TABLE EmployeeTable
(
EmployeeID INT IDENTITY (1,1) PRIMARY KEY,
CompanySelect INT,
EmployeeName VARCHAR(20) NOT NULL,
Gender CHAR(1) NOT NULL,
PhoneNo BIGINT,
EmployeeAddress VARCHAR(150),
StartDate DATE NOT NULL,
FOREIGN KEY (CompanySelect) REFERENCES CompanyTable(CompanyID)
);
SELECT * FROM EmployeeTable;

INSERT INTO EmployeeTable
VALUES
(1,'Rishabh','M',8956594149,'VPO Kalanaur','2017-09-15'),
(1,'Gaurav','M',9546906297,'VPO Banares','2017-09-15'),
(2,'Sanjeev','M',7845595579,'VPO Bound','2019-05-12'),
(2,'Anita','F',8956365917,'VPO Lahli','2017-05-09');

-- PayRoll Table Entity
CREATE TABLE PayrollTable
(
BasicPay FLOAT NOT NULL DEFAULT 0.00,
Deductions FLOAT NOT NULL DEFAULT 0.00,
TaxablePay FLOAT,
IncomeTax FLOAT NOT NULL DEFAULT 0.00,
NetPay FLOAT,
EmployeeSelect INT,
FOREIGN KEY (EmployeeSelect) REFERENCES EmployeeTable(EmployeeID)
);
SELECT * FROM PayrollTable

INSERT INTO PayrollTable(BasicPay,Deductions,IncomeTax,EmployeeSelect)
VALUES
(2000000,20000,10000,1),
(1800000,18000,9000,2),
(2500000,25000,12500,3),
(3000000,30000,15000,4);

--Updating Values of Deriving Attribute in Payroll Table
UPDATE PayrollTable SET TaxablePay = (BasicPay - Deductions);
UPDATE PayrollTable SET NetPay = (TaxablePay - IncomeTax);

CREATE TABLE DepartmentTable
(
DepartmentID INT IDENTITY (1,1) PRIMARY KEY,
DepartmentName VARCHAR(100)
);
SELECT * FROM DepartmentTable

INSERT INTO DepartmentTable(DepartmentName)
VALUES
('Sales'),('Marketing'),('Research'),('HR');

CREATE TABLE EmployeeDepartmentTable
(
EmployeeSelect INT,
DepartmentSelect INT,
FOREIGN KEY (EmployeeSelect) REFERENCES EmployeeTable(EmployeeID),
FOREIGN KEY (DepartmentSelect) REFERENCES DepartmentTable(DepartmentID)
);
SELECT * FROM EmployeeDepartmentTable

INSERT INTO EmployeeDepartmentTable
VALUES
(1,1),(2,2),(3,2),(4,3),(4,4);

--UC12 Retrieving data for Previous UC's

--Retrieving All data of All Employees
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,PhoneNo,EmployeeAddress,StartDate,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartmentName
FROM CompanyTable
INNER JOIN EmployeeTable ON CompanyTable.CompanyID = EmployeeTable.CompanySelect
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID
INNER JOIN EmployeeDepartmentTable ON EmployeeDepartmentTable.EmployeeSelect = EmployeeTable.EmployeeID
INNER JOIN DepartmentTable ON DepartmentTable.DepartmentID = EmployeeDepartmentTable.DepartmentSelect

--Retrieving Payroll Data with Specific Employee Name
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM CompanyTable
INNER JOIN EmployeeTable ON EmployeeTable.CompanySelect = CompanyTable.CompanyID AND EmployeeTable.EmployeeName = 'Viney'
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID

--Retrieving Data from a range of Date
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM CompanyTable
INNER JOIN EmployeeTable ON CompanyTable.CompanyID = EmployeeTable.CompanySelect AND StartDate BETWEEN CAST('2017-09-15' AS DATE) AND GETDATE()
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID;

--Using Aggregate and grouping by gender
SELECT AVG(BasicPay) AS AverageSalary,Gender FROM EmployeeTable
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID GROUP BY GENDER;

SELECT SUM(BasicPay) AS TotalSalary,Gender FROM EmployeeTable
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID GROUP BY GENDER;

SELECT MAX(BasicPay) AS MaximumSalary,Gender FROM EmployeeTable
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID GROUP BY GENDER;

SELECT MIN(BasicPay) AS MinimumSalary,Gender FROM EmployeeTable
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID GROUP BY GENDER;

SELECT COUNT(BasicPay) AS CountSalary,Gender FROM EmployeeTable
INNER JOIN PayrollTable ON PayrollTable.EmployeeSelect = EmployeeTable.EmployeeID GROUP BY GENDER;

--Strored Procedure to Add a record of Person using ADO.NET
GO
CREATE PROCEDURE [dbo].[spAddEmployee]
(
@EmployeeName VARCHAR(30),
@Gender CHAR(1),
@PhoneNumber BIGINT,
@EmployeeAddress VARCHAR(100),
@StartDate DATE,
@BasicPay FLOAT,
@Deductions FLOAT,
@IncomeTax FLOAT,
@CompanySelect INT,
@DepartmentSelect INT,
@EmployeeSelect INT 
)
AS
BEGIN TRY 
INSERT INTO EmployeeTable(EmployeeName,Gender,StartDate,PhoneNo,EmployeeAddress,CompanySelect)
VALUES (@EmployeeName,@Gender,@StartDate,@PhoneNumber,@EmployeeAddress,@CompanySelect)
INSERT INTO PayrollTable(BasicPay,Deductions,IncomeTax,EmployeeSelect)
VALUES(@BasicPay,@Deductions,@IncomeTax,@EmployeeSelect)
INSERT INTO EmployeeDepartmentTable(DepartmentSelect,EmployeeSelect)
VALUES(@DepartmentSelect,@EmployeeSelect)
END TRY

BEGIN CATCH
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_STATE() AS ErrorState,
ERROR_PROCEDURE() AS ErrorProcedure,
ERROR_LINE() AS ErrorLine,
ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO


CREATE PROCEDURE spShowingAllInEmployeeTable
AS
BEGIN
SELECT * FROM EmployeeTable
END