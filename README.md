# Employee Management Database

This repository contains a SQL database project designed for managing employee information in a university context. It includes functionalities to track employee details, department information, salary classifications, and relationships between employees and departments.

## Database Structure

The database comprises the following tables:

- **Employees**: Stores employee details such as ID, first name, last name, title, gender, year hired, birth year, performance bonus, and newly added `EmployeeInitials`.
- **Departments**: Contains department information, including ID, name, and location.
- **SalaryClass**: Holds salary information associated with various salary IDs.
- **DepartmentEmployee**: A junction table that links employees to their respective departments.

## Features

- **Dynamic Queries**: Supports a variety of SQL queries to retrieve and manipulate employee data, including filtering by department location, tenure, age, and title.
- **Salary Calculations**: Provides calculations for original and new salaries after applying a bonus.
- **Data Integrity**: Implements referential integrity through foreign keys, normalization to minimize redundancy, and appropriate data types for fields.

## Integrity Analysis

The database is designed with a focus on data integrity, utilizing normalization and referential integrity through foreign keys to maintain accurate relationships between entities. The appropriate use of data types and constraints helps ensure valid data entry. However, there are areas for improvement, such as minimizing attribute redundancy and ensuring constraints on critical fields like SalaryID and DepartmentID.
