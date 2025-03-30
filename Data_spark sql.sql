USE DATASPARK;

-- Select all columns from each table
SELECT * FROM customer_details;
SELECT * FROM exchange_details;
SELECT * FROM product_details;
SELECT * FROM sales_details;
SELECT * FROM stores_details;

-- Describe tables
DESCRIBE customer_details;
DESCRIBE exchange_details;
DESCRIBE product_details;
DESCRIBE sales_details;
DESCRIBE stores_details;

-- Update and convert date columns to DATE type
-- For customer_details: Convert Birthday to DATE format and modify the column
UPDATE customer_details SET Birthday = STR_TO_DATE(Birthday, '%Y-%m-%d');
ALTER TABLE customer_details MODIFY COLUMN Birthday DATE;

-- For sales_details: Convert Order_Date to DATE format and modify the column
UPDATE sales_details SET Order_Date = STR_TO_DATE(Order_Date, '%Y-%m-%d');
ALTER TABLE sales_details MODIFY COLUMN Order_Date DATE;

-- For stores_details: Convert Open_Date to DATE format and modify the column
UPDATE stores_details SET Open_Date = STR_TO_DATE(Open_Date, '%Y-%m-%d');
ALTER TABLE stores_details MODIFY COLUMN Open_Date DATE;

-- Timeout settings
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;
SET GLOBAL max_allowed_packet = 67108864;

-- For exchange_details: Convert Date to DATE format and modify the column
UPDATE exchange_details SET Date = STR_TO_DATE(Date, '%Y-%m-%d');
ALTER TABLE exchange_details MODIFY COLUMN Date DATE;

-- Queries to get insights from the tables
-- 1. Demographic Distribution: Customers by Gender and Continent
SELECT Gender, Continent, COUNT(CustomerKey) AS CustomerCount 
FROM customer_details 
GROUP BY Gender, Continent 
ORDER BY CustomerCount DESC;

-- 2. Demographic Distribution: Age Group Distribution by Country
SELECT Country, 
    CASE 
        WHEN YEAR(CURDATE()) - YEAR(Birthday) < 25 THEN 'Under 25'
        WHEN YEAR(CURDATE()) - YEAR(Birthday) BETWEEN 25 AND 35 THEN '25-35'
        WHEN YEAR(CURDATE()) - YEAR(Birthday) BETWEEN 36 AND 50 THEN '36-50'
        ELSE 'Above 50'
    END AS AgeGroup,    
    COUNT(CustomerKey) AS CustomerCount
FROM customer_details WHERE Birthday IS NOT NULL GROUP BY Country, AgeGroup 
ORDER BY CustomerCount DESC;

-- 3. Customer Distribution by City and Country (Top 5)
SELECT     City,     Country,    COUNT(CustomerKey) AS CustomerCount
FROM customer_details GROUP BY City, Country ORDER BY CustomerCount DESC LIMIT 10;

-- 4. Segmentation: Top  Product Categories Preferred by Female Customers
SELECT 
    p.Subcategory, 
    SUM(s.Quantity) AS TotalPurchased
FROM sales_details s
JOIN customer_details c ON s.CustomerKey = c.CustomerKey
JOIN product_details p ON s.ProductKey = p.ProductKey
WHERE c.Gender = 'Female'
GROUP BY p.Subcategory
ORDER BY TotalPurchased DESC
LIMIT 5;

-- 5. Segmentation: Top  Product Categories Preferred by Female Customers
SELECT 
    p.Subcategory, 
    SUM(s.Quantity) AS TotalPurchased
FROM sales_details s
JOIN customer_details c ON s.CustomerKey = c.CustomerKey
JOIN product_details p ON s.ProductKey = p.ProductKey
WHERE c.Gender = 'Male'
GROUP BY p.Subcategory
ORDER BY TotalPurchased DESC
LIMIT 5;

-- 6. Overall Sales Performance Over Time (Monthly)
SELECT DATE_FORMAT(s.Order_Date, '%Y-%m') AS Month, 
SUM(s.Quantity * p.Unit_Price_USD) AS Total_Sales
FROM sales_details s
JOIN product_details p ON s.ProductKey = p.ProductKey 
GROUP BY Month ORDER BY Month;

-- 7. Top Performing Products by Quantity Sold
SELECT  p.`Product_Name`,  SUM(s.Quantity) AS Total_Quantity_Sold,SUM(s.Quantity * p.`Unit_Price_USD`) AS Total_Revenue
FROM sales_details s JOIN product_details p ON s.ProductKey = p.ProductKey 
GROUP BY p.`Product_Name` 
ORDER BY Total_Quantity_Sold DESC;

-- 8. Geographical Analysis: Sales by City (using customer's City)
SELECT    c.City,  SUM(s.Quantity * p.`Unit_Price_USD`) AS Total_Sales
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
JOIN customer_details c ON s.CustomerKey = c.CustomerKey
GROUP BY c.City 
ORDER BY Total_Sales DESC;


-- 9. Profitability Analysis by Product
SELECT  p.`Product_Name`, 
		(SUM(s.Quantity * p.`Unit_Price_USD`) - SUM(s.Quantity * p.`Unit_Cost_USD`)) AS Profit_Margin
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
GROUP BY p.`Product_Name` 
HAVING Profit_Margin > 0 
ORDER BY Profit_Margin DESC;

-- 10. Online Store Performance (for a specific store key, e.g., 0)
SELECT     'Square Metres' AS Store,    
			SUM(s.Quantity * p.`Unit_Price_USD`) AS Total_Sales, 
            COUNT(DISTINCT s.Order_Number) AS Total_Orders
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
WHERE s.StoreKey = 0;

-- 11. Overall Female Count from customer_details
SELECT COUNT(Gender) AS Female_Count 
FROM customer_details 
WHERE Gender = 'Female';

-- 12. Overall Male Count from customer_details
SELECT COUNT(Gender) AS Male_Count 
FROM customer_details 
WHERE Gender = 'Male';

-- 13. Store-wise Sales: Total Sales per Store
SELECT     s.StoreKey,    st.Country,   
		    SUM(p.`Unit_Price_USD` * s.Quantity) AS Total_Sales_Amount 
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
JOIN stores_details st ON s.StoreKey = st.StoreKey 
GROUP BY s.StoreKey, st.Country;

-- 14. Brand-wise Selling Amount
SELECT p.Brand,     
	   ROUND(SUM(p.`Unit_Price_USD` * s.Quantity), 2) AS Sales_Amount
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
GROUP BY p.Brand;

-- 15. Year-wise Brand Sales
SELECT YEAR(s.Order_Date) AS Order_Year,   
			p.Brand, 
			ROUND(SUM(p.`Unit_Price_USD` * s.Quantity), 2) AS Year_Sales
FROM sales_details s 
JOIN product_details p ON s.ProductKey = p.ProductKey 
GROUP BY YEAR(s.Order_Date), p.Brand;