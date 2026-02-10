--Category contribution to total revenue
WITH category_sales AS (
	SELECT 
		p.category,
		ROUND(SUM(o.total_cost),2) As total_revenue
	FROM dbo.[gold.fact_orders] o
	LEFT JOIN dbo.[gold.dim_products] p
		ON o.order_key = p.product_key
	WHERE p.category IS NOT NULL
	GROUP BY p.category
)
SELECT 
	category,
	total_revenue,
	SUM(total_revenue) OVER() As overall_revenue,
	ROUND((total_revenue *100.0) / SUM(total_revenue) over(),2) AS revenue_percentage
FROM category_sales
order by total_revenue DESC;


--Top products
WITH product_sales AS (
    SELECT
        p.product_name,
        ROUND(SUM(o.total_cost),2) AS total_revenue
    FROM dbo.[gold.fact_orders] o
    JOIN dbo.[gold.dim_products] p
        ON o.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    total_revenue,
    SUM(total_revenue) OVER () AS overall_revenue,
    ROUND((total_revenue * 100.0) / SUM(total_revenue) OVER (), 2) AS revenue_percentage
FROM product_sales
ORDER BY revenue_percentage DESC;

--area contribution
WITH area_orders AS (
    SELECT
        c.area,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM dbo.[gold.fact_orders] o
    JOIN dbo.[gold.dim_customers] c
        ON o.customer_id = c.customer_id
    GROUP BY c.area
)
SELECT
    area,
    total_orders,
    SUM(total_orders) OVER () AS overall_orders,
    ROUND((total_orders * 100.0) / SUM(total_orders) OVER (), 2) AS order_percentage
FROM area_orders
ORDER BY order_percentage DESC;

--customer segement contrivution to revnue
WITH segment_sales AS (
    SELECT
        c.customer_segment,
        SUM(o.total_cost) AS total_revenue
    FROM dbo.[gold.fact_orders] o
    JOIN dbo.[gold.dim_customers] c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_segment
)
SELECT
    customer_segment,
    total_revenue,
    SUM(total_revenue) OVER () AS overall_revenue,
    ROUND((total_revenue * 100.0) / SUM(total_revenue) OVER (), 2) AS revenue_percentage
FROM segment_sales
ORDER BY revenue_percentage DESC;
