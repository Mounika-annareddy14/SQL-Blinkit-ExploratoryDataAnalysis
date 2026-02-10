USE DatawarehouseAnalytics;
GO

IF OBJECT_ID('report_customers','V') IS NOT NULL
    DROP VIEW report_customers;
GO

CREATE VIEW report_customers AS

WITH base AS (
    SELECT
        o.customer_id,
        o.customer_name,
        o.order_id,
        o.order_date,
        o.product_id,
        o.quantity,
        o.total_cost,
        o.delivery_status,
        o.sentiment,
        o.payment_method
    FROM dbo.[gold.fact_orders] o
),

customer_agg AS (
    SELECT
        customer_id,
        customer_name,

        -- Core metrics
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(SUM(total_cost),2) AS total_spent,
        ROUND(SUM(quantity),2) AS total_quantity,
        COUNT(DISTINCT product_id) AS total_products,

        -- Lifespan & recency
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan_months,
        DATEDIFF(month, MAX(order_date), GETDATE()) AS recency_months,

        -- Delivery analysis
        SUM(CASE WHEN delivery_status = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slightly_delayed_orders,
        SUM(CASE WHEN delivery_status = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significantly_delayed_orders,

        AVG(
            CASE 
                WHEN delivery_status = 'OnTime' THEN 0
                WHEN delivery_status = 'Slightly Delayed' THEN 1
                WHEN delivery_status = 'Significantly Delayed' THEN 2
            END
        ) AS avg_delay_score,

        -- Feedback analysis
        SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_feedbacks,
        SUM(CASE WHEN sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_feedbacks,

        -- Payment behavior
        SUM(CASE WHEN payment_method = 'COD' THEN 1 ELSE 0 END) AS cod_orders,
        SUM(CASE WHEN payment_method = 'UPI' THEN 1 ELSE 0 END) AS upi_orders,
        SUM(CASE WHEN payment_method = 'Card' THEN 1 ELSE 0 END) AS card_orders

    FROM base
    GROUP BY customer_id, customer_name
)

SELECT
    customer_id,
    customer_name,
    total_orders,
    total_spent,
    total_quantity,
    total_products,
    first_order_date,
    last_order_date,
    lifespan_months,
    recency_months,
    slightly_delayed_orders,
    significantly_delayed_orders,
    avg_delay_score,
    negative_feedbacks,
    positive_feedbacks,
    cod_orders,
    upi_orders,
    card_orders,

    -- KPIs
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(total_spent / total_orders,2)
    END AS avg_order_value,

    CASE 
        WHEN lifespan_months = 0 THEN total_spent
        ELSE ROUND(total_spent / lifespan_months,2)
    END AS avg_monthly_spend,

    -- Smart Customer Segmentation
    CASE
        WHEN avg_delay_score > 1.2 THEN 'High Delivery Issue Customer'
        WHEN negative_feedbacks > 3 THEN 'Unhappy Customer'
        WHEN cod_orders > upi_orders AND cod_orders > card_orders THEN 'Prefers COD'
        WHEN lifespan_months >= 6 AND total_spent > 10000 THEN 'VIP'
        ELSE 'Regular'
    END AS customer_segment

FROM customer_agg;
GO

SELECT * from report_customers;
