-- RANKING
-- Order the value of dimension by measure.
-- It helps to identify the top performers as well as bottom performers.

-- Which 5 products generated the highest revenue ?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- USING WINDOW FUNCTION
SELECT
*
FROM (
	SELECT
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p 
	ON p.product_key = f.product_key
	GROUP BY p.product_name) t
WHERE rank_products <= 5

-- Which 5 worst perfroming products in term of sales ?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue

-- USING WINDOW FUNCTION
SELECT
*
FROM (
	SELECT 
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	RANK() OVER(ORDER BY SUM(f.sales_amount)) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p 
	ON p.product_key = f.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5

-- Find Top 10 Customers who have generated the highest revenue ?
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

-- The 3 Customers with the fewest order placed.
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUnt(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders
