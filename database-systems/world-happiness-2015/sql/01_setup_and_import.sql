-- ============================================================
-- WORLD HAPPINESS REPORT DB
-- Regular Queries
-- ============================================================

CREATE DATABASE IF NOT EXISTS happiness_db;
USE happiness_db;

CREATE TABLE IF NOT EXISTS happiness_2015 (
    Country VARCHAR(50),
    Region VARCHAR(100),
    Happiness_Rank INT PRIMARY KEY,
    Happiness_Score DECIMAL(10,5),
    Standard_Error DECIMAL(10,5),
    Economy_GDP_per_Capita DECIMAL(10,5),
    Family DECIMAL(10,5),
    Health_Life_Expectancy DECIMAL(10,5),
    Freedom DECIMAL(10,5),
    Trust_Government_Corruption DECIMAL(10,5),
    Generosity DECIMAL(10,5),
    Dystopia_Residual DECIMAL(10,5)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- Change the path to the location of your local CSV file.
LOAD DATA LOCAL INFILE 'data/2015.csv'
INTO TABLE happiness_2015
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM happiness_2015;
SELECT * FROM happiness_2015 LIMIT 10;

-- Average happiness score by region
SELECT Region, AVG(Happiness_Score) AS avg_score
FROM happiness_2015
GROUP BY Region
ORDER BY avg_score DESC;
