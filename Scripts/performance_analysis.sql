WITH yearly_product_sales AS (
	SELECT 
		YEAR(o.order_date) AS order_year,
		p.product_name,
		ROUND(SUM(o.total_cost),2) AS current_sales
	FROM DatawarehouseAnalytics.dbo.[gold.fact_orders] o
	LEFT JOIN DatawarehouseAnalytics.dbo.[gold.dim_products] p
		ON o.product_id = p.product_id
	WHERE o.order_date IS NOT NULL
	GROUP BY 
		YEAR(o.order_date),
		p.product_name
)
SELECT
order_year,
product_name,
current_sales,

--Product average comparisions
AVG(current_sales) OVER(partition by product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER(partition by product_name) AS diff_from_avg,
CASE 
	WHEN current_sales > AVG(current_sales) OVER(partition by product_name)
		THEN 'Above avg'
	WHEN current_sales < AVG(current_sales) OVER(partition by product_name)
		THEN 'Below avg'
	ELSE
		'Avg'
END AS avg_change,

--YEAR over YEAR comparision
LAG(current_sales) OVER(partition by product_name order by order_year) AS prv_yr_sales,
current_sales - LAG(current_sales) OVER(partition by product_name order by order_year) AS yoy_diff,

CASE 
	WHEN current_sales > LAG(current_sales) OVER(partition by product_name order by order_year)
		THEN 'Increase'
	WHEN current_sales < LAG(current_sales) OVER(partition by product_name order by order_year)
		THEN 'Decrease'
	ELSE 
		'NO change'
	END AS yoy_trend
	FROM yearly_product_sales
ORDER BY product_name, order_year;

