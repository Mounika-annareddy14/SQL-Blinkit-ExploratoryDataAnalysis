--Cumulative Revenue Growth (Orders)
SELECT
order_date,
monthly_revenue,
SUM(monthly_revenue) over(partition by order_date order by order_date) AS running_revenue,
avg_price,
AVG(avg_price) over(order by order_date) AS moving_price
FROM(
	SELECT
		DATETRUNC(year,order_date) AS order_date,
		ROUND(SUM(total_cost),2) AS monthly_revenue,
		ROUND(AVG(unit_price),2) AS avg_price
		FROM DatawarehouseAnalytics.dbo.[gold.fact_orders]
		GROUP BY DATETRUNC(year,order_date)
	)t


-- Inventory stock added overtiime
Select 
	order_date,
	year_stock_added,
	SUM(year_stock_added) OVER(order by order_date) as running_stock
FROM(
	SELECT
		DATETRUNC(year,inventory_date) as order_date,
		SUM(stock_received) As year_stock_added
	FROM DatawarehouseAnalytics.dbo.[gold.fact_inventory]
	GROUP BY DATETRUNC(year,inventory_date)
	)t

--Cumulative Marketing Effort Over Time
SELECT
    campaign_month,
    monthly_campaigns,
    SUM(monthly_campaigns) OVER (ORDER BY campaign_month) AS running_campaigns
FROM (
    SELECT
        DATETRUNC(month, campaign_date) AS campaign_month,
        COUNT(marketing_key) AS monthly_campaigns
    FROM DatawarehouseAnalytics.dbo.[gold.fact_marketing]
    GROUP BY DATETRUNC(month, campaign_date)
) t
ORDER BY campaign_month;
