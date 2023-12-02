SELECT * FROM products;
SELECT * FROM categories;
SELECT * FROM reviews;
SELECT * FROM employees;
SELECT * FROM sales;
SELECT * FROM departments;

/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT products.Name, categories.Name
FROM products
INNER JOIN categories ON products.CategoryID = categories.CategoryID
WHERE categories.Name = "Computers";

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
 SELECT products.Name, products.Price, reviews.Rating
 FROM products
 INNER JOIN reviews ON products.ProductID = reviews.ProductID
 WHERE reviews.Rating = '5';
 
/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT employees.FirstName, employees.LastName, SUM(sales.Quantity)
FROM employees
INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
GROUP BY employees.EmployeeID
HAVING SUM(sales.Quantity) =
(
    SELECT MAX(TotalSales) FROM
    (
        SELECT SUM(sales.Quantity) AS TotalSales
        FROM sales
        GROUP BY sales.EmployeeID
    ) AS SubQuery
);


/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT categories.Name AS cgNames, departments.Name AS dpNames
FROM categories
INNER JOIN departments ON categories.DepartmentID = departments.DepartmentID
WHERE categories.Name = "Games" OR categories.Name = "Appliances";

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
SELECT products.Name AS prName, SUM(sales.Quantity) AS numSold, SUM(sales.Quantity*sales.PricePerUnit) AS totalPriceSold
FROM products
INNER JOIN sales ON products.ProductID = sales.ProductID
WHERE products.Name = 'Eagles: Hotel California'
GROUP BY products.ProductID;

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT products.Name AS prName, reviews.Reviewer, reviews.Rating, reviews.Comment
FROM products
INNER JOIN reviews ON products.ProductID = reviews.ProductID
WHERE products.Name = 'Visio TV'
AND reviews.Rating = 
(
SELECT MIN(Rating)
FROM reviews
WHERE ProductID = products.ProductID
);

SELECT p.Name, r.Reviewer, r.Rating, r.Comment
FROM products as p
INNER JOIN reviews AS r ON r.ProductID = p.ProductID
WHERE p.ProductID = 857 AND r.Rating = 1;

-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */

SELECT employees.EmployeeID, employees.FirstName, employees.LastName, products.Name, SUM(sales.Quantity)
FROM sales
INNER JOIN employees ON sales.EmployeeID = employees.EmployeeID
INNER JOIN products ON sales.ProductID = products.ProductID
GROUP BY employees.EmployeeID, products.ProductID
ORDER BY employees.EmployeeID;








