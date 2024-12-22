-- Inserting Customers
INSERT INTO Customers (name, email, phone_number, address)
VALUES (
    'John Smith',
    'john.smith@email.com',
    '(555) 123-4567',
    '123 Main St, Springfield, IL 62701'
  ),
  (
    'Emily Johnson',
    'emily.j@gmail.com',
    '(555) 987-6543',
    '456 Oak Avenue, Rivertown, CA 90210'
  ),
  (
    'Michael Chen',
    'michael.chen@outlook.com',
    '(555) 246-8135',
    '789 Maple Road, Lakeside, WA 98001'
  ),
  (
    'Sarah Rodriguez',
    'sarah.rod@yahoo.com',
    '(555) 369-2580',
    '321 Pine Street, Mountainview, CO 80301'
  ),
  (
    'David Kim',
    'david.kim@hotmail.com',
    '(555) 159-7530',
    '654 Birch Lane, Oceanside, FL 33433'
  ),
  (
    'Rachel Williams',
    'rachel.w@gmail.com',
    '(555) 753-9514',
    '987 Cedar Court, Greenville, TX 75401'
  ),
  (
    'Christopher Lee',
    'chris.lee@email.com',
    '(555) 852-4762',
    '258 Elm Street, Sunnyvale, NY 12345'
  ),
  (
    'Amanda Martinez',
    'amanda.m@outlook.com',
    '(555) 741-9630',
    '147 Willow Drive, Riverside, OR 97301'
  ),
  (
    'Thomas Brown',
    'thomas.brown@yahoo.com',
    '(555) 963-8520',
    '369 Redwood Avenue, Portland, MI 49503'
  ),
  (
    'Jessica Garcia',
    'jessica.g@hotmail.com',
    '(555) 147-2589',
    '582 Sycamore Road, Salem, NJ 08001'
  );
-- Inserting Products
INSERT INTO Products (product_name, category, price, stock_quantity)
VALUES (
    'Wireless Bluetooth Headphones',
    'Electronics',
    79.99,
    150
  ),
  (
    'Stainless Steel Water Bottle',
    'Outdoor Gear',
    24.50,
    300
  ),
  (
    'Organic Coffee Beans - Medium Roast',
    'Food & Beverage',
    15.99,
    200
  ),
  (
    'Ergonomic Office Chair',
    'Furniture',
    249.99,
    50
  ),
  (
    'Fitness Tracker Watch',
    'Electronics',
    99.95,
    100
  ),
  ('Non-Stick Cookware Set', 'Kitchen', 129.99, 75),
  ('Yoga Mat', 'Fitness', 39.99, 225),
  (
    'Portable Bluetooth Speaker',
    'Electronics',
    59.99,
    180
  ),
  (
    'Leather Messenger Bag',
    'Accessories',
    89.50,
    60
  ),
  (
    'Gourmet Chocolate Collection',
    'Food & Beverage',
    34.99,
    120
  );
-- Inserting Orders
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES (3, '2024-01-15', 104.49),
  (1, '2024-01-16', 249.99),
  (5, '2024-01-17', 79.99),
  (2, '2024-01-18', 189.48),
  (7, '2024-01-19', 129.99),
  (4, '2024-01-20', 314.96),
  (6, '2024-01-21', 99.95),
  (8, '2024-01-22', 59.99),
  (10, '2024-01-23', 174.97),
  (9, '2024-01-24', 89.50),
  (1, '2024-01-25', 54.98),
  (3, '2024-01-26', 249.99),
  (5, '2024-01-27', 139.48),
  (2, '2024-01-28', 79.99),
  (7, '2024-01-29', 44.99),
  (4, '2024-01-30', 184.97),
  (6, '2024-01-31', 129.99),
  (8, '2024-02-01', 99.95),
  (10, '2024-02-02', 59.99),
  (9, '2024-02-03', 174.97);
-- Inserting Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES (1, 3, 2, 15.99),
  (1, 2, 1, 24.50),
  (2, 4, 1, 249.99),
  (3, 1, 1, 79.99),
  (4, 6, 1, 129.99),
  (4, 5, 1, 59.49),
  (5, 6, 1, 129.99),
  (6, 7, 2, 39.99),
  (6, 8, 2, 59.99),
  (6, 5, 1, 99.95),
  (7, 5, 1, 99.95),
  (8, 8, 1, 59.99),
  (9, 9, 1, 89.50),
  (9, 10, 2, 34.99),
  (10, 9, 1, 89.50),
  (11, 2, 2, 24.50),
  (12, 4, 1, 249.99),
  (13, 3, 3, 15.99),
  (13, 1, 1, 79.99),
  (14, 1, 1, 79.99),
  (15, 7, 1, 39.99),
  (15, 10, 1, 34.99),
  (16, 6, 1, 129.99),
  (16, 5, 1, 59.49),
  (16, 8, 1, 59.99),
  (17, 6, 1, 129.99),
  (18, 5, 1, 99.95),
  (19, 8, 1, 59.99),
  (20, 9, 1, 89.50),
  (20, 10, 2, 34.99),
  (6, 3, 1, 15.99),
  (9, 2, 1, 24.50),
  (13, 7, 1, 39.99),
  (16, 1, 1, 79.99),
  (17, 8, 1, 59.99),
  (18, 7, 1, 39.99),
  (19, 3, 1, 15.99),
  (20, 5, 1, 99.95),
  (4, 2, 1, 24.50),
  (11, 10, 1, 34.99),
  (12, 9, 1, 89.50),
  (14, 7, 1, 39.99),
  (15, 6, 1, 129.99),
  (2, 8, 1, 59.99),
  (5, 1, 1, 79.99),
  (7, 3, 1, 15.99),
  (10, 5, 1, 99.95),
  (11, 4, 1, 249.99),
  (13, 2, 1, 24.50),
  (16, 10, 1, 34.99);