-- =============================================
-- Project      : Zara Sales Analysis
-- File         : 01_data_cleaning.sql
-- Author       : Jhalak Saxena
-- Description  : Removes duplicate product entries using ROW_NUMBER()
-- Database     : SQL Server
-- Source Table : zara_sales_backup and latest_price_table
-- Query Focus  : Data cleaning using PARTITION BY + ORDER BY scraped_at
-- =============================================

SELECT *
INTO latest_price_table
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY product_name ORDER BY scraped_at DESC) AS rn
    FROM zara_sales_backup
) AS ranked
WHERE rn = 1;
