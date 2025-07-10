-- =============================================
-- Project      : Zara Sales Analysis
-- File         : 03_promotions_analysis.sql
-- Author       : Jhalak Saxena
-- Description  : Analyzes the effect of promotions on sales across gender and product types, and calculates percentage sales lift.
-- Database     : SQL Server
-- Source Table : latest_price_table
-- Last Updated : 2025-07-09
-- Query Focus  :  Promotions vs non-promotions
-- =============================================

--How do promotions affect average sales volume?
SELECT 
PROMOTION , 
AVG([Sales volume]) as avg_sales_volume
from latest_price_table
group by Promotion
order by AVG([Sales volume]) desc ;

--Do promoted product type consistently show higher sales volume across different product types?
WITH promo AS (
    SELECT 
        [Type],
        AVG([Sales Volume]) AS avg_sales_p
    FROM zara_sales_backup
    WHERE Promotion = 'yes'
    GROUP BY [Type]
),
no_promo AS (
    SELECT 
        [Type],
        AVG([Sales Volume]) AS avg_sales_np
    FROM zara_sales_backup
    WHERE Promotion = 'no'
    GROUP BY [Type]
)

SELECT 
    p.[Type],
    p.avg_sales_p,
    np.avg_sales_np,
    CASE 
        WHEN p.avg_sales_p > np.avg_sales_np THEN 'Promoted performs better'
        WHEN p.avg_sales_p < np.avg_sales_np THEN 'Non-promoted performs better'
        ELSE 'Same performance'
    END AS promo_effect
FROM promo p
LEFT JOIN no_promo np 
ON p.[Type] = np.[Type];

--How effective are promotions in driving sales across genders?
with calculation_table as (
select  
gender,
promotion,
count(*) as product_count , 
sum([Sales Volume]) as total_sales,
avg([Sales Volume]) as avg_sales
from latest_price_table 
group by gender , Promotion
) ,
promo_table as (
select 
gender ,
 max(case when promotion = 'yes' then avg_sales end ) as promo_avg ,
max(case when promotion = 'no' then avg_sales end) as no_promo_avg
from calculation_table 
group by gender) 

select 
gender ,
concat (round((promo_avg - no_promo_avg) * 100 / no_promo_avg , 2) , '%' ) as percent_affect
from promo_table ;

-- What types of products are most impacted by promotion (in % sales lift)?

with calculation2_table as (
select  
Type,
promotion,
count(*) as product_count , 
sum([Sales Volume]) as total_sales,
avg([Sales Volume]) as avg_sales
from latest_price_table 
group by Type, Promotion
),
promo_table2 as (
select 
type,
 max(case when promotion = 'yes' then avg_sales end ) as promo_avg ,
max(case when promotion = 'no' then avg_sales end) as no_promo_avg
from calculation2_table 
group by type) 

select 
type ,
concat (round((promo_avg - no_promo_avg) * 100 / no_promo_avg , 2) , '%' ) as percent_affect
from promo_table2 ;

--Which gender-based products are most frequently promoted?
select 
gender,
count(promotion) as promotion_count
from zara_sales_backup
group by Gender
order by count(promotion) desc