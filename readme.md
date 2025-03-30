Overview
This project analyzes customer demographics, purchase patterns, sales performance, product profitability, and store performance. Data is sourced from a MySQL database (database: Dataspark) containing five tables:

dataspark customer_details (CustomerKey, Gender, Name, City, State, Country, Continent, Birthday)

dataspark exchange_details (Date, Currency_Code, Exchange)

dataspark product_details (ProductKey, Product_Name, Brand, Color, Unit_Cost_USD, Unit_Price_USD, Subcategory, CategoryKey, Category)

dataspark sales_details (Order_Number, Line_Item, Order_Date, Delivery_Date, CustomerKey, StoreKey, ProductKey, Quantity, Currency_Code)

dataspark stores_details (StoreKey, Country, State, Square_Meters, Open_Date)

Data Preparation & Modeling
SQL Queries: Data was cleaned and transformed in MySQL (e.g., date conversion) and then loaded into Power BI.

Relationships: Key relationships are established between:

customer_details and sales_details (via CustomerKey)

sales_details and product_details (via ProductKey)

sales_details and stores_details (via StoreKey)

Indexes: Recommended indexes were added on join/filter columns to improve query performance.

Key Analyses & DAX Measures
Customer Analysis:

Total Customers: DISTINCTCOUNT('dataspark customer_details'[CustomerKey])

Average Age: AVERAGEX('dataspark customer_details', DATEDIFF('dataspark customer_details'[Birthday], TODAY(), "YEAR"))

Age Group (Calculated Column): Classifies customers into "Under 25", "25-35", "36-50", and "Above 50".
Visualizations & Reporting
Customer Visuals: Pie or bar charts for gender, age, and location distributions.

Sales Visuals: Line charts for monthly trends, bar charts for product and store comparisons.

Product Visuals: Bar charts or treemaps for top products; column charts for profit margins.

Store Visuals: Map visuals for geographic performance; bar charts for store profitability.

Interactivity: Slicers and filters to allow drilling down by date, region, product category, etc.

Deliverables
Power BI Report File (.pbix): Contains interactive dashboards and all visuals.

SQL Scripts & Queries: Used for data extraction, cleaning, and pre-aggregation.

DAX Measures & Calculated Columns: For key metrics (Total Sales, Profit Margin, etc.).

Documentation (this README): Explains the data model, key analyses, and how to use the dashboard.

Presentation Slides: (Optional) A summary of findings and actionable insights.

