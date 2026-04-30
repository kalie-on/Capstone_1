USE sample_sales;

-- 1. Create a list of all transactions that took place on January 15, 2024, sorted by sale amount from highest to lowest.

SELECT *
FROM Store_Sales
WHERE Transaction_Date = '2024-01-15'
ORDER BY Sale_Amount DESC;

-- 2. Which transactions had a sale amount greater than $500? Display the transaction date, store ID, product number, and sale amount.

SELECT Transaction_Date, Store_ID, Prod_Num, Sale_Amount
FROM Store_Sales
WHERE Sale_Amount > 500
ORDER BY Sale_Amount DESC;

-- 3. Find all products whose product number begins with the prefix 105250. What category do the belong to?

SELECT p.ProdNum, ic.Category
FROM products p 
JOIN inventory_categories ic
ON p.Categoryid = ic.Categoryid
WHERE p.ProdNum = 105250;

-- 4. What is the total sales revenue across all transactions? What is the average transaction amount?

SELECT SUM(Sale_Amount) AS TotalSale,
AVG(Sale_Amount) AS average_transaction
FROM store_sales;

-- 5. How many transactions were recorded for each product category? Which category has the most transactions?

SELECT ic.category, COUNT(*) AS Transaction_number
FROM inventory_categories ic
JOIN products p 
ON p.Categoryid = ic.Categoryid
GROUP BY ic.Categoryid
ORDER BY ic.Category DESC;

-- 6. Which store generated the highest total revenue? Which generated the lowest?

SELECT ss.store_id, MAX(ss.sale_amount) AS Highes_revenue,
MIN(ss.sale_amount) AS lowest_revenue
FROM store_sales ss 
JOIN store_locations sl
ON ss.Store_ID = sl.Store_Id
GROUP BY ss.Store_ID;

-- 7. What is the total revenue for each category, sorted from highest to lowest?

SELECT ic.category, 
SUM(ss.sale_amount) AS total_revenue_category
FROM store_sales ss
JOIN products p 
ON p.ProdNum = ss.Prod_Num
JOIN inventory_categories ic
ON p.Categoryid = ic.Categoryid
GROUP BY ic.Category
ORDER BY total_revenue_category DESC;


-- 8. Which stores had total revenue above $50,000? (Hint: you'll need HAVING.) Joins

SELECT ss.store_id, SUM(ss.sale_amount) AS total_revenue
FROM store_sales ss
JOIN store_locations sl
ON ss.Store_ID= sl.Store_ID
GROUP BY ss.Store_ID
HAVING SUM(ss.sale_amount) > 50000;

-- 9. Find all sales records where the category is either "Textbooks" or "Technology & Accessories."

SELECT c.category, c,categoryid
FROM inventory_categories c
JOIN inventory_subategories s	
ON c.Categoryid = s.Categoryid
WHERE Category = "Textbooks" or "Technology & Accessories";


SELECT ss.*
FROM Store_Sales ss
JOIN Products p
ON ss.Prod_Num = p.ProdNum
JOIN Inventory_Categories ic
ON p.Categoryid = ic.Categoryid
WHERE ic.Category IN ('Textbooks', 'Technology & Accessories');

-- 10. List all transactions where the sale amount was between $100 and $200, and the category was "Textbooks."

SELECT ss.*
FROM store_sales ss
JOIN products p 
ON ss.Prod_Num = p.ProdNum
JOIN inventory_categories ic
ON p.Categoryid = ic.Categoryid
WHERE ss.Sale_Amount BETWEEN 100 AND 200
AND ic.Category = 'Textbooks';

-- 11. Write a query that displays each store's total sales along with the city and state where that store is located.   

SELECT ss.Store_ID, SUM(ss.sale_amount) store_total_sales, sl.state, sl.storelocation AS city
FROM store_sales ss
JOIN store_locations sl 
ON ss.Store_ID = sl.Store_Id
GROUP BY ss.Store_ID, sl.StoreLocation, sl.State;

-- 12. For each sale, display the transaction date, sale amount, city, state, and the name of the store manager responsible for that state.

SELECT ss.Transaction_Date, ss.sale_amount, sl.StoreLocation AS City, sl.State, m.SalesManager
FROM store_sales ss 
JOIN store_locations sl
ON ss.store_id = sl.store_id
JOIN management m 
ON sl.state = m.state;

-- 13. Write a query that shows total sales by region. Which region generates the most revenue?

SELECT ss.sale_amount, m.region
FROM store_sales ss 
JOIN management m 
ON ss.id = m.id
GROUP BY m.region
ORDER BY ss.sale_amount DESC;



14. For states that have a preferred shipper listed in Shipper_List, show the total sales alongside the
preferred shipper and volume discount.
15. Are there any states with sales data that do not appear in Shipper_List?
16. Display total revenue by regional director.
Subqueries
17. Using a subquery, find all transactions from stores located in Texas.
18. Which stores had total sales above the average store revenue? (Hint: use a subquery to calculate the
average first.)
19. Find the top 5 highest-grossing stores, then use that result to look up their city and state from
Store_Locations.
20. Write a query using a subquery to find all sales records from stores managed by the Northeast
region's store managers