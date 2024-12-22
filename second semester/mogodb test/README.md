# MongoDB E-commerce Database Documentation

## Overview

This documentation covers the implementation of an e-commerce database system using MongoDB, including schema design, advanced features, and usage instructions.

## Schema Design

### Collections Structure

1. **Customers Collection**

   - Referenced design
   - Primary fields: customer_id, name, email, address
   - Indexes: customer_id (unique), email (unique), address.state

2. **Products Collection**

   - Referenced design
   - Primary fields: product_id, product_name, category, price
   - Schema validation enforced
   - Indexes: product_id (unique), category, product_name

3. **Orders Collection**

   - Referenced design
   - Primary fields: order_id, customer_id, order_date, status
   - Monitored by change streams
   - Indexes: order_id (unique), customer_id, order_date (desc)

4. **Order_Items Collection**
   - Referenced design
   - Primary fields: order_item_id, order_id, product_id, quantity, price
   - Indexes: order_item_id (unique), order_id, product_id

## Setup Instructions

### Prerequisites

- MongoDB server running on 0.0.0.0/0
- Python 3.x
- PyMongo library

### Installation Steps

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install pymongo
   ```
3. Run the setup scripts in order:
   ```bash
   python mongodb_setup.py
   python schema_optimization.py
   python advanced_features.py
   ```

## Advanced Features

### Transactions

The system implements ACID transactions for order creation:

- Atomically creates new orders
- Updates inventory
- Handles rollback on failure
- Usage example:
  ```python
  create_order_with_inventory_update(
      customer_id=1,
      items=[{"product_id": 101, "quantity": 1}]
  )
  ```

### Change Streams

Real-time monitoring of order updates:

- Tracks inserts, updates, and deletions
- Provides real-time notifications
- Usage:
  ```python
  monitor_orders()  # Run in separate process
  ```

### Schema Validation

Enforces data integrity for products:

- Requires all mandatory fields
- Validates price as positive number
- Prevents invalid document insertion

## Query Examples

### Category Revenue Analysis

```python
db.products.aggregate([
    {"$lookup": {
        "from": "order_items",
        "localField": "product_id",
        "foreignField": "product_id",
        "as": "sales"
    }},
    {"$unwind": "$sales"},
    {"$group": {
        "_id": "$category",
        "total_revenue": {
            "$sum": {"$multiply": ["$sales.quantity", "$sales.price"]}
        }
    }}
])
```

### Customer Distribution

```python
db.customers.aggregate([
    {"$group": {
        "_id": "$address.state",
        "customer_count": {"$sum": 1}
    }},
    {"$sort": {"customer_count": -1}}
])
```

## Performance Considerations

- Indexed fields for common queries
- Compound indexes for complex queries
- Schema validation for data integrity
- Transaction support for data consistency

## Monitoring and Maintenance

- Use change streams for real-time monitoring
- Regular index maintenance
- Backup recommendations
- Performance monitoring tips

## Troubleshooting

Common issues and solutions:

1. Connection errors: Check MongoDB service status
2. Validation errors: Review schema requirements
3. Transaction failures: Check network connectivity
4. Index performance: Review query patterns

## Security Recommendations

1. Enable authentication
2. Use SSL/TLS for connections
3. Implement role-based access
4. Regular security audits
