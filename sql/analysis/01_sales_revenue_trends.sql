-- ============================================
-- Question 1: Sales & Revenue Trends
-- How has monthly revenue trended over time?
-- Tables: orders, order_items
-- ============================================

SELECT
	DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
	ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;