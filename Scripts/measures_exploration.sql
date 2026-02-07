/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
--Finding total sales
SELECT
SUM(total_cost) as total_sales
FROM gold.fact_orders;

--Finding how many items are sold
SELECT
SUM(quantity) as total_quantity
FROM gold.fact_orders;

--Finding average selling price
SELECT
AVG(unit_price) as avg_price
FROM gold.fact_orders;

--Finding total no of  orders
SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM gold.fact_orders;

-- finding toatl no of products
SELECT
COUNT(distinct product_id) AS total_products
FROM gold.fact_orders;

-- Finding total number of customers
SELECT 
COUNT(DISTINCT customer_id) AS total_customers
from gold.dim_customers;

--Finding total number of customers that has placed a order
SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM gold.fact_orders

--Generating a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name , SUM(total_cost) AS measure_value from gold.fact_orders
UNION ALL
SELECT'Total quantity' AS measure_name, SUM(quantity) as measure_value FROM gold.fact_orders
UNION ALL
SELECT 'Average price' AS measure_name, AVG(unit_price) as measure_value FROM gold.fact_orders
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_id) FROM gold.fact_orders
UNION ALL
SELECT 'Total Products Sold', COUNT(DISTINCT product_id) FROM gold.fact_orders
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_id) FROM gold.fact_orders;
