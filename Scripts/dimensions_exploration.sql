
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
--Explore all areas where our customers from
SELECT DISTINCT area FROM
gold.dim_customers;

-- Explore all segments where our customer belongs to
SELECT DISTINCT customer_segment FROM
gold.dim_customers;

--Explore all product names,categories,brand
SELECT DISTINCT product_name,category,brand FROM
gold.dim_products
ORDER BY 1,2,3;
