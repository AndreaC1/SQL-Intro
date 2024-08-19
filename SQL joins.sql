-- 1. joins: select all the computers from the products table:
-- using the products table and the categories table, return the product name and the category name */
SELECT products.Name, categories.Name
from products 
INNER JOIN categories ON products.CategoryID = categories.CategoryID
where categories.CategoryID = 1;
 

-- 2. joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.name, products.price, reviews.rating
FROM products
LEFT JOIN reviews ON products.ProductID = reviews.ProductID
where reviews.rating = 5;
-- 3. joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT employees.EmployeeID, employees.FirstName, employees.LastName, SUM(sales.Quantity) AS total_quantity_sold
FROM employees
INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
GROUP BY employees.EmployeeID
-- OR DER BY total_quantity_sold desc
-- LIMIT 1;
HAVING total_quantity_sold = (
-- Sub query to get the "37"
	SELECT SUM(Quantity)
    FROM employees
    INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
    GROUP BY employees.EmployeeID
    ORDER BY SUM(Quantity) DESC
    LIMIT 1
);
-- 4. joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT departments.Name, categories.Name
FROM departments
INNER JOIN categories ON departments.DepartmentID = categories.DepartmentID
WHERE categories.Name LIKE 'Appliances' OR categories.Name LIKE 'Games';

-- 5. joins: find the product name, total # sold, and total price sold,

 --  for Eagles: Hotel California --You may need to use SUM() */
 Select Name, SUM(Quantity), SUM(Price)
 FROM products
 INNER JOIN sales ON products.ProductID = sales.ProductID
 WHERE Name LIKe '%Hotel%California'
 GROUP BY products.ProductID;

-- 6. joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */

SELECT products.Name, reviews.Reviewer, reviews.Rating, reviews.Comment
FROM products
INNER JOIN reviews ON products.ProductID = reviews.ProductID
WHERE products.Name like '%Visio%'
ORDER BY reviews.Rating
LIMIT 1;

-- ------------------------------------------ Extra - May be difficult

-- 7. Your goal is to write a query that serves as an employee sales report.
-- This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT employees.EmployeeID, employees.FirstName, employees.LastName, products.Name, SUM(sales.Quantity)
FROM employees
INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
INNER JOIN products ON sales.ProductID = products.ProductID
GROUP BY employees.EmployeeID, products.ProductID
ORDER BY employees.EmployeeID, products.ProductID;
