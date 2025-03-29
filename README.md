# Dataspark
Overview

Overview

This Power BI dashboard provides insights into customer demographics, sales performance, product trends, and store analysis. The data is sourced from a MySQL database and transformed for analysis.

Key Analysis Areas

1. Customer Analysis

Demographic Distribution: Age, gender, location-based analysis.

Purchase Patterns: Average order value, purchase frequency, preferred products.

Customer Segmentation: Clustering based on demographics and buying behavior.

2. Sales Analysis

Overall Sales Trends: Sales performance over time, identifying trends and seasonality.

Sales by Product: Top-performing products by quantity and revenue.

Sales by Store: Performance comparison of different stores.

Sales by Currency: Impact of different currencies on total sales.

3. Product Analysis

Product Popularity: Most and least popular products.

Profitability Analysis: Profit margins based on cost and price.

Category Analysis: Performance across product categories and subcategories.

4. Store Analysis

Store Performance: Sales, store size, and operational efficiency.

Geographical Analysis: Regional performance insights.

Key DAX Measures

Average Age: Average Age = AVERAGEX('Customer_Details', DATEDIFF('Customer_Details'[Birthday], TODAY(), YEAR))

Total Sales: Total Sales = SUM('Sales'[Revenue])

Average Order Value: AOV = DIVIDE([Total Sales], DISTINCTCOUNT('Sales'[Order ID]))

Sales by Product: Sales by Product = SUM('Sales'[Revenue])

Profit Margin: Profit Margin = DIVIDE(SUM('Sales'[Revenue] - 'Sales'[Cost]), SUM('Sales'[Revenue]))

Visualizations

Demographic Distribution: Pie charts and bar charts (using age, gender, location).

Sales Performance: Line chart for trends, column chart for comparisons.

Product Analysis: Bar charts for top-selling products and profit margins.

Store Analysis: Map visualization for geographical performance.

Data Source

Database: MySQL

Tables Used: Customer_Details, Sales, Products, Stores, Currency_Exchange

Usage Instructions

Load the MySQL database tables into Power BI.

Perform necessary transformations in Power Query.

Use the provided DAX measures to create visualizations.

Customize reports and filters for deeper insights.

Deliverables

Power BI report file (.pbix)

DAX measures for key calculations

Documentation for data model and transformations

Dashboard with interactive visuals

For any issues, refer to Power BI logs or check data model relationships.

