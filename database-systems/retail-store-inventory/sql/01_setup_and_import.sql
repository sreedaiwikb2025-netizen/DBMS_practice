-- ============================================================
-- RETAIL STORE INVENTORY AND SALES DB
-- Setup, table creation and dataset import
-- ============================================================

CREATE DATABASE IF NOT EXISTS retail_assessment_06;
USE retail_assessment_06;

CREATE TABLE IF NOT EXISTS retail_data (
    Date DATE,
    Store_ID INT,
    Product_ID INT,
    Category VARCHAR(50),
    Region VARCHAR(50),
    Inventory_Level INT,
    Units_Sold INT,
    Units_Ordered INT,
    Demand_Forecast INT,
    Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Weather_Condition VARCHAR(50),
    Holiday_Promotion VARCHAR(50),
    Competitor_Pricing DECIMAL(10,2),
    Seasonality VARCHAR(50)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- Change the path to the location of your local CSV file.
LOAD DATA LOCAL INFILE 'data/retail_store_inventory_data.csv'
INTO TABLE retail_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM retail_data;
SELECT * FROM retail_data LIMIT 5;
