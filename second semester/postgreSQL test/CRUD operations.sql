-- ADDING A NEW CUSTOMER INTO THE DATABASE
insert INTO customers (name, email, phone_number, address)
VALUES (
    'Jane Eliot',
    'jane.eliot@email.com',
    '(555) 235-768',
    '123 Main St, Springfield, IL 62701'
  );
-- UPDATE THE STOCK QUANTITY OF A PRODUCT AFTER A PURCHASE
WITH total_sold_quantity as (
  SELECT DISTINCT(product_id),
    sum(quantity) as quantity_sold,
    sum(price) as price_sold
  FROM order_items
  GROUP BY product_id
  ORDER BY product_id
)
UPDATE products
set stock_quantity = stock_quantity - ts.quantity_sold
FROM total_sold_quantity ts
WHERE products.product_id = 1;
-- DELETE AN ORDER FROM THE DATABASE
DELETE from orders
where order_id = 6;
-- RETRIVE ALL ORDERS MADE BY A SPECIFIC CUSTOMER 
SELECT c.customer_id,
  c.name,
  p.product_name,
  p.category,
  p.price,
  oi.quantity,
  o.total_amount,
  o.order_date
FROM orders o
  JOIN customers c on o.customer_id = c.customer_id
  JOIN order_items oi ON oi.order_id = o.order_id
  LEFT JOIN products p ON p.product_id = oi.product_id
WHERE c.customer_id = 5;