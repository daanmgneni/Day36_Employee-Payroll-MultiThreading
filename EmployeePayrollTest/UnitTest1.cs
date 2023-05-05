using D36_EmployeePayrollMultiThreading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;

namespace EmployeePayrollTest
{
    [TestClass]
    public class UnitTest1
    {
        EmployeePayrollDatabase employeePayrollDatabase = new EmployeePayrollDatabase();
        [TestMethod]
        public void GivenEmployeeList_InAddingEmployeeMethod_ReturnSameListThatisAdded()
        {
            List<EmployeeDetails> employeesListToBeAddedToDB = new List<EmployeeDetails>();
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Rishabh", gender = "M", phoneNo = 7906552015, employeeAddress = "Agra, U.P", startDate = DateTime.Now, basicPay = 1800000, deductions = 250000, incomeTax = 150000, companySelect = 1, employeeSelect = 18, departmentSelect = 2, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Ramesh", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO Radaur, Rajasthan", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 3, employeeSelect = 19, departmentSelect = 4, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Suresh", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO Vrindavan, UP", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 2, employeeSelect = 20, departmentSelect = 3, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Harish", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO Amravati, Maharashtra", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 1, employeeSelect = 21, departmentSelect = 2, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Harinder", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO Borivali, Maharashtra", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 5, employeeSelect = 22, departmentSelect = 3, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Sidhu", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO BeguSarai, MP", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 4, employeeSelect = 23, departmentSelect = 4, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Jaibhagwan", gender = "M", phoneNo = 9991661664, employeeAddress = "VPO Mohammadpur, UP", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 3, employeeSelect = 24, departmentSelect = 2, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Poonam", gender = "F", phoneNo = 9991661664, employeeAddress = "VPO Kandivali, Maharashtra", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 2, employeeSelect = 25, departmentSelect = 4, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Manju", gender = "F", phoneNo = 9991661664, employeeAddress = "VPO Jonpur, UP", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 3, employeeSelect = 26, departmentSelect = 3, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Sapna", gender = "F", phoneNo = 9991661664, employeeAddress = "VPO Mughal Sarai, UP", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 5, employeeSelect = 27, departmentSelect = 2, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Sharda", gender = "F", phoneNo = 9991661664, employeeAddress = "VPO Jakhal, Haryana", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 1, employeeSelect = 28, departmentSelect = 1, });
            employeesListToBeAddedToDB.Add(new EmployeeDetails { employeeName = "Sushma", gender = "F", phoneNo = 9991661664, employeeAddress = "VPO Nimbri, Haryana", startDate = DateTime.Now, basicPay = 1200000, deductions = 200000, incomeTax = 100000, companySelect = 4, employeeSelect = 29, departmentSelect = 3, });
            DateTime startDateTime = DateTime.Now;
            Console.WriteLine($"Data Addition to DB started on {startDateTime}");
            employeePayrollDatabase.AddEmployeeListToDBWithoutThread(employeesListToBeAddedToDB);
            DateTime endDateTime = DateTime.Now;
            Console.WriteLine($"Data Addition to DB ended on {endDateTime}");
            Console.WriteLine($"Time for Adding Data to DB is {endDateTime - startDateTime}");
        }
    }
}