# 🛒 Blinkit Data Warehouse & Business Intelligence Project

## 📌 Project Overview

This project demonstrates an **end-to-end Data Analytics workflow** starting from raw Excel files to a fully interactive Power BI dashboard using a **SQL Data Warehouse architecture (Bronze → Silver → Gold)**.

The goal is to transform raw transactional data into meaningful business insights for:

* Sales Performance
* Customer Behavior
* Marketing Impact
* Product & Category Performance
* Delivery & Operational Efficiency

---

## 🗂️ Tech Stack Used

| Tool                                | Purpose                         |
| ----------------------------------- | ------------------------------- |
| Excel / CSV                         | Raw data source                 |
| SQL Server                          | Data Warehouse (ETL + Modeling) |
| SSMS                                | SQL Development                 |
| SQL (CTEs, Views, Window Functions) | Advanced analytics              |
| Power BI                            | Dashboard & Visualization       |
| DAX                                 | KPIs & Measures                 |

---

## 🏗️ Data Warehouse Architecture

### 🔹 Bronze Layer (Raw Data)

Raw CSV files loaded directly into SQL Server tables.

Tables:

* orders
* products
* customers
* category_icons
* rating_icons
* customer_feedback

---

### 🔹 Silver Layer (Cleaned & Transformed)

Data cleaning and standardization performed here:

* Corrected data types
* Removed nulls and duplicates
* Standardized date formats
* Created meaningful columns

---

### 🔸 Gold Layer (Business Ready Tables)

Fact & Dimension tables created for analytics.

**Dimension Tables**

* dim_customers
* dim_products

**Fact Tables**

* fact_orders
* fact_inventory
* fact_marketing

This layer is used directly in Power BI.

---

## 📊 Advanced SQL Analysis Performed

* Month-over-Month Revenue Trends
* Year-over-Year Product Performance
* Cumulative Sales Analysis
* Customer Segmentation
* Part-to-Whole (Category Contribution)
* Delivery Performance Analysis
* Marketing Impact Analysis
* Sentiment & Feedback Analysis
* Payment Method Analysis
* Inventory Utilization

Used SQL features:

* CTEs
* Window Functions (LAG, AVG OVER)
* Aggregations
* Date functions
* Views

---

## 📈 Power BI Dashboards Created

### 1️⃣ Sales Overview Dashboard

Insights:

* Total Revenue, Orders, Quantity, AOV
* Monthly Revenue & Order Trends
* Revenue by Category
* Revenue by Area
* Orders by Delivery Status

---

### 2️⃣ Customer & Marketing Insights

Insights:

* Repeat vs One-time Customers
* Repeat Rate %
* Avg Orders per Customer
* Orders & Revenue by Payment Method
* Revenue by Sentiment
* Delivery Status vs Sentiment
* Customers by Area

---

### 3️⃣ Products & Category Insights

Insights:

* Total Products, Brands, Categories
* Top Revenue Generating Categories
* Fast Moving Products (by Quantity)
* Star Products (by Revenue)
* Brand Dominance per Category
* Highest Selling Products
* High Value Categories (AOV)

---



## 📐 Key KPIs Created using DAX

* Total Revenue
* Total Orders
* Total Quantity
* Average Order Value
* Delay %
* Repeat Rate %
* Revenue per Product
* Total Profit (using Unit Price & Cost Price)

---

## 📁 Project Flow

```text
Excel/CSV Files
      ↓
SQL Bronze Tables
      ↓
SQL Silver Tables (Cleaned)
      ↓
SQL Gold Tables (Fact & Dimensions)
      ↓
Advanced SQL Analysis
      ↓
Power BI (DAX + Dashboards)
```

---


## 📸 Dashboard Screenshots
https://github.com/Mounika-annareddy14/Powerbi/blob/main/Sales-insights.png   --**Sales overview**


https://github.com/Mounika-annareddy14/Powerbi/blob/main/customer-marketing%20Insights.png   --**customers-marketing**


https://github.com/Mounika-annareddy14/Powerbi/blob/main/products-insights.png   --**products-insights**

---

## 👩‍💻 Author

**Mounika (Data Analyst | Data Science )**

> Further advanced analysis will be added in the next phase of the project.
