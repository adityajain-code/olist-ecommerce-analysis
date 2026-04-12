-- OLIST DATA LOAD SCRIPT
USE olist;

-- Enable local infile (may require admin privileges)
SET GLOBAL local_infile = 1;

-- 1. CUSTOMERS
LOAD DATA LOCAL INFILE 'data/olist_customers_dataset.csv'
INTO TABLE olist_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. SELLERS
LOAD DATA LOCAL INFILE 'data/olist_sellers_dataset.csv'
INTO TABLE olist_sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. PRODUCTS
LOAD DATA LOCAL INFILE 'data/olist_products_dataset.csv'
INTO TABLE olist_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 4. CATEGORY TRANSLATION
LOAD DATA LOCAL INFILE 'data/product_category_name_translation.csv'
INTO TABLE olist_category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 5. ORDERS
LOAD DATA LOCAL INFILE 'data/olist_orders_dataset.csv'
INTO TABLE olist_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, order_status,
 @purchase_ts, @approved_at, @carrier_date,
 @delivered_date, @estimated_date)
SET
order_purchase_timestamp = NULLIF(@purchase_ts, ''),
order_approved_at = NULLIF(@approved_at, ''),
order_delivered_carrier_date = NULLIF(@carrier_date, ''),
order_delivered_customer_date = NULLIF(@delivered_date, ''),
order_estimated_delivery_date = NULLIF(@estimated_date, '');

-- 6. ORDER ITEMS
LOAD DATA LOCAL INFILE 'data/olist_order_items_dataset.csv'
INTO TABLE olist_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_item_id, product_id, seller_id,
 @shipping_limit, price, freight_value)
SET
shipping_limit_date = NULLIF(@shipping_limit, '');

-- 7. PAYMENTS
LOAD DATA LOCAL INFILE 'data/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 8. REVIEWS
LOAD DATA LOCAL INFILE 'data/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(review_id, order_id, review_score,
 review_comment_title, review_comment_message,
 @creation_date, @answer_ts)
SET
review_creation_date = NULLIF(@creation_date, ''),
review_answer_timestamp = NULLIF(@answer_ts, '');

-- 9. GEOLOCATION
LOAD DATA LOCAL INFILE 'data/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- VALIDATION CHECKS
SELECT 'customers' AS table_name, COUNT(*) FROM olist_customers
UNION ALL
SELECT 'orders', COUNT(*) FROM olist_orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist_order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM olist_order_payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM olist_order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM olist_products
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist_sellers;

-- Sample join test
SELECT o.order_id, c.customer_id, oi.product_id
FROM olist_orders o
JOIN olist_customers c ON o.customer_id = c.customer_id
JOIN olist_order_items oi ON o.order_id = oi.order_id
LIMIT 10;