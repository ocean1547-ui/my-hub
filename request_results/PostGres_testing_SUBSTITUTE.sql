-- ============================================================================
-- SUBSTITUTE SCRIPT -- NOT the original course file.
--
-- The exercise "PostgreSQL Environment Setup" (DBAS5115) refers to a provided
-- file called "PostGres_testing.sql", but that file was not present in this
-- repository or in the local course materials. This substitute was written
-- for a my-hub pipeline TEST run (at James's request, 2026-10-30) so the
-- connection-test workflow could still be exercised end to end.
--
-- It mirrors the shape of the exercise:
--   * a DROP TABLE statement at the top (the exercise says: do NOT run the
--     DROP TABLE command the first time you run the script),
--   * a CREATE TABLE,
--   * INSERT statements that load a few records,
--   * a final SELECT that returns the table records (the output you would
--     screenshot as successful_setup.bmp in the real exercise).
-- ============================================================================

DROP TABLE IF EXISTS setup_test_records;

CREATE TABLE setup_test_records (
    record_id   SERIAL PRIMARY KEY,
    full_name   VARCHAR(60) NOT NULL,
    course_code VARCHAR(12) NOT NULL,
    task        VARCHAR(80) NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'complete',
    recorded_on DATE        NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO setup_test_records (full_name, course_code, task) VALUES
    ('James Song',   'DBAS5115', 'PostgreSQL environment setup'),
    ('James Song',   'DBAS5115', 'Database connection test'),
    ('Ada Lovelace', 'DBAS5115', 'CREATE TABLE practice'),
    ('Alan Turing',  'DBAS5115', 'INSERT practice'),
    ('Grace Hopper', 'DBAS5115', 'SELECT practice');

SELECT record_id, full_name, course_code, task, status, recorded_on
FROM setup_test_records
ORDER BY record_id;
