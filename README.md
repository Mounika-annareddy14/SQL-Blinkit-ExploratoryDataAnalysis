# SQL-Blinkit-ExploratoryDataAnalysis
Exploratory Data Analysis (EDA) on Blinkit retail data to understand customer behavior, sales patterns, product performance, delivery efficiency, feedback sentiment, and inventory trends after building the data warehouse model.

# 🔎 Exploratory Data Analysis (Gold Layer)

Basic exploratory analysis was performed on the **Gold Layer** to validate that the data warehouse is fully analytics-ready.

EDA was conducted using the following views:

* `gold.fact_orders`
* `gold.fact_inventory`
* `gold.dim_customers`
* `gold.dim_products`

## 📊 Analysis Performed

* Calculation of key business KPIs:

  * Total Sales
  * Total Orders
  * Total Quantity Sold
  * Average Selling Price
  * Total Customers & Products
* Ranking analysis:

  * Top / Bottom performing products
  * Top customers by revenue
  * Customers with fewest orders
* Distribution analysis:

  * Customer distribution by area and segment
  * Product distribution by category
  * Sales distribution across areas
* Time range validation:

  * Order date range
  * Inventory date range
  * Campaign date range

## ✅ Outcome

This analysis confirms that the **Gold Layer** is properly modeled and ready for:

* Dashboarding (Power BI / Tableau)
* Business reporting
* Advanced data analysis

> Further advanced analysis will be added in the next phase of the project.
