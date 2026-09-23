SELECT officeCode, phone
FROM offices;
SELECT employeeNumber, firstName, lastName, email
FROM employees
WHERE email LIKE '%.es';
SELECT customerNumber, customerName, state
FROM customers
WHERE state IS NULL OR state = '';
SELECT *
FROM payments
WHERE amount > 20000;
SELECT DISTINCT productCode
FROM orderdetails;
SELECT c.country, COUNT(o.orderNumber) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.country;
SELECT productLine, LENGTH(textDescription) AS description_length
FROM productlines
ORDER BY description_length DESC
LIMIT 1;
SELECT o.officeCode, COUNT(c.customerNumber) AS total_customers
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode;
SELECT o.officeCode, COUNT(c.customerNumber) AS total_customers
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode;
SELECT DAYNAME(orderDate) AS day_of_week,
       COUNT(orderNumber) AS total_sales
FROM orders
GROUP BY day_of_week
ORDER BY total_sales DESC
LIMIT 1;
SELECT officeCode,
       CASE
           WHEN territory IS NULL OR territory = 'NA' THEN 'USA'
           ELSE territory
       END AS corrected_territory
FROM offices;
SELECT YEAR(o.orderDate) AS year,
       MONTH(o.orderDate) AS month,
       AVG(od.quantityOrdered * od.priceEach) AS avg_cart_amount,
       SUM(od.quantityOrdered) AS total_items
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE (e.lastName = 'Patterson')
  AND YEAR(o.orderDate) IN (2004, 2005)
GROUP BY year, month
ORDER BY year, month;
SELECT YEAR(o.orderDate) AS year,
       MONTH(o.orderDate) AS month,
       (SELECT AVG(od2.quantityOrdered * od2.priceEach)
        FROM orderdetails od2
        JOIN orders o2 ON od2.orderNumber = o2.orderNumber
        WHERE o2.orderNumber = o.orderNumber) AS avg_cart_amount,
       (SELECT SUM(od3.quantityOrdered)
        FROM orderdetails od3
        JOIN orders o3 ON od3.orderNumber = o3.orderNumber
        WHERE o3.orderNumber = o.orderNumber) AS total_items
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.lastName = 'Patterson'
  AND YEAR(o.orderDate) IN (2004, 2005)
GROUP BY year, month
ORDER BY year, month;
SELECT DISTINCT o.officeCode, o.city, o.country
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.state IS NULL OR c.state = '';
