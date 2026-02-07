/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

--Finding the first and last date of orders
--How many years of sales available
SELECT
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(year, MIN(order_date),MAX(order_date)) AS order_range_year
FROM gold.fact_orders;

--Finding the first and last inventories date
SELECT
MIN(inventory_date) AS old_invention,
MAX(inventory_date) AS latest_invention,
DATEDIFF(month,MIN(inventory_date),MAX(inventory_date)) AS invention_range
FROM gold.fact_inventory;

--Finding the first and last campaign
SELECT
MIN(campaign_date) as first_campaign,
MAX(campaign_date) as latest_campaign,
DATEDIFF(month,MIN(campaign_date), MAX(campaign_date)) AS campaign_range
FROM gold.fact_marketing_performance;
