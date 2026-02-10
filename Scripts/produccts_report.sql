USE DatawarehouseAnalytics;
GO

IF OBJECT_ID('report_products','V') IS NOT NULL
    DROP VIEW report_products;
GO

CREATE VIEW report_products AS

WITH base AS (
    SELECT
        o.product_id,
        o.product_name,
        o.category,
        o.brand,
        o.order_id,
        o.customer_id,
        o.order_date,
        o.quantity,
        o.total_cost,
        o.delivery_status,
        o.sentiment
    FROM dbo.[gold.fact_orders] o
),

product_agg AS (
    SELECT
        product_id,
        product_name,
        category,
        brand,

        -- Core metrics
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(DISTINCT customer_id) AS total_customers,
        round(SUM(quantity),2) AS total_quantity,
        round(SUM(total_cost),2) AS total_revenue,

        -- Lifespan & recency
        MIN(order_date) AS first_sale_date,
        MAX(order_date) AS last_sale_date,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan_months,
        DATEDIFF(month, MAX(order_date), GETDATE()) AS recency_months,

        -- Delivery impact
        SUM(CASE WHEN delivery_status = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slightly_delayed,
        SUM(CASE WHEN delivery_status = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significantly_delayed,

        -- Feedback impact
        SUM(CASE WHEN sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_feedbacks,
        SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_feedbacks

    FROM base
    GROUP BY
        product_id,
        product_name,
        category,
        brand
)

SELECT
    product_id,
    product_name,
    category,
    brand,
    total_orders,
    total_customers,
    total_quantity,
    total_revenue,
    first_sale_date,
    last_sale_date,
    lifespan_months,
    recency_months,
    slightly_delayed,
    significantly_delayed,
    positive_feedbacks,
    negative_feedbacks,

    -- KPIs
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE round(total_revenue / total_orders,2)
    END AS avg_order_revenue,

    CASE
        WHEN lifespan_months = 0 THEN total_revenue
        ELSE round(total_revenue / lifespan_months,2)
    END AS avg_monthly_revenue,

    -- Smart Product Segmentation
    CASE
        WHEN total_revenue > 50000 THEN 'High Performer'
        WHEN total_revenue BETWEEN 15000 AND 50000 THEN 'Mid Performer'
        WHEN negative_feedbacks > positive_feedbacks THEN 'Customer Issue Product'
        WHEN significantly_delayed > 5 THEN 'Delivery Issue Product'
        ELSE 'Low Performer'
    END AS product_segment

FROM product_agg;
GO

