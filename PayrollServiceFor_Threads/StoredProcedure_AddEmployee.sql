USE [payroll_service_ForThreads]
GO
/****** Object:  StoredProcedure [dbo].[spAddEmployee]    Script Date: 19-Apr-22 7:51:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spAddEmployee]
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
UPDATE PayrollTable SET TaxablePay = (BasicPay - Deductions)
UPDATE PayrollTable SET NetPay = (TaxablePay - IncomeTax)
END TRY

BEGIN CATCH
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_STATE() AS ErrorState,
ERROR_PROCEDURE() AS ErrorProcedure,
ERROR_LINE() AS ErrorLine,
ERROR_MESSAGE() AS ErrorMessage;
END CATCH