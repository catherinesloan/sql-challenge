# sql-challenge

## Employee Database: A Mystery in Two Parts


### Background:
I have been hired as a new data engineer at Pewlett Hackard. 

### Task:
My first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are [six CSV files.](https://github.com/catherinesloan/sql-challenge/tree/main/data)
- Design the tables to hold the data in the CSVs
- Import the CSVs into a SQL database
- Answer questions about the data

### Output:
1. **Data Modeling***
Inspected the CSVs and drew an [entity relationship diagram](https://github.com/catherinesloan/sql-challenge/blob/main/employee_sql/entity_relationship_diagram.png)(ERD) of the tables using http://www.quickdatabasediagrams.com 

<img width="816" alt="Screen Shot 2021-05-29 at 5 39 22 pm" src="https://user-images.githubusercontent.com/73929301/120062336-0b7fe500-c0a5-11eb-8637-139abc2ce55c.png">


2. **Data Engineering**
   - Created a [table schema](https://github.com/catherinesloan/sql-challenge/blob/main/employee_sql/table_schemata.sql) for each of the six CSV files
   - Imported each CSV file into the corresponding SQL table

3. **Data Analysis** Performed [SQL queries](https://github.com/catherinesloan/sql-challenge/blob/main/employee_sql/data_analysis.sql) to list the following ... 
   - Details of each employee; employee number, last name, first name, sex, and salary
   - First name, last name, and hire date for employees who were hired in 1986
   - The manager of each department with the following information; department number, department name, the manager's employee number, last name and first name.
   - The department of each employee with the following information; employee number, last name, first name, and department name.
   - First name, last name, and sex for employees whose first name is _Hercules_ and last names begin with _B_
   - Employees in the Sales department, including their employee number, last name, first name, and department name
   - All employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
   - The frequency count of employee last names in descending order

4. **Bonus**
   - Imported the SQL database into Pandas, see [notebook here](https://github.com/catherinesloan/sql-challenge/blob/main/employee_sql/bonus_part.ipynb).
   - Generated a histogram to visualise the most common salary ranges for employees
   - Generated a bar chart of average salary by title

<img width="401" alt="Screen Shot 2021-05-29 at 5 39 02 pm" src="https://user-images.githubusercontent.com/73929301/120062347-19356a80-c0a5-11eb-8faa-80d2ddf1e913.png"> 
<img width="434" alt="Screen Shot 2021-05-29 at 5 39 09 pm" src="https://user-images.githubusercontent.com/73929301/120062350-1c305b00-c0a5-11eb-9f36-513dea2ddd2a.png">


