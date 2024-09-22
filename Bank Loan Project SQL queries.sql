--Create a new database
create database [Bank Loan DB];

--Switch to the new database
use [Bank Loan DB];

--Retrieve Records
select * from bank_loan_data;

--Writing queries for Problem Statement questions
--i)KPI Requirements
--1) Total Loan Applications:
select COUNT(id) AS [Total Loan Applications] from bank_loan_data; 

--MTD (Month-to-Date) Total Loan Applications:
select COUNT(id) AS [MTD Total Loan Applications] from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021; 

--PMTD (Previous Month-to-Date) Total Loan Applications:
select COUNT(id) AS [PMTD Total Loan Applications] from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

--2) Total Funded Amount:
select SUM(loan_amount) AS [Total Funded Amount] from bank_loan_data;

--MTD (Month-to-Date) Total Funded Amount:
select SUM(loan_amount) AS [MTD Total Funded Amount] from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

--PMTD (Previous Month-to-Date) Total Funded Amount:
select SUM(loan_amount) AS [PMTD Total Funded Amount] from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

--3) Total Amount Received:
select SUM(total_payment) AS [Total Amount Received] from bank_loan_data;

--MTD (Month-to-Date) Total Amount Received:
select SUM(total_payment) AS [MTD Total Amount Received] from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

--PMTD (Previous Month-to-Date)  Total Amount Received:
select SUM(total_payment) AS [PMTD Total Amount Received] from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

--4) Average Interest Rate: 
select ROUND(AVG(int_rate),4)*100 AS [Average Interest Rate] from bank_loan_data;

--MTD (Month-to-Date) Average Interest Rate:
select ROUND(AVG(int_rate),4)*100 AS [MTD Average Interest Rate] from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

--PMTD (Previous Month-to-Date) Average Interest Rate:
select ROUND(AVG(int_rate),4)*100 AS [PMTD Average Interest Rate] from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

--5) Average Debt-to-Income Ratio (DTI): 
select ROUND(AVG(dti),4)*100 AS [Average Debt-to-Income Ratio] from bank_loan_data;

--MTD (Month-to-Date) Average Debt-to-Income Ratio (DTI):
select ROUND(AVG(dti),4)*100 AS [MTD Average Debt-to-Income Ratio] from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

--PMTD (Previous Month-to-Date) Average Debt-to-Income Ratio (DTI):
select ROUND(AVG(dti),4)*100 AS [PMTD Average Debt-to-Income Ratio] from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

--ii) Good Loan KPI:
--1.Good Loan Application Percentage: 
select (COUNT(
CASE 
	WHEN loan_status='Fully Paid' 
	OR loan_status='Current' THEN id
	END
	)*100)/COUNT(id) AS [Good Loan Percentage] from bank_loan_data;

--2.Good Loan Applications: 
select COUNT(id) AS [Good Loan Applications] from bank_loan_data
where loan_status IN ('Fully Paid','Current');

--3.Good Loan Funded Amount:
select SUM(loan_amount) AS [Good Loan Funded Amount] from bank_loan_data
where loan_status IN ('Fully Paid','Current');

--4.Good Loan Amount Received
select SUM(total_payment) AS [Good Loan Amount Received] from bank_loan_data
where loan_status IN ('Fully Paid','Current');

--iii) Bad Loan KPI:
--1.Bad Loan Application Percentage: 
select (COUNT(
CASE
	WHEN loan_status='Charged Off' THEN id
	END) *100)/COUNT(id) AS [Bad Loan Percentage] from bank_loan_data;

--2.Bad Loan Applications: 
select COUNT(id) AS [Bad Loan Applications] from bank_loan_data
where loan_status='Charged Off';

--3.Bad Loan Funded Amount: 
select SUM(loan_amount) AS [Bad Loan Funded Amount] from bank_loan_data
where loan_status='Charged Off';

--4.Bad Loan Total Received Amount: 
select SUM(total_payment) AS [Bad Loan Amount Received] from bank_loan_data
where loan_status='Charged Off';

--Loan Status 
select loan_status, COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received],
AVG(int_rate*100) AS [Average Interest Rate],
AVG(dti*100) AS [Average Debt-to-Income Ratio (DTI)] from bank_loan_data
group by loan_status;

select loan_status, SUM(loan_amount) AS [MTD Total Funded Amount],
SUM(total_payment) AS [MTD Total Amount Received] 
from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021
group by loan_status;

--1. Monthly Trends by Issue Date:
select MONTH(issue_date) AS [Month Number],DATENAME(MONTH, issue_date) AS [Month Name],COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by MONTH(issue_date),DATENAME(MONTH, issue_date)
order by [Month Number];

--2.Regional Analysis by State:
select address_state AS State,COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by address_state
order by State;

--3.Loan Term Analysis 
select term AS [Loan Term],COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by term
order by [Loan Term];

--4.Employee Length Analysis:
select emp_length AS [Employee Length],COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by emp_length
order by [Employee Length];

--5.Loan Purpose Breakdown:
select purpose AS [Loan Purpose],COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by purpose
order by [Loan Purpose];

--6. Home Ownership Analysis 
select home_ownership AS [Home Ownership],COUNT(id) AS [Total Loan Applications],
SUM(loan_amount) AS [Total Funded Amount],
SUM(total_payment) AS [Total Amount Received] from bank_loan_data
group by home_ownership
order by [Home Ownership];