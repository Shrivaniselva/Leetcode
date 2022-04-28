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
