-- ============================================================
-- WIND FARM DEVELOPMENT BUDGET MANAGEMENT SYSTEM
-- Schema and sample data
-- Source: DBMS Assessment 2
-- ============================================================

CREATE DATABASE IF NOT EXISTS WindFarmDevelopmentBudgetMS;
USE WindFarmDevelopmentBudgetMS;

CREATE TABLE IF NOT EXISTS project (
    project_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    PRIMARY KEY (project_id)
);

INSERT INTO project (project_id, name, location) VALUES
(101, 'Daiwik', 'Perinthalmanna'),
(102, 'Shreyaan', 'Palakkad town'),
(103, 'Stark', 'Cochin'),
(104, 'Tom', 'Munnar'),
(105, 'Vyshnav', 'Wayanad');

CREATE TABLE IF NOT EXISTS budget_phase (
    phase_id INT NOT NULL,
    project_id INT NOT NULL,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    PRIMARY KEY (phase_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

INSERT INTO budget_phase (phase_id, project_id, start_time, end_time) VALUES
(1, 101, '2026-01-10', '2026-04-15'),
(2, 102, '2026-02-20', '2026-06-30'),
(3, 103, '2026-03-01', '2026-08-15'),
(4, 104, '2026-05-12', '2026-11-20'),
(5, 105, '2026-06-01', '2026-12-05');

CREATE TABLE IF NOT EXISTS expense_log (
    expense_id INT NOT NULL,
    phase_id INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    expense DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (expense_id),
    FOREIGN KEY (phase_id) REFERENCES budget_phase(phase_id)
);

INSERT INTO expense_log (expense_id, phase_id, category, expense) VALUES
(5001, 1, 'Excavation and Anchor Bolting', 450000.00),
(5002, 2, 'Aerodynamic Blade Evaluation', 120000.50),
(5003, 3, 'High Voltage Grid Connection', 850000.00),
(5004, 4, 'Environmental Avian Study', 65000.00),
(5005, 5, 'Substation Transformer Housing', 920000.75);

CREATE TABLE IF NOT EXISTS procurement_contract (
    contract_id INT NOT NULL,
    project_id INT NOT NULL,
    contract_value DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (contract_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

INSERT INTO procurement_contract (contract_id, project_id, contract_value) VALUES
(901, 101, 2300000.00),
(902, 102, 4100000.00),
(903, 103, 1850000.00),
(904, 104, 5200000.00),
(905, 105, 3100000.00);

CREATE TABLE IF NOT EXISTS turbine_installation (
    model_id INT NOT NULL,
    project_id INT NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    PRIMARY KEY (model_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

INSERT INTO turbine_installation (model_id, project_id, manufacturer) VALUES
(3001, 101, 'Vortexis Kinematics'),
(3002, 102, 'Xenon Aeolian Systems'),
(3003, 103, 'Zephyrus Dynamix'),
(3004, 104, 'Krypton Rotor Corp'),
(3005, 105, 'AeroStratum Labs');
