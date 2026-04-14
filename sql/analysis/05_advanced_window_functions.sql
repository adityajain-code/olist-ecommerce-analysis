-- ============================================
-- Question 5: Running Total of Monthly Revenue
-- What is the cumulative revenue growth over time?
-- Tables: orders, order_items
-- ============================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
    FROM orders o
    INNER JOIN order_items oi
    ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY order_month
    ORDER BY order_month
)
SELECT
    order_month,
    revenue,
    SUM(revenue) OVER (ORDER BY order_month) AS running_total
FROM monthly_revenue;

-- ============================================
-- Question 6: Seller Revenue Rank
-- How do all sellers rank against each other by total revenue?
-- Tables: orders, order_items, sellers
-- ============================================

SELECT
	seller_id,
    revenue,
    DENSE_RANK() OVER (ORDER BY revenue DESC) AS seller_rnk
FROM (
	SELECT
		s.seller_id,
		ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
	FROM orders o
	INNER JOIN order_items oi
	ON o.order_id = oi.order_id
	INNER JOIN sellers s
	ON oi.seller_id = s.seller_id
	WHERE o.order_status = 'delivered'
	GROUP BY s.seller_id
) AS t;

-- ============================================
-- Question 7: Month-over-Month Revenue Growth
-- How did revenue change month over month?
-- Tables: orders, order_items
-- ============================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
    FROM orders o
    INNER JOIN order_items oi
    ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY order_month
    ORDER BY order_month
), lagged AS (
	SELECT
		order_month,
		revenue,
		LAG(revenue) OVER (ORDER BY order_month) AS prev_revenue
	FROM monthly_revenue
)
SELECT
	order_month,
    revenue,
    prev_revenue,
    ROUND((revenue - prev_revenue) / prev_revenue * 100, 2) AS mom_growth
FROM lagged;