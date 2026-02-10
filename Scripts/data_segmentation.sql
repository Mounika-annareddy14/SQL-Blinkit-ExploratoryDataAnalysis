
--Customer Segmentation (VIP / Regular / New)
WITH customer_spending AS(
	SELECT
		customer_id,
		ROUND(SUM(total_cost),2) AS total_spending,
		MIN(order_date) AS first_order,
		MAX(order_date) AS last_order,
		DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
	FROM dbo.[gold.fact_orders]
	GROUP BY customer_id
)
SELECT
	customer_id,
	total_spending,
	lifespan,
	CASE
		WHEN total_spending >=12000 and lifespan >=7 THEN 'VIP'
		WHEN total_spending < 12000 and lifespan <=6 THEN 'Regular'
	    ELSE 'New'
	END AS customer_segment	
FROM customer_spending
ORDER BY total_spending DESC;

--Product segemtation (HIGH MEDIUM LOW performers)
WITH product_revenue AS (
	SELECT
			product_id,
			product_name,
			ROUND(SUM(total_cost),2) AS total_revenue
	FROM dbo.[gold.fact_orders]
	GROUP BY product_id,product_name
)
SELECT 
	product_id,
	product_name,
	total_revenue,
	CASE
		WHEN total_revenue >= 50000 THEN 'HighPerformer'
		WHEN total_revenue < 50000 THEN 'MidPerformer'
		ELSE 
			'LowPerformer'
	END product_segment
FROM product_revenue
ORDER BY total_revenue DESC;

--Order Value Segmentation (Small / Medium / Bulk Orders)
SELECT 
	order_id,
	ROUND(SUM(total_cost),2) AS order_value,
	CASE 
		WHEN sum(total_cost) < 500 THEN 'Small order'
		WHEN sum(total_cost) BETWEEN 500 and 1000 THEN 'Medium order'
		ELSE 'Bulk order'
	END order_segment
FROM dbo.[gold.fact_orders]
GROUP BY order_id
order by order_value DESC;

--area segment
WITH area_revenue AS (
    SELECT
        area,
        ROUND(SUM(total_cost),2) AS total_revenue
    FROM dbo.[gold.fact_orders]
    GROUP BY area
)

SELECT
    area,
    total_revenue,
    CASE
        WHEN total_revenue > 50000 THEN 'High Revenue Area'
        WHEN total_revenue <= 50000 THEN 'Medium Revenue Area'
        ELSE 'Low Revenue Area'
    END AS area_segment
FROM area_revenue
ORDER BY total_revenue DESC;
