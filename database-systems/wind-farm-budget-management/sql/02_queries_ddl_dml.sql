-- ============================================================
-- WIND FARM DEVELOPMENT BUDGET MANAGEMENT SYSTEM
-- Queries, DDL and DML
-- Source: DBMS Assessment 2
-- ============================================================

USE WindFarmDevelopmentBudgetMS;

-- DDL
ALTER TABLE project ADD COLUMN risk_level VARCHAR(20);
ALTER TABLE project MODIFY COLUMN risk_level VARCHAR(30);
ALTER TABLE project CHANGE COLUMN risk_level project_category VARCHAR(30);

ALTER TABLE procurement_contract
ADD CONSTRAINT chk_contract_value CHECK (contract_value > 0);

CREATE INDEX idx_location ON project(location);

-- Basic retrieval
SELECT * FROM project;
SELECT name, location FROM project;

-- Contracts above 2,000,000
SELECT contract_id, project_id, contract_value
FROM procurement_contract
WHERE contract_value > 2000000.00;

-- Projects located in Munnar
SELECT project_id, name, location
FROM project
WHERE location LIKE '%Munnar%';

-- Expenses for selected phases
SELECT expense_id, category, expense
FROM expense_log
WHERE phase_id IN (1, 3, 5);

-- Phases starting during Q1 2026
SELECT phase_id, project_id, start_time, end_time
FROM budget_phase
WHERE start_time BETWEEN '2026-01-01' AND '2026-03-31';

-- Contracts in descending order of value
SELECT contract_id, project_id, contract_value
FROM procurement_contract
ORDER BY contract_value DESC;

-- Top three expenses
SELECT expense_id, category, expense
FROM expense_log
ORDER BY expense DESC
LIMIT 3;

-- Aggregate functions
SELECT SUM(contract_value) AS Total_Procurement_Value
FROM procurement_contract;

SELECT AVG(expense) AS Average_Expense_Amount
FROM expense_log;

SELECT COUNT(*) AS Total_Turbines
FROM turbine_installation;

-- Grouping and HAVING
SELECT category, SUM(expense) AS Total_Category_Expense
FROM expense_log
GROUP BY category;

SELECT category, SUM(expense) AS Total_Category_Expense
FROM expense_log
GROUP BY category
HAVING SUM(expense) > 500000.00;

-- JOIN examples
SELECT p.name, b.start_time, b.end_time
FROM project AS p
JOIN budget_phase AS b ON p.project_id = b.project_id;

SELECT p.name, b.phase_id, e.category, e.expense
FROM project AS p
JOIN budget_phase AS b ON p.project_id = b.project_id
JOIN expense_log AS e ON b.phase_id = e.phase_id;

-- DML examples
UPDATE project
SET location = 'Palakkad Gap'
WHERE project_id = 101;

DELETE FROM expense_log
WHERE expense_id = 5004;

-- Verification
SELECT * FROM project;
SELECT * FROM expense_log;
