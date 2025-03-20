-- ==========================================================
-- 📌 SQL Interview Mastery - 40 Solved Questions  
-- 🎯 Solved by: Sudais Shah  
-- 📅 Date: Nov, 2024
-- 🔗 GitHub Repository: https://github.com/Sudais-shah/SQL-Interview-Challenge-40-Questions-Solved-By-Sudais-Shah
-- 🔗 Linkedin Profile Link: www.linkedin.com/in/sudais-shah-938b9a312
-- ==========================================================

-- Interview-Style Questions
-- Beginner Level
-- Q1 - Retrive all customers who were registered at year 2021
SELECT * 
FROM customers 
WHERE Extract(year from registration_date) = '2021'

--Q2 - Retrieve the names of customers who placed orders worth more than $500.
SELECT c.customer_name , o.total_amount  from customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > 500


-- Q3 - List all products with a price higher than $200.
SELECT * FROM products
WHERE price > 200


--Q4 - Display the total number of orders placed by each customer.
SELECT customer_id , COUNT(*)
FROM orders
GROUP BY customer_id
ORDER BY customer_id ASC

--                               Intermediate Level

--Q5 - Find the top-selling product (by quantity) across all orders.
SELECT product_name , SUM(stock_quantity)
FROM products 
GROUP BY product_name
ORDER BY SUM(stock_quantity) DESC 
LIMIT 1

--Q6 - Calculate the total revenue generated for each product category.
SELECT p.category , sum(od.quantity * price)
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
group by p.category
ORDER BY p.category ASC

--Q7 - Retrieve all orders that were placed but never paid for.
SELECT o.order_id, o.customer_id, o.order_date, o.total_amount
FROM Orders o
LEFT JOIN Payments p
ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

-- USING NOT IN 
SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE order_id NOT IN (SELECT order_id FROM Payments);

--- USING NOT EXISTS
SELECT o.order_id, o.customer_id, o.order_date, o.total_amount
FROM Orders o
WHERE NOT EXISTS (
    SELECT p.payment_id
    FROM Payments p
    WHERE o.order_id = p.order_id
);

--Q7 - Find customers who placed more than 3 orders.
SELECT customer_name, COUNT(o.customer_id) AS order_count
FROM customers
LEFT JOIN orders o ON customers.customer_id = o.customer_id
GROUP BY customer_name
HAVING COUNT(o.customer_id) > 3


-- Advanced Level
--Q8 - Find the average order amount for each customer.
SELECT c.customer_name , sum(o.total_amount) / count(o.customer_id) -- or you can use count(o.order_id) as well
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name

--Q9 - Find the top three customers with the highest total order amounts along with their total order value.
WITH customer_totals AS (
SELECT c.customer_id , c.customer_name , SUM(o.total_amount) AS total_order_value
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id , c.customer_name 
)
SELECT customer_id , customer_name , total_order_value , rank 
FROM (
SELECT customer_id , customer_name , total_order_value ,
       RANK() OVER (ORDER BY total_order_value DESC) AS rank 
FROM customer_totals) ranked_customers 
WHERE rank <= 3;


SELECT * FROM customers;
SELECT * FROM orders;

--Q10 - Identify orders where the total amount is greater than the average order amount for the respective customer.
WITH avg_amount AS(
SELECT c.customer_id , ROUND(SUM(o.total_amount) / COUNT(o.customer_id),2) AS avg_amount 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
)
SELECT o.customer_id , o.order_id ,o.total_amount AS total_amount , ROUND(aa.avg_amount,2) AS avg_amount
FROM orders o 
JOIN avg_amount aa ON o.customer_id = aa.customer_id 
WHERE o.total_amount > aa.avg_amount

------------Method 1 : Using CTE 
WITH avg_amount AS (
     SELECT c.customer_id, SUM(o.total_amount) / COUNT(o.customer_id) AS avg_amount 
      FROM customers c 
      JOIN orders o ON c.customer_id = o.customer_id
      GROUP BY c.customer_id
)
SELECT o.customer_id , o.order_id ,o.total_amount , aa.avg_amount
FROM orders o
JOIN avg_amount aa ON o.customer_id = aa.customer_id 
WHERE o.total_amount > aa.avg_amount

------------Method 2 : Using a Subquery in the FROM Clause

SELECT o.customer_id, o.order_id, o.total_amount, avg_orders.avg_amount
FROM orders o
JOIN (
    SELECT customer_id, SUM(total_amount) / COUNT(order_id) AS avg_amount
    FROM orders
    GROUP BY customer_id
) avg_orders ON o.customer_id = avg_orders.customer_id
WHERE o.total_amount > avg_orders.avg_amount;

