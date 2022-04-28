/*
1164. Product Price at a Given Date

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 
Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

--Solution: MS SQL Server:

;WITH CTE AS
(
SELECT  DISTINCT product_id
FROM    Products
),

change AS 
(
    SELECT  product_id, MAX(change_date) change_date
    FROM    Products
    WHERE   change_date <= '2019-08-16'
    GROUP BY product_id
),
Nochange AS 
(
    SELECT  product_id, MIN(change_date) change_date
    FROM    Products
    WHERE   change_date > '2019-08-16' AND product_id NOT in (SELECT product_id FROM change)
    GROUP BY product_id
)

SELECT  C.Product_id, 
        CASE WHEN P.change_date <= '2019-08-16' THEN new_price
        END AS price
FROM    CTE C
JOIN    change CH ON C.Product_id = CH.Product_id 
JOIN    Products p ON C. Product_id = p.Product_id AND CH.change_date = p.change_date

UNION

SELECT  C.Product_id, 
        CASE WHEN P.change_date > '2019-08-16' THEN 10
        END AS price
FROM    CTE C
JOIN    Nochange NC ON C.Product_id = NC.Product_id 
JOIN    Products p ON C. Product_id = p.Product_id AND NC.change_date = p.change_date

