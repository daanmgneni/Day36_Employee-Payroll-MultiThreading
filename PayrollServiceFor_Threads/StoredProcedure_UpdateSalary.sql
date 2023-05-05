--USE [payroll_service_ForThreads]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployeeSalary]    Script Date: 29-Mar-22 7:32:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spUpdateEmployeeSalary]
(
@EmployeeID INT,
@EmployeeName VARCHAR(30),
@BasicPay FLOAT
)
AS
BEGIN TRY
UPDATE PayrollTable SET BasicPay = @BasicPay WHERE EmployeeSelect = @EmployeeID

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