---- Method 3 : Using a Subquery in the WHERE Clause
SELECT o.customer_id, o.order_id, o.total_amount 
FROM orders o
WHERE o.total_amount > (
    SELECT SUM(o2.total_amount) / COUNT(o2.order_id)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
    GROUP BY o2.customer_id
);

--Q11 - Calculate the time difference between the first and last order for each customer.

SELECT customer_id ,  MIN(order_date) AS first_orders , MAX(order_date)  AS last_order ,
       max(order_date) - min(order_date) as time_difference
FROM orders
GROUP BY customer_id 

----- Method 2 : Using AGE Funcation
SELECT 
    customer_id, 
    AGE(MAX(order_date), MIN(order_date)) AS time_difference
FROM orders
GROUP BY customer_id;

--Q12 - Retrieve customers who haven’t placed an order in the past 90 days.
SELECT DISTINCT customer_id , order_date   FROM orders 
WHERE order_date < CURRENT_DATE - INTERVAL '90 DAYS'
ORDER BY customer_id ASC

EXPLAIN ANALYZE SELECT order_date FROM orders

-- Expert Level

--Q13 - List customers who have never placed an order.
SELECT c.customer_id FROM customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id 
WHERE o.customer_id is null

--Q14 - Find the product that contributed the most to the revenue.
SELECT p.product_id , p.product_name , SUM(od.quantity) AS total_quantity_ordered , p.price , 
       SUM(p.price * od.quantity) AS total_revenue
FROM products p 	   
JOIN orderdetails od ON p.product_id = od.product_id 
GROUP BY p.product_id , product_name , p.price 
ORDER BY SUM(p.price * od.quantity) DESC 
LIMIT 1

SELECT * FROM products ;
SELECT * FROM orderdetails ;

-- Q15 - Identify customers whose total spending is in the top 10%.
WITH RankedCustomers AS (
    SELECT customer_id, 
           SUM(o.total_amount) AS total_spending
    FROM orders o
    GROUP BY customer_id
)
SELECT customer_id, total_spending
FROM RankedCustomers
WHERE total_spending > (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_spending)
    FROM RankedCustomers
);  

 ------------- With Rank 
WITH RankedCustomers AS (
    SELECT customer_id, 
      SUM(o.total_amount) AS total_spending,
      RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rank
    FROM orders o
    GROUP BY customer_id
)
SELECT customer_id, total_spending
FROM RankedCustomers
WHERE rank <= 10;  

--Q16 - Use window functions to calculate the running total of sales for each product.

SELECT p.product_name , p.product_id ,  od.quantity * p.price as total ,
  SUM(od.quantity * p.price) OVER (PARTITION BY od.product_id ORDER BY od.order_id) as running_total
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id 

 
--Q17 - Determine the percentage contribution of each payment method to the total revenue.
SELECT 
    payment_method,
    SUM(payment_amount) AS total_amount,  -- **************** SUM(SUM(payment_amount)) OVER () ****** 
    SUM(payment_amount) * 100.0 / SUM(SUM(payment_amount)) OVER () AS percentage_contribution
FROM payments
GROUP BY payment_method;

------ Using Cte

WITH TotalRevenue AS (
    SELECT SUM(payment_amount) AS total_revenue
    FROM payments
)
SELECT 
    p.payment_method,
    SUM(p.payment_amount) AS total_amount,
    SUM(p.payment_amount) * 100.0 / tr.total_revenue AS percentage_contribution
FROM payments p
CROSS JOIN TotalRevenue tr     --//INNER JOIN TotalRevenue tr ON true
GROUP BY p.payment_method, tr.total_revenue;

-----------//// Companies Asked Questions /// ---------------------

-- Beginner Level Questions

--Q18 - Retrieve all customers who have made at least one order in the last 30 days.
SELECT 
      c.customer_id , c.customer_name ,o.order_id , o.order_date 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
WHERE order_date >= CURRENT_DATE - INTERVAL '30 DAYS'

--Q19 - Find the total revenue generated for each product category.
SELECT 
       p.category , SUM(od.quantity * p.price)  AS revenue_genrated 
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id 
GROUP BY category    

--Q20 - Count the number of orders for each customer and sort by the highest order count.
SELECT 
       customer_id , 
	   COUNT(order_id) AS order_count
FROM orders 
GROUP BY customer_id 
ORDER BY COUNT(order_id) DESC

