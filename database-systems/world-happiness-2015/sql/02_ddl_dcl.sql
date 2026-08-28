-- ============================================================
-- WORLD HAPPINESS REPORT DB
-- DDL and DCL Queries
-- ============================================================

USE happiness_db;

-- DDL
ALTER TABLE happiness_2015 ADD COLUMN Status VARCHAR(20);
SHOW COLUMNS FROM happiness_2015;

SELECT * FROM happiness_2015 LIMIT 5;

ALTER TABLE happiness_2015
MODIFY COLUMN Happiness_Rank SMALLINT;

UPDATE happiness_2015
SET Status = CASE
    WHEN Happiness_Score >= 7.000 THEN 'Very High'
    WHEN Happiness_Score >= 5.000 THEN 'Moderate'
    ELSE 'Low'
END;

SELECT Country, Happiness_Score, Status
FROM happiness_2015
LIMIT 10;

ALTER TABLE happiness_2015
ADD CONSTRAINT chk_score CHECK (Happiness_Score >= 0);

RENAME TABLE happiness_2015 TO world_happiness_2015;

CREATE INDEX idx_region ON world_happiness_2015(Region);
SHOW INDEX FROM world_happiness_2015;

-- DCL
-- Use a secure local password instead of committing a real password.
CREATE USER IF NOT EXISTS 'happy_analyst'@'localhost'
IDENTIFIED BY 'CHANGE_ME';

GRANT SELECT
ON happiness_db.world_happiness_2015
TO 'happy_analyst'@'localhost';

GRANT SELECT, INSERT
ON happiness_db.world_happiness_2015
TO 'happy_analyst'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON happiness_db.world_happiness_2015
TO 'happy_analyst'@'localhost';

GRANT ALL PRIVILEGES
ON happiness_db.world_happiness_2015
TO 'happy_analyst'@'localhost';

GRANT ALL PRIVILEGES
ON happiness_db.*
TO 'happy_analyst'@'localhost';

FLUSH PRIVILEGES;
SHOW GRANTS FOR 'happy_analyst'@'localhost';

REVOKE UPDATE, DELETE
ON happiness_db.world_happiness_2015
FROM 'happy_analyst'@'localhost';

REVOKE ALL PRIVILEGES
ON happiness_db.world_happiness_2015
FROM 'happy_analyst'@'localhost';

DROP USER IF EXISTS 'happy_analyst'@'localhost';
