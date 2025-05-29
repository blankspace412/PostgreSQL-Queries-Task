CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    email         VARCHAR(100),
    state         CHAR(2)
);


CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT REFERENCES customers(customer_id),
    order_date    DATE,
    total_amount  NUMERIC(10, 2)
);

CREATE TABLE order_items (
    order_id     INT,
    item_id      INT PRIMARY KEY,
    product_id   INT,
    quantity     INT,
    unit_price   NUMERIC(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- QUESTION 1: List all customers from California (CA)

SELECT * 
FROM customers 
WHERE state = 'CA';

-- QUESTION 2: Find the total number of orders placed

SELECT COUNT(*) AS total_orders 
FROM orders;

-- QUESTION 3: Show the order IDs and total amounts, ordered by highest amount

SELECT order_id, total_amount 
FROM orders 
ORDER BY total_amount DESC;

-- QUESTION 4: Count how many customers are from each state

SELECT state, COUNT(*) AS customer_count 
FROM customers 
GROUP BY state;

--  QUESTION 5: Get all orders placed by customer with ID 5

SELECT * 
FROM orders 
WHERE customer_id = 5;

-- QUESTION 6: Get total sales (quantity × price) per product

SELECT product_id, SUM(quantity * unit_price) AS total_sales
FROM order_items
GROUP BY product_id;

-- QUESTION 7: Find the top 3 customers by total amount spent

SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;

-- QUESTION 8: List all orders that include more than 2 different products

SELECT order_id, COUNT(DISTINCT product_id) AS product_count
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) > 2;

-- QUESTION 9: Create a view showing each order with total quantity and total value

CREATE VIEW order_summary AS
SELECT order_id,
       SUM(quantity) AS total_items,
       SUM(quantity * unit_price) AS total_value
FROM order_items
GROUP BY order_id;

-- QUESTION 10: Find customers who have never placed an order

SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;






