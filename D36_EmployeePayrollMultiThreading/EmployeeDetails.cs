using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace D36_EmployeePayrollMultiThreading
{
    public class EmployeeDetails
    {
        public int employeeID { get; set; }
        public string employeeName { get; set; }
        public string gender { get; set; }
        public string companyName { get; set; }
        public string departmentName { get; set; }
        public Int64 phoneNo { get; set; }
        public string employeeAddress { get; set; }
        public DateTime startDate { get; set; }
        public double basicPay { get; set; }
        public double deductions { get; set; }
        public double taxablePay { get; set; }
        public double incomeTax { get; set; }
        public double netPay { get; set; }
        public int companySelect { get; set; }
        public int employeeSelect { get; set; }
        public int departmentSelect { get; set; }
        public EmployeeDetails(int employeeID, string employeeName, string companyName, Int64 phoneNo,
           string employeeAddress, DateTime startDate, string departmentName, string gender, double basicPay, double deductions,
           double taxablePay, double incomeTax, double netPay, int companySelect, int employeeSelect, int departmentSelect)
        {
            this.employeeID = employeeID;
            this.employeeName = employeeName;
            this.companyName = companyName;
            this.phoneNo = phoneNo;
            this.employeeAddress = employeeAddress;
            this.startDate = startDate;
            this.departmentName = departmentName;
            this.gender = gender;
            this.basicPay = basicPay;
            this.deductions = deductions;
            this.taxablePay = taxablePay;
            this.incomeTax = incomeTax;
            this.netPay = netPay;
            this.companySelect = companySelect;
            this.employeeSelect = employeeSelect;
            this.departmentSelect = departmentSelect;

        }
    }
}
