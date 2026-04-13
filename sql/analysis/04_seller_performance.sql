-- ============================================
-- Question 4: Seller Performance
-- Who are the top 10 sellers by revenue and how do their review scores compare?
-- Tables: order_items, orders, order_reviews, sellers
-- ============================================

SELECT
	s.seller_id,
	ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
    ROUND(AVG(ore.review_score), 2) AS avg_review_score
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN order_reviews ore
ON o.order_id = ore.order_id
INNER JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
ORDER BY revenue DESC
LIMIT 10;