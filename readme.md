# 🛍️ Zara Sales SQL Analysis

This project presents a comprehensive data analysis of Zara's product sales using **SQL Server** and **Python (pandas)**. It covers data cleaning, exploratory insights, and business-focused questions — including promotions, product types, pricing strategies, and seasonal effects.

---
Here is a link to my dashboard which gives basic insights 
<img width="1398" height="777" alt="image" src="https://github.com/user-attachments/assets/286244a0-553c-435e-ab96-24bc37f54fcb" />


## 📌 Objectives

- Clean messy retail sales data using Python
- Import into SQL Server for business-driven analysis
- Generate insights that support pricing, marketing, and positioning decisions

---

## 🛠️ Tools & Technologies

| Tool           | Purpose                              |
|----------------|--------------------------------------|
| Python (pandas)| Pre-SQL data cleaning using jupyter notebook (outlier removal, deduplication) |
| SQL Server     | Data analysis and business insights  |
| Git + GitHub   | Version control and project hosting  |

---

## 🧼 Data Cleaning (Python)

Initial preprocessing was done using `pandas` before loading the data into SQL Server.

Key steps:
- Removed duplicates based on `product_name` and latest `scraped_at`
- Removed price outliers using **IQR method**
- Exported cleaned data as `zara_cleaned` for SQL use

📄 File: `python/00_data_cleaning_pandas.py`

---

## 📊 Business Questions Answered (SQL)

Each question is answered in a separate SQL file in the [`sql/`](sql/) folder:

| File | Question |
|------|----------|
| `01_data_cleaning.sql` | Remove duplicate scraped entries using ROW_NUMBER |
| `02_basic_insights.sql` | Top-selling products, gender sales comparison, avg price/type |
| `03_promotions_analysis.sql` | How promotions affect sales across type & gender |
| `04_pricing_outlier_analysis.sql` | Find overpriced products using NTILE() |
| `05_seasonal_position_analysis.sql` | Analyze seasonal trends and product positions |

---

