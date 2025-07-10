-- =============================================
-- Project      : Zara Sales Analysis
-- File         : 04_pricing_outlier_analysis.sql
-- Author       : Jhalak Saxena
-- Description  : Identifies overpriced, low-selling products using NTILE 
-- Database     : SQL Server
-- Source Table : latest_price_table
-- Last Updated : 2025-07-09
-- Query Focus  :  High price, low sales, markdown recommendations
-- =============================================

--Which products were overpriced (high price, low sales) and could benefit from markdowns?

 WITH ranked_data AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY price DESC) AS price_rank,
        NTILE(4) OVER (ORDER BY [Sales Volume] ASC) AS sales_rank
    FROM latest_price_table
)
SELECT 
    Product_Name,
    Price,
    [Sales Volume]
FROM ranked_data
WHERE 
    price_rank = 1 AND  -- top 25% expensive
    sales_rank = 1    -- bottom 25% sales
order by price desc ;