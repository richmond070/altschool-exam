-- JOINS
-- INNER JOIN: Show all orders with customer and product details
SELECT o.order_id,
  c.name as customer_name,
  p.product_name,
  oi.quantity,
  oi.price
FROM Orders o
  INNER JOIN Customers c ON o.customer_id = c.customer_id
  INNER JOIN Order_Items oi ON o.order_id = oi.order_id
  INNER JOIN Products p ON oi.product_id = p.product_id;
-- LEFT JOIN: Show all customers and their orders (including customers with no orders)
SELECT c.name,
  c.email,
  COUNT(o.order_id) as total_orders
FROM Customers c
  LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
  c.name,
  c.email;
-- FULL JOIN 
SELECT c.name,
  o.order_id
FROM customers c
  FULL JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.name;
--WINDOW FUNCTIONS
-- RANK(): Rank customers by total spending
SELECT name,
  total_spent,
  customer_rank
FROM (
    SELECT c.name,
      SUM(oi.quantity * oi.price) as total_spent,
      RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.price) DESC
      ) as customer_rank
    FROM Customers c
      JOIN Orders o ON c.customer_id = o.customer_id
      JOIN Order_Items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id,
      c.name
  ) ranked_customers;
-- ROW_NUMBER(): Number each customer's orders chronologically
SELECT c.name,
  o.order_date,
  o.order_id,
  ROW_NUMBER() OVER (
    PARTITION BY c.customer_id
    ORDER BY o.order_date
  ) as order_sequence
FROM Customers c
  JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.name,
  o.order_date;
--CTE AND SUBQUERIES
-- CTE: Find customers with total revenue > $500
WITH CustomerRevenue AS (
  SELECT c.customer_id,
    c.name,
    SUM(oi.quantity * oi.price) as total_revenue
  FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
  GROUP BY c.customer_id,
    c.name
)
SELECT name,
  ROUND(total_revenue, 2) as total_revenue
FROM CustomerRevenue
WHERE total_revenue > 500
ORDER BY total_revenue DESC;
-- Subquery: Find products priced higher than average
SELECT product_name,
  price,
  (
    SELECT AVG(price)
    FROM Products
  ) as avg_price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
  )
ORDER BY price DESC;
-- INDEXING 
-- Create indexes for frequently queried fields
/*CREATE INDEX idx_customer_id ON Orders(customer_id);
 CREATE INDEX idx_product_id ON Order_Items(product_id);
 CREATE INDEX idx_order_date ON Orders(order_date);*/
--checking index usage in a query
EXPLAIN
SELECT c.name,
  COUNT(o.order_id) as total_orders
FROM Customers c
  JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
GROUP BY c.customer_id,
  c.name;
-- Finding top customers and amount spent 
WITH MonthlyCustomerStats AS (
  SELECT c.customer_id,
    c.name,
    TO_CHAR(o.order_date, 'YYYY-MM') as month,
    SUM(oi.quantity * oi.price) as monthly_spent,
    COUNT(DISTINCT o.order_id) as orders_in_month,
    ROW_NUMBER() OVER (
      PARTITION BY TO_CHAR(o.order_date, 'YYYY-MM')
      ORDER BY SUM(oi.quantity * oi.price) DESC
    ) as monthly_rank
  FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
  GROUP BY c.customer_id,
    c.name,
    TO_CHAR(o.order_date, 'YYYY-MM')
)
SELECT month,
  name as top_customer,
  ROUND(monthly_spent, 2) as amount_spent,
  orders_in_month
FROM MonthlyCustomerStats
WHERE monthly_rank = 1
ORDER BY month;