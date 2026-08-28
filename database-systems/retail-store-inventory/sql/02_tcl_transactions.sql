-- ============================================================
-- RETAIL STORE INVENTORY AND SALES
-- Transaction Control Language (TCL)
-- Source: DBMS Assessment 5
-- ============================================================

USE retail_assessment_06;

-- 1. COMMIT
SELECT Store_ID, Product_ID, Inventory_Level
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Inventory_Level = Inventory_Level - 5
LIMIT 1;
COMMIT;

SELECT Store_ID, Product_ID, Inventory_Level
FROM retail_data LIMIT 1;

-- 2. ROLLBACK
SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Price = Price + 0.10
LIMIT 1;
ROLLBACK;

SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 1;

-- 3. SAVEPOINT
SELECT Store_ID, Product_ID, Units_Sold
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Units_Sold = Units_Sold + 10
LIMIT 1;

SAVEPOINT sales_logged;
DELETE FROM retail_data LIMIT 1;
ROLLBACK TO SAVEPOINT sales_logged;
COMMIT;

SELECT Store_ID, Product_ID, Units_Sold
FROM retail_data LIMIT 1;

-- 4. ROLLBACK TO SAVEPOINT
START TRANSACTION;
UPDATE retail_data
SET Discount = 15.00
LIMIT 1;

SAVEPOINT discount_applied;
INSERT INTO retail_data
(Date, Store_ID, Product_ID, Price)
VALUES ('2026-08-25', 9999, 9999, 0.00);

ROLLBACK TO SAVEPOINT discount_applied;
COMMIT;

SELECT Store_ID, Product_ID, Discount
FROM retail_data LIMIT 1;

SELECT * FROM retail_data WHERE Store_ID = 9999;

-- 5. RELEASE SAVEPOINT
ROLLBACK;
SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Price = Price * 0.95
LIMIT 1;

SAVEPOINT price_discount;
RELEASE SAVEPOINT price_discount;
COMMIT;

SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 1;

-- 6. SET TRANSACTION / isolation level
SELECT @@transaction_isolation;
-- For MySQL versions using the older variable name:
-- SELECT @@tx_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT Store_ID, Product_ID, Inventory_Level
FROM retail_data LIMIT 3;
COMMIT;

-- 7. Order placement transaction
SELECT Store_ID, Product_ID, Inventory_Level, Units_Sold
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Inventory_Level = Inventory_Level - 2
LIMIT 1;

UPDATE retail_data
SET Units_Sold = Units_Sold + 2
LIMIT 1;
COMMIT;

SELECT Store_ID, Product_ID, Inventory_Level, Units_Sold
FROM retail_data LIMIT 1;

-- 8. Refund / cancellation with rollback safety
SELECT Store_ID, Product_ID, Inventory_Level, Units_Sold, Discount
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Inventory_Level = Inventory_Level + 1,
    Units_Sold = Units_Sold - 1
LIMIT 1;

SAVEPOINT refund_processed;
UPDATE retail_data
SET Discount = 99.00
LIMIT 1;

ROLLBACK TO SAVEPOINT refund_processed;
COMMIT;

-- 9. Bulk price update with safety net
SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 2;

START TRANSACTION;
SAVEPOINT before_bulk_update;
UPDATE retail_data
SET Price = Price * 1.50;
ROLLBACK TO SAVEPOINT before_bulk_update;
COMMIT;

SELECT Store_ID, Product_ID, Price
FROM retail_data LIMIT 2;

-- 10. Multi-step checkout with partial rollback
SELECT Store_ID, Product_ID, Units_Ordered, Demand_Forecast
FROM retail_data LIMIT 1;

START TRANSACTION;
UPDATE retail_data
SET Units_Ordered = Units_Ordered + 1
LIMIT 1;

SAVEPOINT step_one_secured;
UPDATE retail_data
SET Demand_Forecast = Demand_Forecast + 1
LIMIT 1;

ROLLBACK TO SAVEPOINT step_one_secured;
COMMIT;

SELECT Store_ID, Product_ID, Units_Ordered, Demand_Forecast
FROM retail_data LIMIT 1;
