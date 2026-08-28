-- ============================================================
-- WIND FARM DEVELOPMENT BUDGET MANAGEMENT SYSTEM
-- Normalization: 1NF, 2NF and 3NF
-- Source: DBMS Assessment 3
-- ============================================================

USE WindFarmDevelopmentBudgetMS;

-- ------------------------------------------------------------
-- 1NF: multi-valued location example
-- ------------------------------------------------------------
UPDATE project
SET location = 'Wayanad, Sulthan Bathery, Kalpetta'
WHERE project_id = 105;

SELECT *
FROM project
WHERE project_id = 105;

CREATE TABLE IF NOT EXISTS project_1nf (
    project_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    PRIMARY KEY (project_id, location)
);

INSERT INTO project_1nf (project_id, name, location) VALUES
(101, 'Daiwik', 'Perinthalmanna'),
(102, 'Shreyaan', 'Palakkad'),
(103, 'Stark', 'Cochin'),
(104, 'Tom', 'Munnar'),
(105, 'Vyshnav', 'Wayanad'),
(105, 'Vyshnav', 'Sulthan Bathery'),
(105, 'Vyshnav', 'Kalpetta');

SELECT * FROM project_1nf;

-- ------------------------------------------------------------
-- 2NF: composite key demonstration
-- ------------------------------------------------------------
ALTER TABLE turbine_installation
ADD COLUMN project_name VARCHAR(100);

UPDATE turbine_installation SET project_name = 'Daiwik' WHERE project_id = 101;
UPDATE turbine_installation SET project_name = 'Shreyaan' WHERE project_id = 102;
UPDATE turbine_installation SET project_name = 'Stark' WHERE project_id = 103;
UPDATE turbine_installation SET project_name = 'Tom' WHERE project_id = 104;
UPDATE turbine_installation SET project_name = 'Vyshnav' WHERE project_id = 105;

SELECT * FROM turbine_installation;

ALTER TABLE turbine_installation DROP PRIMARY KEY;
ALTER TABLE turbine_installation ADD PRIMARY KEY (model_id, project_id);

ALTER TABLE turbine_installation DROP COLUMN project_name;

SELECT * FROM turbine_installation;

-- ------------------------------------------------------------
-- 3NF: project_id -> location -> zone
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS location_zone (
    location VARCHAR(100) NOT NULL,
    zone VARCHAR(50) NOT NULL,
    PRIMARY KEY (location)
);

INSERT INTO location_zone (location, zone) VALUES
('Perinthalmanna', 'Malabar'),
('Palakkad', 'Malabar'),
('Cochin', 'Central Kerala'),
('Munnar', 'High Ranges'),
('Wayanad', 'Malabar');

ALTER TABLE project ADD COLUMN zone VARCHAR(50);

UPDATE project SET location = 'Perinthalmanna', zone = 'Malabar' WHERE project_id = 101;
UPDATE project SET location = 'Palakkad', zone = 'Malabar' WHERE project_id = 102;
UPDATE project SET location = 'Cochin', zone = 'Central Kerala' WHERE project_id = 103;
UPDATE project SET location = 'Munnar', zone = 'High Ranges' WHERE project_id = 104;
UPDATE project SET location = 'Wayanad', zone = 'Malabar' WHERE project_id = 105;

ALTER TABLE project DROP COLUMN zone;

SELECT * FROM location_zone;
SELECT * FROM project;
