-- ============================================
-- COFFEE SHOP SALES ANALYSIS
-- SQL Server
-- ============================================

-- Dataset: Maven Analytics Coffee Shop Sales
-- Analysis period: January 2023 - June 2023

-- ============================================
-- 0. DATA QUALITY CHECKS
-- ============================================

-- Total Number of Rows
SELECT
    COUNT(*) AS Total_Rows
FROM [Coffee Shop Sales. CSV]


-- Unique Transaction IDs
SELECT
    COUNT(DISTINCT transaction_id) AS Unique_Transaction_IDs
FROM [Coffee Shop Sales. CSV]


-- Check for Missing Values
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(transaction_id) AS Transaction_IDs_Filled,
    COUNT(transaction_date) AS Dates_Filled,
    COUNT(transaction_time) AS Times_Filled,
    COUNT(transaction_qty) AS Quantities_Filled,
    COUNT(store_id) AS Store_IDs_Filled,
    COUNT(store_location) AS Locations_Filled,
    COUNT(product_id) AS Product_IDs_Filled,
    COUNT(unit_price) AS Prices_Filled,
    COUNT(product_category) AS Categories_Filled,
    COUNT(product_type) AS Types_Filled,
    COUNT(product_detail) AS Details_Filled
FROM [Coffee Shop Sales. CSV];


-- Check Price Range
SELECT
    MIN(unit_price) AS Minimum_Price,
    MAX(unit_price) AS Maximum_Price,
    AVG(unit_price) AS Average_Price
FROM [Coffee Shop Sales. CSV]


-- Check Quantity Range
SELECT
    MIN(transaction_qty) AS Minimum_Quantity,
    MAX(transaction_qty) AS Maximum_Quantity,
    AVG(transaction_qty) AS Average_Quantity
FROM [Coffee Shop Sales. CSV]

-- ============================================
-- 1. KEY PERFORMANCE INDICATORS
-- ============================================

-- Total Revenue
SELECT SUM(unit_price * transaction_qty) AS Total_Revenue
FROM [Coffee Shop Sales. CSV];

-- Average Transaction Value
SELECT 
	AVG(Transaction_Total) AS Average_Transaction_Value
FROM	
	(SELECT 
	transaction_id,
	SUM(unit_price * transaction_qty) AS Transaction_Total
FROM [Coffee Shop Sales. CSV]
GROUP BY transaction_id) AS Transactions;

-- ============================================
-- 2. TIME ANALYSIS
-- ============================================

-- First and Last Transaction Date
SELECT
    MIN(transaction_date) AS First_Date,
    MAX(transaction_date) AS Last_Date
FROM [Coffee Shop Sales. CSV];

-- Revenue by Month
SELECT
	MONTH(transaction_date) AS Sales_Month,
	SUM(transaction_qty * unit_price) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY MONTH(transaction_date)
ORDER BY Sales_Month;

-- Revenue by Day of Week
SELECT
    DATENAME(WEEKDAY, transaction_date) AS day_name,
    SUM(unit_price * transaction_qty) AS total_revenue
FROM [Coffee Shop Sales. CSV]
GROUP BY DATENAME(WEEKDAY, transaction_date);

-- Revenue by Hour
SELECT
    DATEPART(HOUR, transaction_time) AS sales_hour,
    ROUND(SUM(unit_price * transaction_qty),2) AS total_revenue
FROM [Coffee Shop Sales. CSV]
GROUP BY DATEPART(HOUR, transaction_time)
ORDER BY sales_hour

-- Number of Transactions by Hour
SELECT
    DATEPART(HOUR, transaction_time) AS Sales_Hour,
    COUNT(DISTINCT transaction_id) AS Total_Transactions
FROM [Coffee Shop Sales. CSV]
GROUP BY DATEPART(HOUR, transaction_time)
ORDER BY Sales_Hour;

-- ============================================
-- 3. PRODUCT ANALYSIS
-- ============================================

-- Product Quantity Sold
SELECT 
	product_detail,
	SUM(transaction_qty) AS Total_Quantity
FROM [Coffee Shop Sales. CSV]
GROUP BY product_detail
ORDER BY Total_Quantity DESC

-- Product Revenue
SELECT 
	product_detail,
	ROUND(SUM(unit_price * transaction_qty),2) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY product_detail
ORDER BY TotalRevenue DESC

-- Top 10 Products by Revenue
SELECT TOP 10
    product_detail,
    ROUND(SUM(unit_price * transaction_qty), 2) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY product_detail
ORDER BY TotalRevenue DESC;

-- ============================================
-- 4. CATEGORY ANALYSIS
-- ============================================

-- Quantity Sold by Category
SELECT
    product_category,
    SUM(transaction_qty) AS Total_Quantity
FROM [Coffee Shop Sales. CSV]
GROUP BY product_category
ORDER BY Total_Quantity DESC;

-- Revenue by Category
SELECT 
	product_category,
	ROUND(SUM(unit_price * transaction_qty),2) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY product_category
ORDER BY TotalRevenue DESC

-- ============================================
-- 5. STORE ANALYSIS
-- ============================================

-- Revenue by Store Location
SELECT 
	store_location,
	ROUND(SUM(unit_price * transaction_qty),2) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY store_location
ORDER BY TotalRevenue DESC

-- Revenue by Product Category and Store Location
SELECT 
	product_category,
	store_location,
	ROUND(SUM(unit_price * transaction_qty),0) AS TotalRevenue
FROM [Coffee Shop Sales. CSV]
GROUP BY product_category, store_location
ORDER BY TotalRevenue DESC

-- ============================================
-- 6. AVERAGE TRANSACTION VALUE BY MONTH
-- ============================================

-- Average Transaction Value by Month
SELECT
    Transaction_Month,
    ROUND(AVG(Transaction_Total), 2) AS Average_Transaction_Value
FROM
    (SELECT
        transaction_id,
        MONTH(transaction_date) AS Transaction_Month,
        SUM(unit_price * transaction_qty) AS Transaction_Total
    FROM [Coffee Shop Sales. CSV]
    GROUP BY transaction_id, MONTH(transaction_date)) AS Transactions
GROUP BY Transaction_Month
ORDER BY Transaction_Month;