--Q21 - Find the 3 most expensive products.
SELECT 
      product_id ,
	  product_name ,
	  price
FROM products 
ORDER BY price DESC
LIMIT 3

-- Q22 - Retrieve the latest 3 orders for each customer.
WITH latest_order_rank AS(
SELECT
      customer_id , 
      order_date ,
      order_id  , 
	  ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS latest_orders
FROM orders 
)
SELECT
      customer_id ,
	  order_date ,
	  order_id  , 
	  latest_orders
FROM latest_order_rank
WHERE latest_orders IN(1,2,3)
ORDER BY customer_id ASC ,order_date DESC

--        WITH subquery 
SELECT
      customer_id , 
	  order_date , 
	  order_id  , 
	  latest_orders
FROM 
     (SELECT 
	 customer_id , 
	 order_date , 
	 order_id  , 
	  ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS latest_orders
	  FROM orders
	  ) latest_order_rank
WHERE latest_orders IN(1,2,3)
ORDER BY customer_id ASC ,order_date DESC

--Q23 - List all customers who have placed orders, along with their total spending.
SELECT 
       customer_id ,
	   sum(total_amount)
FROM orders 
GROUP BY customer_id 
ORDER BY customer_id 

--Q24 - Retrieve a list of all orders, including the products purchased and their quantities.
SELECT 
       od.order_id , 
	   od.product_id,
	   p.product_name ,
	   od.quantity 
FROM orderdetails od
JOIN products p ON od.product_id = p.product_id
ORDER BY od.product_id ASC

-- Intermediate Level Questions
--Q25 - Retrieve the names of customers who have spent more than $1,000 in total.
SELECT
      customer_id , 
	  SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000
ORDER BY total_spent DESC

--Q26 - Retrieve the details of the customer who has placed the highest number of orders.
SELECT 
       customer_id , 
       count(customer_id) AS order_count
FROM orders 
GROUP BY customer_id 
ORDER BY count(customer_id) DESC
LIMIT 1 

--- USING CTE 
WITH CustomerOrderCounts AS (
    SELECT customer_id, COUNT(customer_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, order_count
FROM CustomerOrderCounts
WHERE order_count = (SELECT MAX(order_count) FROM CustomerOrderCounts)

-- WITHOUT USING LIMIT
SELECT 
      customer_id,
      COUNT(customer_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(customer_id) = (
    SELECT 
      MAX(order_count)
      FROM (
       SELECT customer_id, 
	     COUNT(customer_id) AS order_count
         FROM orders
         GROUP BY customer_id)  max_order_count
)

--Q27 - Find products that have never been ordered.
SELECT 
       product_id , 
       product_name 
FROM products
WHERE product_id NOT IN(SELECT product_id FROM orders)

--- Using JOIN
SELECT p.product_id , p.product_name 
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL

--Q28 -  Calculate the average time difference between orders for each customer.
WITH time_diff AS (
SELECT customer_id , order_date , 
       order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC)AS time_diff 
FROM orders	   )
SELECT customer_id , order_date , ROUND(COALESCE(AVG(time_diff),0),0) AS avg_time_diff
FROM time_diff
GROUP BY customer_id , order_date

--Q29 - Identify customers who haven’t placed an order in the past 6 months.

SELECT 
      DISTINCT customer_id 
FROM orders 
WHERE customer_id NOT IN (
SELECT 
       DISTINCT customer_id 
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '6 MONTHS'
)

--Q30 - WE CAN USING GROUP BY INSTEAD OF DISTINCT

SELECT customer_id
FROM orders
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE order_date >= CURRENT_DATE - INTERVAL '6 MONTHS'
)
GROUP BY customer_id;

--Q31 -  List customers who have placed orders for every product category.

SELECT DISTINCT o.customer_id
FROM orders o
JOIN orderdetails od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE NOT EXISTS (
    SELECT DISTINCT category
    FROM products
    WHERE category NOT IN (
        SELECT DISTINCT p2.category
        FROM orders o2
        JOIN orderdetails od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.customer_id = o.customer_id
    )
);

-- OR WE CAN FOLLOW MORE STRUCTURED WAY 

-- Step 1: Count the total number of categories
WITH TotalCategories AS (
    SELECT COUNT(DISTINCT category) AS category_count
    FROM products
),

-- Step 2: Count the number of distinct categories each customer has ordered from
CustomerCategoryCount AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT p.category) AS category_count
    FROM orders o
    JOIN orderdetails od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.customer_id
)

