/* 176. Second Highest Salary

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 
Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

The query result format is in the following example.

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

Solution:

/* Method 1*/
;WITH CTE AS
(
SELECT  DISTINCT Salary, DENSE_RANK() OVER (ORDER BY Salary Desc) RNK
FROM    Employee E
)

SELECT NULLIF(
    (SELECT  Salary
     FROM    CTE
     WHERE   RNK = 2), NULL) AS SecondHighestSalary 

/* Method 2

SELECT   NULLIF((
SELECT   DISTINCT Salary 
FROM     Employee 
ORDER BY SALARY DESC 
OFFSET 1 ROW 
FETCH NEXT 1 ROW ONLY), NULL) AS SecondHighestSalary*/

/* Method 3
SELECT   NULLIF(
(SELECT  DISTINCT salary
FROM    Employee E
WHERE   2 = (SELECT COUNT(DISTINCT E1.Salary) FROM Employee E1 WHERE E1.salary >= E.salary)), NULL) AS SecondHighestSalary*/
