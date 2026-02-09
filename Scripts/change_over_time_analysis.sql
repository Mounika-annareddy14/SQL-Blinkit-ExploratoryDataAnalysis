/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/


--How is Blinkit revenue changing month by month?
SELECT
    DATETRUNC(month, order_date) AS order_month,
    SUM(total_cost) AS total_revenue,
	COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity
FROM DatawarehouseAnalytics.dbo.[gold.fact_orders]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY order_month;

--yearly revenue trend
SELECT 
	year(order_date) AS order_year,
	COUNT(DISTINCT customer_id) AS total_customers,
	COUNT(distinct order_id) AS total_orders,
	ROUND(SUM(total_cost) ,2) AS total_revenue,
	SUM(quantity) AS total_quantity
FROM DatawarehouseAnalytics.dbo.[gold.fact_orders]
GROUP BY year(order_date)
ORDER BY order_year;

--MONTH NAME
SELECT
	FORMAT(order_date , 'yyyy-MMM') AS order_month,
	COUNT(distinct customer_id) AS total_customers,
	COUNT(Distinct order_id) AS total_orders,
	ROUND(SUM(total_cost),2) AS total_revenue,
	SUM(quantity) As total_quantity
FROM DatawarehouseAnalytics.dbo.[gold.fact_orders]
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY order_month;
