-- REVENUE ANALYSIS
/* Total revenue generated by the e-commerce platform*/
select ROUND(SUM(oi.quantity * oi.price), 2) as total_revenue
FROM order_items oi;
/* revenue generated per product*/
SELECT p.product_name,
  p.category,
  sum(oi.quantity * oi.price) as total_revenue,
  sum(oi.quantity) as total_units_sold
FROM products p
  LEFT JOIN order_items oi on p.product_id = oi.product_id
GROUP BY p.product_id,
  p.product_name,
  p.category
ORDER BY total_revenue DESC;
-- CUSTOMER INSIGHTS
-- Top 5 customers by total spending
SELECT c.name,
  COUNT(DISTINCT o.order_id) as total_orders,
  ROUND(SUM(oi.quantity * oi.price), 2) as total_spent
FROM Customers c
  JOIN Orders o ON c.customer_id = o.customer_id
  JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id,
  c.name
ORDER BY total_spent DESC
LIMIT 5;
-- Customers with no purchases
SELECT name,
  email
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
  );
-- PRODUCT TRENDS
-- Top 3 best-selling products
SELECT p.product_name,
  SUM(oi.quantity) as total_units_sold,
  ROUND(SUM(oi.quantity * oi.price), 2) as total_revenue
FROM Products p
  JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id,
  p.product_name
ORDER BY total_units_sold DESC
LIMIT 3;
-- Products out of stock or low stock (less than 10 units)
SELECT product_name,
  category,
  stock_quantity
FROM Products
WHERE stock_quantity < 10
ORDER BY stock_quantity;
-- ORDER DETAILS
-- Items in a specific order 
SELECT o.order_id,
  p.product_name,
  oi.quantity,
  oi.price,
  ROUND(oi.quantity * oi.price, 2) as line_total
FROM Orders o
  JOIN Order_Items oi ON o.order_id = oi.order_id
  JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_id = 5;
-- Total amount calculation for each order
SELECT o.order_id,
  o.order_date,
  COUNT(DISTINCT oi.product_id) as unique_items,
  SUM(oi.quantity) as total_items,
  ROUND(SUM(oi.quantity * oi.price), 2) as total_amount
FROM Orders o
  JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id,
  o.order_date
ORDER BY o.order_id;
-- MONTHLY TRENDS
/* Calculation for the number of orders and total revenue for each month*/
SELECT TO_CHAR(order_date, 'YYYY-MM') as month,
  COUNT(DISTINCT o.order_id) as number_of_orders,
  ROUND(SUM(oi.quantity * oi.price), 2) as total_revenue,
  ROUND(AVG(oi.quantity * oi.price), 2) as average_order_value
FROM Orders o
  JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;
-- finding the customer with the highest number of purchases 
SELECT c.name,
  sum(oi.quantity) as total_items_purchased,
  count(DISTINCT o.order_id)
FROM customers c
  join orders o on c.customer_id = o.customer_id
  join order_items oi on o.order_id = oi.order_id
GROUP BY c.customer_id,
  c.name
ORDER BY total_items_purchased DESC
LIMIT 1;
-- Most frequently purchased items
SELECT p.product_name,
  p.category,
  count(DISTINCT o.order_id) as number_of_orders,
  sum(oi.quantity) as total_units_sold,
  round(sum(oi.quantity * oi.price), 2) as total_revenue
from products p
  JOIN order_items oi ON p.product_id = oi.product_id
  JOIN orders o on oi.order_id = o.order_id
GROUP BY p.product_id,
  p.product_name,
  p.category
ORDER BY total_units_sold DESC
LIMIT 5;