-- Step 3: Compare the counts to identify eligible customers
SELECT c.customer_id
FROM CustomerCategoryCount c
JOIN TotalCategories t ON c.category_count = t.category_count;



--Q32 - Find customers who have placed at least one order for each month in 2023.
SELECT customer_id
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2022
GROUP BY customer_id
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM order_date)) = 12

-- Advanced Level Questions
--Q33 - Rank the products by revenue contribution for each product category.

with total_quantity as (
SELECT 
       p.category , od.product_id , SUM(od.quantity) as quantity 
FROM products p 
JOIN orderdetails od ON p.product_id = od.product_id 
GROUP BY p.category , od.product_id
)
SELECT 
       tq.category , tq.product_id ,p.price * tq.quantity as revenue ,
RANK() OVER (PARTITION BY tq.category ORDER BY p.price * tq.quantity DESC)
FROM products p 
JOIN total_quantity tq ON  p.category = tq.category  and p.product_id = tq.product_id 
ORDER BY category ASC


-- WITHOUT CTE 

SELECT 
    p.category, 
    p.product_id, 
    SUM(od.quantity) * p.price AS revenue,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(od.quantity) * p.price DESC) AS rank
FROM 
    products p
JOIN 
    orderdetails od ON p.product_id = od.product_id
GROUP BY 
    p.category, p.product_id, p.price
ORDER BY revenue DESC 

--Q34 - Calculate the running total of revenue for each customer over time.
SELECT 
       customer_id ,
       order_date ,  
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
FROM orders 
ORDER BY customer_id ASC

--Q35 - Determine the percentage of total revenue contributed by each order.
SELECT order_id  , total_amount , 
        ROUND((total_amount * 100.0 / SUM(total_amount) OVER()),2) AS revenue_percentage
FROM orders 
ORDER BY revenue_percentage DESC

SELECT * FROM orders

--Q36 - Retrieve the top 3 products by sales for each product category.

SELECT * FROM products;
SELECT * FROM orderdetails;

WITH top_products AS (
    SELECT 
          p.category , p.product_id , sum(od.quantity) as total_quantity ,
          ROW_NUMBER() OVER (PARTITION BY category ORDER BY sum(od.quantity) DESC) as product_rank
          FROM products p
          JOIN orderdetails od ON p.product_id = od.product_id 
          GROUP BY p.category , p.product_id 
)
SELECT
       category , 
       product_id ,
	   total_quantity,
	   product_rank
FROM top_products 
WHERE product_rank IN(1,2,3)

--Q37 - Find customers whose total spending is within the top 10%.
WITH CustomerSpending AS (
    SELECT 
        o.customer_id, 
        SUM(o.total_amount) AS total_spending
    FROM  Orders o
    GROUP BY  o.customer_id
),
SpendingPercentile AS (
    SELECT customer_id, total_spending,
           NTILE(10) OVER (ORDER BY total_spending DESC) AS percentile_rank
           FROM CustomerSpending 
		   )
SELECT 
      customer_id,  total_spending
FROM  SpendingPercentile
WHERE percentile_rank = 1

--- WITH PERCENTITLE_CONT 
WITH CustomerSpending AS (
    SELECT 
        o.customer_id, 
        SUM(o.total_amount) AS total_spending
    FROM Orders o
    GROUP BY o.customer_id
),
PercentileThreshold AS (
    SELECT 
        PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_spending DESC) AS threshold
    FROM CustomerSpending
)
SELECT 
    cs.customer_id, 
    cs.total_spending
FROM CustomerSpending cs
CROSS JOIN PercentileThreshold pt
WHERE cs.total_spending >= pt.threshold
ORDER BY cs.total_spending DESC
LIMIT 1

--Q38 - Write a query to calculate the 90th percentile of order amounts for each customer.
SELECT 
    customer_id,
   PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_amount)  AS percentile_90
FROM 
    orders
GROUP BY 
    customer_id;

----Q39 - Write a query to calculate the 90th percentile of order amounts for each customer.
SELECT 
    customer_id,
   PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_amount)  AS percentile_90
FROM 
    orders
GROUP BY 
    customer_id; Find the second highest total order amount for each customer.
WITH RankedOrders AS (
SELECT 
       customer_id ,
	   total_amount , 
	   RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank
FROM orders	   
)
SELECT 
       customer_id ,
	   total_amount AS second_highest_order
FROM Rankedorders
WHERE rank = 2 ;

--Q40 - Create an index for order_date 
create index idx_order_date on orders(order_date)

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders';	
 












