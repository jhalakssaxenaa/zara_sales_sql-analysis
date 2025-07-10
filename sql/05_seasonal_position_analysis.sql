-- =============================================
-- Project      : Zara Sales Analysis
-- File         : 05_seasonal_position_analysis.sql
-- Author       : Jhalak Saxena
-- Description  : Evaluates impact of product seasonality and placement (aisle, endcap) on sales performance.
-- Database     : SQL Server
-- Source Table : latest_price_table / zara_sales_backup
-- Last Updated : 2025-07-09
-- Query Focus  : Seasonal product performance
-- =============================================

--Are seasonal products performing better than non-seasonal ones?
select 
seasonal,
avg([sales volume]) as sales_volume_avg
from latest_price_table
group by Seasonal 
order by avg([sales volume]) desc;

--How do seasonal promotions affect the sales of gender-specific products?
SELECT
    Gender,
    Seasonal,
    Promotion,
    COUNT(*) AS product_count,
    ROUND(AVG([Sales Volume]), 2) AS avg_sales_volume,
    SUM([Sales Volume]) AS total_sales_volume
FROM zara_sales_backup
GROUP BY Gender, Seasonal, Promotion
ORDER BY Gender, Seasonal, Promotion;
