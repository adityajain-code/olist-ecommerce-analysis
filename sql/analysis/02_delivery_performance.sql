-- ============================================
-- Question 2: Delivery Performance
-- How often are orders delivered late vs on time, and which states have the worst on-time delivery rate?
-- Tables: orders, customers
-- ============================================

-- Part A: Overall late vs on time count
SELECT
	CASE
		WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
		ELSE 'On Time'
    END AS delivery_status,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY delivery_status;

-- Part B: Late delivery rate by state
SELECT
	t.customer_state,
    t.total_orders,
    t.late_orders,
    ROUND((t.late_orders / t.total_orders) * 100, 2) AS late_percentage
FROM (
	SELECT
		c.customer_state,
		COUNT(o.order_id) AS total_orders,
		COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late' END) AS late_orders
	FROM customers c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	WHERE o.order_status = 'delivered'
	GROUP BY c.customer_state
) AS t
ORDER BY late_percentage DESC
LIMIT 10;