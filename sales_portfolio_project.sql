-- Table to store transactional sales data for analysis 

CREATE TABLE sales_data (
    Product_ID INT,  
    Sale_Date DATE,  
    Sales_Rep VARCHAR(25),  
    Region VARCHAR(10),  
    Sales_Amount NUMERIC(10, 2),  
    Quantity_Sold INT,  
    Product_Category VARCHAR(50),  
    Unit_Cost NUMERIC(10, 2),  
    Unit_Price NUMERIC(10, 2),  
    Customer_Type VARCHAR(20),  
    Discount NUMERIC(4, 2),  
    Payment_Method VARCHAR(30),  
    Sales_Channel VARCHAR(20),  
    Region_and_Sales_Rep VARCHAR(50)  
)

-- Selecting the data 

SELECT * FROM sales_data

-- 1. Which regions are generating the highest sales month over month?

SELECT EXTRACT(Month FROM sale_date) AS month, region, SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY region, month
ORDER BY month,total_sales DESC

-- 2. Who are the top 3 sales rep by total revenue?

SELECT sales_rep, SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY sales_rep
ORDER BY total_sales DESC
LIMIT 3

-- 3. Which product categories contribute the most to overall profit?

SELECT 
	product_category, 
	SUM((unit_price - unit_cost) * quantity_sold) AS total_profit
FROM sales_data
GROUP BY product_category
ORDER BY total_profit DESC

-- 4. Are new or returning customers generating more revenue on average?

SELECT customer_type, ROUND(AVG(sales_amount),2) AS avg_sales
FROM sales_data
GROUP BY customer_type
ORDER BY avg_sales DESC

-- 5. Is there a correlation between higher discounts and higher sales volume?

SELECT 
	ROUND(discount * 100,0) AS discount_percentage,
	SUM(quantity_sold) AS total_quantity_sold
FROM sales_data
GROUP BY discount_percentage
ORDER BY discount_percentage DESC

-- 6. Do online or retail channels perform better accross product categories?

SELECT sales_channel, product_category, SUM(sales_amount) AS sales_amount
FROM sales_data
GROUP BY sales_channel, product_category
ORDER BY sales_channel, product_category


-- 7. Which payment methods are most popular and generate most sales by region?

SELECT region, payment_method, COUNT(*) AS transaction_count, SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY region, payment_method
ORDER BY region, total_sales DESC

-- 8. Are there certain months where sales spike across categories?

SELECT EXTRACT(Month FROM sale_date) AS month, product_category, SUM(sales_amount)
FROM sales_data
GROUP BY month, product_category
ORDER BY product_category, month
