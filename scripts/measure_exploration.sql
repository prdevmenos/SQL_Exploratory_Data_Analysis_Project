-- Find How many items are sold
SELECT SUM(quantity) AS Total_Quantity FROM gold.fact_sales

-- Find Average Selling Price
SELECT AVG(price) AS Avg_Price From gold.fact_sales

-- Find the Total Number of Orders
SELECT COUNT(order_number) AS Total_Orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS Total_Unique_Orders FROM gold.fact_sales

-- Find the Total Number of Products
SELECT COUNT(product_name) AS Total_Customers FROM gold.dim_products

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales


-- Generate Report that shows all key metrics of the business.

SELECT 'Total_Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total_Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average_price', AVG(price) From gold.fact_sales
UNION ALL
SELECT 'Total_Number_Orders', COUNT(DISTINCT order_number)  FROM gold.fact_sales
UNION ALL
SELECT 'Total_Number_Products', COUNT(product_name)  FROM gold.dim_products
UNION ALL
SELECT 'Total_Number_Customers', COUNT(DISTINCT customer_key) FROM gold.fact_sales
