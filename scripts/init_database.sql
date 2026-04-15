/*
=====================================================
 Data Warehouse Initialization Script
=====================================================

Purpose:
Sets up the foundational database structure for a
modern data warehouse using Medallion Architecture.

Layers:
- bronze : raw source data
- silver : cleaned and transformed data
- gold   : analytics-ready data

Before Running:
- Use Microsoft SQL Server
- Ensure create database permission
- Run once or check if objects already exist

Avoid:
- Storing transformed data in bronze
- Creating objects in wrong database context
- Re-running blindly in production
=====================================================
*/

-- Create Database
USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

CREATE DATABASE DataWarehouse;
GO

-- Switch Context
USE DataWarehouse;
GO

-- Create Layers
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
