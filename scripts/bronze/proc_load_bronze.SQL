/*
========================================
Procedure: bronze.load_bronze

Loads CSV source files into Bronze layer.
- Truncates existing data
- Reloads fresh data
- Tracks table and batch time
- Handles load errors

Sources: CRM, ERP
========================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @batch_start_time DATETIME,
            @batch_end_time   DATETIME,
            @start_time       DATETIME,
            @end_time         DATETIME;

    SET @batch_start_time = GETDATE();

    BEGIN TRY
        PRINT '==============================================';
        PRINT 'Loading Bronze Layer';
        PRINT '==============================================';

        PRINT '----------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- crm_cust_info
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting data into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- crm_prd_info
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting data into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- crm_sales_details
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting data into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        PRINT 'Loading ERP Tables';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- erp_cust_az12
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting data into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- erp_loc_a101
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting data into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- erp_px_cat_g1v2
        --------------------------------------------------
        SET @start_time = GETDATE();

        PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'F:\SQL- datawarehouse project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sec';
        PRINT '----------------------------------------------';

        --------------------------------------------------
        -- Whole Batch Time
        --------------------------------------------------
        SET @batch_end_time = GETDATE();

        PRINT '==============================================';
        PRINT 'Bronze Layer Load Completed Successfully';
        PRINT 'Total Batch Duration: ' 
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) 
            + ' sec';
        PRINT '==============================================';

    END TRY

    BEGIN CATCH
        PRINT '==============================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==============================================';
    END CATCH
END;
GO

EXEC bronze.load_bronze;
GO
