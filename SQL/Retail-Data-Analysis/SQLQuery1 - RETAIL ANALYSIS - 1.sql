

USE RetailPOS;

-- Question 1: total number of rows in each of the 3 tables


SELECT 'Customer' AS table_name, COUNT(*) AS total_rows FROM Customer
UNION ALL
SELECT 'Transactions', COUNT(*) FROM Transactions
UNION ALL
SELECT 'prod_cat_info', COUNT(*) FROM prod_cat_info;





-- Question 2: total number of transactions that have a return



SELECT COUNT(*) AS return_count
FROM Transactions
WHERE Qty < 0;





-- Question 3: convert date columns to valid date format


SELECT TOP 20
    tran_date AS original_text,
    CONVERT(date, tran_date, 105) AS converted_date
FROM Transactions;



-- Question 4: time range of transaction data in days, months, years



WITH date_range AS (
    SELECT
        MIN(CONVERT(date, tran_date, 105)) AS first_date,
        MAX(CONVERT(date, tran_date, 105)) AS last_date
    FROM Transactions
)
SELECT
    first_date,
    last_date,
    DATEDIFF(day,   first_date, last_date) AS range_days,
    DATEDIFF(month, first_date, last_date) AS range_months,
    DATEDIFF(year,  first_date, last_date) AS range_years
FROM date_range;







-- Question 5: which category does sub-category 'DIY' belong to?


SELECT prod_cat, prod_subcat
FROM prod_cat_info
WHERE prod_subcat = 'DIY';





SELECT Store_type, COUNT(*) AS txn_count
FROM Transactions
GROUP BY Store_type;






-- Data Analysis Q1: which channel is most frequently used for transactions?
SELECT TOP 1 Store_type, COUNT(*) AS txn_count
FROM Transactions
GROUP BY Store_type
ORDER BY txn_count DESC;





-- Data Analysis Q2: count of Male and Female customers
SELECT Gender, COUNT(*) AS customer_count
FROM Customer
GROUP BY Gender;




-- Data Analysis Q3: city with the maximum number of customers
SELECT TOP 1 city_code, COUNT(*) AS customer_count
FROM Customer
GROUP BY city_code
ORDER BY customer_count DESC;




SELECT city_code, COUNT(*) AS customer_count
FROM Customer
GROUP BY city_code
ORDER BY customer_count DESC;





-- Data Analysis Q4: number of sub-categories under Books


SELECT COUNT(*) AS books_subcat_count
FROM prod_cat_info
WHERE prod_cat = 'Books';


SELECT COUNT(DISTINCT prod_subcat) AS books_subcat_count
FROM prod_cat_info
WHERE prod_cat = 'Books';



-- Data Analysis Q5: maximum quantity of products ever ordered


SELECT MAX(Qty) AS max_qty
FROM Transactions
WHERE Qty > 0;




-- Data Analysis Q6: net total revenue in Electronics and Books


SELECT p.prod_cat, SUM(t.total_amt) AS net_revenue
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
WHERE p.prod_cat IN ('Electronics', 'Books')
GROUP BY p.prod_cat;





-- Data Analysis Q7: customers with >10 transactions, excluding returns

SELECT COUNT(*) AS customers_over_10
FROM (
    SELECT cust_id
    FROM Transactions
    WHERE Qty > 0
    GROUP BY cust_id
    HAVING COUNT(*) > 10
) AS qualifying_customers;




SELECT cust_id, COUNT(*) AS txn_count
FROM Transactions
WHERE Qty > 0
GROUP BY cust_id
HAVING COUNT(*) > 10
ORDER BY txn_count DESC;



-- Data Analysis Q8: combined revenue from Electronics & Clothing, Flagship store only

SELECT SUM(t.total_amt) AS combined_revenue
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
WHERE p.prod_cat IN ('Electronics', 'Clothing')
  AND t.Store_type = 'Flagship store';




  -- Data Analysis Q9: total revenue from Male customers in Electronics, by sub-category


SELECT p.prod_subcat, SUM(t.total_amt) AS total_revenue
FROM Transactions AS t
JOIN Customer AS c
    ON t.cust_id = c.customer_Id
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
   AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE c.Gender = 'M'
  AND p.prod_cat = 'Electronics'
GROUP BY p.prod_subcat
ORDER BY total_revenue DESC;





-- Data Analysis Q10: % of sales and returns by sub-category, top 5 by sales


