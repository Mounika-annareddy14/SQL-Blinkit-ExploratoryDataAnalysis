/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

--which 5 products generate the highest revenue
SELECT TOP 5
product_name,
SUM(total_cost) AS total_revenue
FROM gold.fact_orders
GROUP BY product_name
ORDER BY total_revenue DESC

SELECT *
FROM (
	SELECT
	product_name,
	SUM(total_cost) AS total_revenue,
	RANK() OVER(ORDER BY SUM(total_cost) DESC) AS rank_products
	FROM gold.fact_orders
	GROUP BY product_name)t
WHERE rank_products<=5
ORDER BY total_revenue DESC

--5 worst performing products in terms of sales
SELECT TOP 5
product_name,
SUM(total_cost) AS total_revenue
FROM gold.fact_orders
GROUP BY product_name
ORDER BY total_revenue 

--Find the top 10 customers who have generated the highest revenue
SELECT *
FROM (
	SELECT
	customer_id,
	SUM(total_cost) AS total_revenue,
	RANK() OVER(ORDER BY SUM(total_cost) DESC) AS rank_customers
	FROM gold.fact_orders
	GROUP BY customer_id)t
WHERE rank_customers<=10
ORDER BY total_revenue DESC

-- The 3 customers with the fewest orders placed
WITH customer_orders AS (
    SELECT
        customer_id,
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders,
        RANK() OVER (ORDER BY COUNT(DISTINCT order_id) ASC) AS rnk
    FROM gold.fact_orders
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    total_orders
FROM customer_orders
WHERE rnk <= 3
ORDER BY tot
