/* =====================================
   Test Queries - Silver Layer Validation
===================================== */

-- =====================
-- Checking silver.crm_cust_info
-- =====================

-- Null Customer IDs
SELECT *
FROM silver.crm_cust_info
WHERE cst_id IS NULL;

-- Unwanted Spaces
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname  != TRIM(cst_lastname);

-- Standardization Check
SELECT DISTINCT cst_material_status
FROM silver.crm_cust_info;

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;


-- =====================
-- Checking silver.crm_prd_info
-- =====================

-- Null Product IDs
SELECT *
FROM silver.crm_prd_info
WHERE prd_id IS NULL;

-- Unwanted Spaces
SELECT *
FROM silver.crm_prd_info
WHERE prd_nm   != TRIM(prd_nm)
   OR prd_line != TRIM(prd_line);

-- Standardization Check
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;


-- =====================
-- Checking silver.crm_sales_details
-- =====================

-- Invalid Keys
SELECT *
FROM silver.crm_sales_details
WHERE sls_ord_num IS NULL
   OR sls_prd_key IS NULL
   OR sls_cust_id IS NULL;

-- Invalid Dates
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Invalid Measures
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales < 0
   OR sls_quantity < 0
   OR sls_price < 0;


-- =====================
-- Checking silver.erp_cust_az12
-- =====================

-- Data Standardization & Consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

-- Invalid Birth Dates
SELECT *
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();


-- =====================
-- Checking silver.erp_loc_a101
-- =====================

-- Data Standardization & Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- Unwanted Spaces
SELECT *
FROM silver.erp_loc_a101
WHERE cntry != TRIM(cntry);


-- =====================
-- Checking silver.erp_px_cat_g1v2
-- =====================

-- Check Unwanted Spaces
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;