WITH subcat_totals AS (
    SELECT
        p.prod_subcat,
        SUM(CASE WHEN t.Qty > 0 THEN t.total_amt ELSE 0 END) AS sales_amt,
        SUM(CASE WHEN t.Qty < 0 THEN t.total_amt ELSE 0 END) AS returns_amt
    FROM Transactions AS t
    JOIN prod_cat_info AS p
        ON t.prod_cat_code = p.prod_cat_code
       AND t.prod_subcat_code = p.prod_sub_cat_code
    GROUP BY p.prod_subcat
),
grand AS (
    SELECT
        SUM(sales_amt)   AS total_sales,
        SUM(returns_amt) AS total_returns
    FROM subcat_totals
)
SELECT TOP 5
    s.prod_subcat,
    s.sales_amt,
    s.returns_amt,
    CAST(s.sales_amt   * 100.0 / g.total_sales   AS DECIMAL(5,2)) AS sales_pct,
    CAST(s.returns_amt * 100.0 / g.total_returns AS DECIMAL(5,2)) AS returns_pct
FROM subcat_totals AS s
CROSS JOIN grand AS g
ORDER BY s.sales_amt DESC;





-- Data Analysis Q11: net revenue from customers aged 25-35, last 30 days of data


-- Data Analysis Q11: net revenue from customers aged 25-35, last 30 days of data
WITH max_dt AS (
    SELECT MAX(CONVERT(date, tran_date, 105)) AS max_date
    FROM Transactions
)
SELECT SUM(t.total_amt) AS net_revenue_25_35_last30
FROM Transactions AS t
JOIN Customer AS c
    ON t.cust_id = c.customer_Id
CROSS JOIN max_dt AS m
WHERE
    -- age 25 to 35, measured at the max transaction date
    DATEDIFF(YEAR, CONVERT(date, c.DOB, 105), m.max_date) BETWEEN 25 AND 35
    -- transaction within the last 30 days of the data
    AND CONVERT(date, t.tran_date, 105) BETWEEN DATEADD(DAY, -30, m.max_date) AND m.max_date;






	-- Data Analysis Q12: category with max value of returns, last 3 months of data


WITH max_dt AS (
    SELECT MAX(CONVERT(date, tran_date, 105)) AS max_date
    FROM Transactions
)
SELECT TOP 1
    p.prod_cat,
    SUM(t.total_amt) AS net_returns,
    ABS(SUM(t.total_amt)) AS return_value
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
CROSS JOIN max_dt AS m
WHERE t.Qty < 0
  AND CONVERT(date, t.tran_date, 105)
        BETWEEN DATEADD(MONTH, -3, m.max_date) AND m.max_date
GROUP BY p.prod_cat
ORDER BY return_value DESC;










WITH max_dt AS (
    SELECT MAX(CONVERT(date, tran_date, 105)) AS max_date
    FROM Transactions
)
SELECT
    p.prod_cat,
    SUM(t.total_amt) AS net_returns,
    ABS(SUM(t.total_amt)) AS return_value
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
CROSS JOIN max_dt AS m
WHERE t.Qty < 0
  AND CONVERT(date, t.tran_date, 105)
        BETWEEN DATEADD(MONTH, -3, m.max_date) AND m.max_date
GROUP BY p.prod_cat
ORDER BY return_value DESC;






-- Data Analysis Q13: store-type with max sales by value and by quantity

SELECT
    Store_type,
    SUM(total_amt) AS total_sales_value,
    SUM(Qty)       AS total_quantity
FROM Transactions
GROUP BY Store_type
ORDER BY total_sales_value DESC;







-- Data Analysis Q14: categories with average revenue above the overall average


SELECT
    p.prod_cat,
    AVG(t.total_amt) AS avg_category_revenue
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat
HAVING AVG(t.total_amt) > (
    SELECT AVG(total_amt) FROM Transactions
)
ORDER BY avg_category_revenue DESC;








-- Data Analysis Q15: avg and total revenue by sub-category,
-- for the top 5 categories by quantity sold


WITH top5_categories AS (
    SELECT TOP 5
        t.prod_cat_code,
        SUM(t.Qty) AS total_qty
    FROM Transactions AS t
    GROUP BY t.prod_cat_code
    ORDER BY total_qty DESC
)
SELECT
    p.prod_cat,
    p.prod_subcat,
    AVG(t.total_amt) AS avg_revenue,
    SUM(t.total_amt) AS total_revenue
FROM Transactions AS t
JOIN prod_cat_info AS p
    ON t.prod_cat_code = p.prod_cat_code
   AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE t.prod_cat_code IN (SELECT prod_cat_code FROM top5_categories)
GROUP BY p.prod_cat, p.prod_subcat
ORDER BY p.prod_cat, total_revenue DESC;










