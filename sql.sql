-- Question 1: Display the first names of all employees who work in the department located in Sydney in alphabetical order.

SELECT E.EmployeeFirstName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.Location = 'Sydney'
ORDER BY E.EmployeeFirstName ASC;

-- Question 2: Show employees who have worked at the University the shortest amount of time. 

-- Find the shortest tenure first
WITH Tenure AS (
    SELECT EmployeeID, EmployeeFirstName, EmployeeLastName, 
           (YEAR(CURDATE()) - yearHired) AS YearsWorked
    FROM Employees
)
-- Find the minimum number of years worked
SELECT EmployeeFirstName, EmployeeLastName, YearsWorked
FROM Tenure
WHERE YearsWorked = (SELECT MIN(YearsWorked) FROM Tenure);

-- Question 3: Display the names of all employees whose age is a palindrome. 

SELECT EmployeeFirstName, EmployeeLastName, 
       (YEAR(CURDATE()) - birthyear) AS Age
FROM Employees
-- Filter for palindrome ages
WHERE (YEAR(CURDATE()) - birthyear) = REVERSE(YEAR(CURDATE()) - birthyear)
LIMIT 40;

-- Question 4: List the departments along with the number of employees in each department.

SELECT D.DepartmentName, COUNT(E.EmployeeID) AS NumberOfEmployees
FROM Departments D
LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentID, D.DepartmentName
ORDER BY D.DepartmentName;

--Question 5: Find the average salary of employees in each department.

SELECT D.DepartmentName, AVG(S.Salary) AS AverageSalary
FROM Departments D
JOIN DepartmentEmployee DE ON D.DepartmentID = DE.DepartmentID
JOIN Employees E ON DE.EmployeeID = E.EmployeeID
JOIN SalaryClass S ON E.SalaryID = S.SalaryID
GROUP BY D.DepartmentID, D.DepartmentName
ORDER BY D.DepartmentName;

--Question 6: Find the names and salaries of employees who are older than 40 years.

SELECT E.EmployeeFirstName, E.EmployeeLastName, S.Salary
FROM Employees E
JOIN SalaryClass S ON E.SalaryID = S.SalaryID
WHERE (YEAR(CURDATE()) - E.birthyear) > 40;

--Question 7: Show the employee details and their department names for those employees who have a "Lecturer” title.

SELECT E.EmployeeID, E.EmployeeFirstName, E.EmployeeLastName, E.Title, D.DepartmentName
FROM Employees E
JOIN DepartmentEmployee DE ON E.EmployeeID = DE.EmployeeID
JOIN Departments D ON DE.DepartmentID = D.DepartmentID
WHERE E.Title = 'Lecturer';

--Question 8: Display employees' first and last names and work out the original salary for all employees and their new salary after their (10%) bonus is applied. 

SELECT E.EmployeeFirstName, E.EmployeeLastName, 
       S.Salary AS OriginalSalary, 
       S.Salary * 1.10 AS NewSalary
FROM Employees E
JOIN SalaryClass S ON E.SalaryID = S.SalaryID;


--Question 9: Add a new attribute called "EmployeeInitials" to the Employees table. 

ALTER TABLE Employees
ADD EmployeeInitials VARCHAR(10);

--Question 10: Write a query that populates “EmployeeInitials”, based off the existing stored names.
UPDATE Employees
SET EmployeeInitials = CONCAT(LEFT(EmployeeFirstName, 1), '.', LEFT(EmployeeLastName, 1), '.');


--Question 11: Write 250 words explaining the integrity of this database. Is it up to standard? If yes, explain why and how. If not, what is wrong with the database's integrity?

--In the case of the described database with tables for Employees, Departments, SalaryClass, and DepartmentEmployee, several aspects indicate a reasonable level of integrity, though there are areas for improvement.

--Aspects of Integrity:
--Referential Integrity: The use of foreign keys, such as DepartmentID in the Employees and DepartmentEmployee tables, ensures that relationships between tables are maintained. This prevents orphaned records and enforces valid data entries. For instance, every employee must belong to a valid department, which is crucial for maintaining consistent data relationships.
--Normalization: The structure appears normalized, reducing data redundancy and improving data integrity. Each table has a specific purpose, such as storing employee details, department information, and salary classifications, minimizing duplication of data across tables.
--Data Types and Constraints: Using appropriate data types (e.g., VARCHAR for names, INT for IDs) helps enforce data integrity by ensuring that only valid data is stored. Additionally, constraints such as NOT NULL can be applied to critical fields to prevent incomplete records.

--Areas for Improvement:
--Attribute Redundancy: The EmployeeInitials attribute, while useful, may not be necessary for every application and could lead to redundancy if initials are stored separately. It might be better calculated dynamically when needed.
--Lack of Checks and Balances: There may be no constraints on values such as SalaryID or DepartmentID, which could allow invalid entries if not handled properly.