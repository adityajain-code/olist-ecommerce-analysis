-- ============================================
-- Question 3: Customer Satisfaction
-- What is the relationship between delivery time and review scores?
-- Tables: orders, order_reviews
-- ============================================

SELECT
	ore.review_score,
	ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)), 1) AS avg_delivery_time
FROM orders o
INNER JOIN order_reviews ore
ON o.order_id = ore.order_id
WHERE o.order_status = 'delivered'
GROUP BY ore.review_score
ORDER BY ore.review_score;