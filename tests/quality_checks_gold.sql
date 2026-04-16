/*
========================================
Gold Layer Quality Checks

Expected Result:
Most validation queries should return
no rows unless an issue exists.
========================================
*/

-- =====================================
-- Checking gold.dim_customers
-- =====================================

-- Check for uniqueness of customer_key in gold
-- Expectation: No Results
SELECT customer_key, COUNT(*) AS record_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check for null business keys
-- Expectation: No Results
SELECT *
FROM gold.dim_customers
WHERE customer_id IS NULL
   OR customer_number IS NULL;

-- Check standardized gender values
SELECT DISTINCT gender
FROM gold.dim_customers;

-- Check standardized country values
SELECT DISTINCT country
FROM gold.dim_customers
ORDER BY country;


-- =====================================
-- Checking gold.dim_products
-- =====================================

-- Check for uniqueness of product_key in gold
-- Expectation: No Results
SELECT product_key, COUNT(*) AS record_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check for null business keys
-- Expectation: No Results
SELECT *
FROM gold.dim_products
WHERE product_id IS NULL
   OR product_number IS NULL;

-- Check missing category mapping
-- Expectation: No Results
SELECT *
FROM gold.dim_products
WHERE category IS NULL
   OR subcategory IS NULL;

-- Check standardized product line values
SELECT DISTINCT product_line
FROM gold.dim_products;


-- =====================================
-- Checking gold.fact_sales
-- =====================================

-- Check for duplicate fact rows
-- Expectation: No Results
SELECT order_number, product_key, customer_key, COUNT(*) AS record_count
FROM gold.fact_sales
GROUP BY order_number, product_key, customer_key
HAVING COUNT(*) > 1;

-- Check null foreign keys
-- Expectation: No Results
SELECT *
FROM gold.fact_sales
WHERE product_key IS NULL
   OR customer_key IS NULL;

-- Check data model connectivity between fact and dimensions
-- Expectation: No Results
SELECT fs.*
FROM gold.fact_sales fs
LEFT JOIN gold.dim_products dp
    ON fs.product_key = dp.product_key
LEFT JOIN gold.dim_customers dc
    ON fs.customer_key = dc.customer_key
WHERE dp.product_key IS NULL
   OR dc.customer_key IS NULL;

-- Check negative values
-- Expectation: No Results
SELECT *
FROM gold.fact_sales
WHERE sales_amount < 0
   OR quantity < 0
   OR price < 0;

-- Check date sequence
-- Expectation: No Results
SELECT *
FROM gold.fact_sales
WHERE order_date > shipping_date
   OR order_date > due_date;

-- Check revenue calculation
-- Expectation: No Results
SELECT *
FROM gold.fact_sales
WHERE sales_amount != quantity * price;
GO
