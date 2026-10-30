-- ============================================================================
-- DDL Script: CREATE, ALTER, & DROP  (SKELETON / PRACTICE VERSION)
-- ----------------------------------------------------------------------------
-- Purpose : Create the five tables for this exercise, with a DROP section at
--           the top so the whole script can be re-run any number of times.
-- Platform: PostgreSQL (GitHub Codespaces default database)
--
-- NOTE: The ERD image for this exercise was not available when this skeleton
-- was written, so the five tables below are a worked EXAMPLE (a small store:
-- customer, product, orders, order_item, payment). To finish the exercise,
-- replace the example tables/columns with the ones in your ERD and adjust
-- the datatypes using the translation guide in Section 2.
--
-- Datatype translation guide (ERD term  ->  PostgreSQL type):
--   int / number        -> INTEGER   (or SERIAL for auto-increment PKs)
--   string / text       -> VARCHAR(n) for short text, TEXT for long text
--   money / decimal     -> NUMERIC(10,2)
--   date                -> DATE
--   date + time         -> TIMESTAMP
--   yes/no / true/false -> BOOLEAN
-- ============================================================================


-- ============================================================================
-- SECTION 1: DROP
-- Drop every table first (children before parents, because of foreign keys)
-- so the script can be run again and again without "already exists" errors.
-- IF EXISTS keeps the very first run error-free as well.
-- ============================================================================
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;


-- ============================================================================
-- SECTION 2: CREATE TABLES
-- ============================================================================

-- Table 1: customer -----------------------------------------------------------
-- One row per customer. email must be unique; names are required.
CREATE TABLE customer (
    customer_id SERIAL       PRIMARY KEY,              -- auto-increment PK
    first_name  VARCHAR(50)  NOT NULL,
    last_name   VARCHAR(50)  NOT NULL,
    email       VARCHAR(120) NOT NULL UNIQUE,
    phone       VARCHAR(20),
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: product ------------------------------------------------------------
-- One row per product. Price can never be negative (CHECK constraint).
CREATE TABLE product (
    product_id   SERIAL        PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    unit_price   NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    in_stock     BOOLEAN       DEFAULT TRUE
);

-- Table 3: orders -------------------------------------------------------------
-- One row per order. Each order belongs to exactly one customer (FK).
CREATE TABLE orders (
    order_id    SERIAL      PRIMARY KEY,
    customer_id INTEGER     NOT NULL REFERENCES customer (customer_id),
    order_date  DATE        NOT NULL DEFAULT CURRENT_DATE,
    status      VARCHAR(20) DEFAULT 'Pending'
);

-- Table 4: order_item ---------------------------------------------------------
-- Junction table that resolves the M:N relationship between orders and
-- product. Its primary key is the pair (order_id, product_id).
CREATE TABLE order_item (
    order_id   INTEGER NOT NULL REFERENCES orders (order_id),
    product_id INTEGER NOT NULL REFERENCES product (product_id),
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

-- Table 5: payment ------------------------------------------------------------
-- One row per payment. Each payment is made against exactly one order (FK).
CREATE TABLE payment (
    payment_id SERIAL        PRIMARY KEY,
    order_id   INTEGER       NOT NULL REFERENCES orders (order_id),
    amount     NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    method     VARCHAR(20),
    paid_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================================
-- SECTION 3: ALTER
-- Changes made AFTER the tables were created. In the real exercise, use this
-- section for whatever the ERD calls for that you add second (a new column,
-- a new constraint, ...). Two typical examples:
-- ============================================================================

-- Example 1: add a new column to an existing table
ALTER TABLE customer
    ADD COLUMN loyalty_points INTEGER DEFAULT 0;

-- Example 2: add a column with a constraint to another table
ALTER TABLE product
    ADD COLUMN category VARCHAR(50) NOT NULL DEFAULT 'General';


-- ============================================================================
-- SECTION 4: VERIFY (optional - run to check your work before the screenshot)
-- Lists the tables that now exist in this database. When the five expected
-- tables appear, take the screenshot for successful_table_creation.bmp.
-- ============================================================================
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
