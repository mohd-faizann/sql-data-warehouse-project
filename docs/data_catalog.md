# Data Catalog

This catalog documents the Gold layer of the data warehouse. The Gold layer contains business-ready datasets designed for reporting, dashboards, and analytics. It follows a star schema approach using dimension tables for descriptive data and a fact table for measurable transactions.

---

# gold.dim_customers

**Purpose:** Stores enriched customer information combined from CRM and ERP systems for customer analysis and segmentation.

| Column Name     | Data Type    | Description                                         |
| --------------- | ------------ | --------------------------------------------------- |
| customer_key    | INT          | Surrogate key generated for each customer record.   |
| customer_id     | INT          | Original customer ID from source system.            |
| customer_number | NVARCHAR(50) | Business customer reference number.                 |
| first_name      | NVARCHAR(50) | Customer first name.                                |
| last_name       | NVARCHAR(50) | Customer last name.                                 |
| country         | NVARCHAR(50) | Customer country from location source.              |
| marital_status  | NVARCHAR(50) | Customer marital status.                            |
| gender          | NVARCHAR(50) | Final gender value merged from CRM and ERP sources. |
| birthdate       | DATE         | Customer date of birth.                             |
| create_date     | DATE         | Customer creation date in source system.            |

---

# gold.dim_products

**Purpose:** Stores product master data with category details for product performance and sales analysis.

| Column Name    | Data Type     | Description                                      |
| -------------- | ------------- | ------------------------------------------------ |
| product_key    | INT           | Surrogate key generated for each product record. |
| product_id     | INT           | Original product ID from source system.          |
| product_number | NVARCHAR(50)  | Business product reference number.               |
| product_name   | NVARCHAR(100) | Product name.                                    |
| category_id    | NVARCHAR(50)  | Product category identifier.                     |
| category       | NVARCHAR(50)  | Main product category.                           |
| subcategory    | NVARCHAR(50)  | Product subcategory.                             |
| maintenance    | NVARCHAR(50)  | Maintenance classification of product.           |
| cost           | INT           | Product standard cost.                           |
| product_line   | NVARCHAR(50)  | Product line such as Mountain, Road, Touring.    |
| start_date     | DATE          | Product active start date.                       |

---

# gold.fact_sales

**Purpose:** Stores sales transactions linked with customer and product dimensions for revenue and trend analysis.

| Column Name   | Data Type    | Description                             |
| ------------- | ------------ | --------------------------------------- |
| order_number  | NVARCHAR(50) | Unique sales order number.              |
| product_key   | INT          | Foreign key linked to dim_products.     |
| customer_key  | INT          | Foreign key linked to dim_customers.    |
| order_date    | DATE         | Date when order was placed.             |
| shipping_date | DATE         | Date when order was shipped.            |
| due_date      | DATE         | Expected delivery or due date.          |
| sales_amount  | INT          | Total sales amount for the transaction. |
| quantity      | INT          | Quantity of products sold.              |
| price         | INT          | Unit selling price.                     |
