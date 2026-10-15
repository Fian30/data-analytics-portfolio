-- =====================================================================
-- CASE STUDY: BUILDING DATABASE
-- Platform E-Commerce
-- PostgreSQL + DBeaver
-- =====================================================================


-- =====================================================================
-- RESET TABLE
-- =====================================================================

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS categories;


-- =====================================================================
-- STUDI KASUS 1 - DDL & TABEL MASTER
-- =====================================================================

CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id       SERIAL PRIMARY KEY,
    customer_name     VARCHAR(50) NOT NULL,
    email             VARCHAR(100) UNIQUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =====================================================================
-- STUDI KASUS 2 - RELASI & FOREIGN KEY
-- =====================================================================

CREATE TABLE products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price        NUMERIC(10,2) CHECK (price >= 0),
    category_id  INTEGER REFERENCES categories (category_id)
);


-- =====================================================================
-- STUDI KASUS 3 - TABEL TRANSAKSIONAL
-- =====================================================================

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers (customer_id),
    order_date  TIMESTAMP NOT NULL
);

CREATE TABLE order_details (
    order_id   INTEGER REFERENCES orders (order_id),
    product_id INTEGER REFERENCES products (product_id),
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);


-- =====================================================================
-- STUDI KASUS 4 - DML
-- =====================================================================


-- ---------- categories ----------
INSERT INTO categories (category_id, category_name) VALUES
    (1, 'Fresh Food'),
    (2, 'Pet Supplies'),
    (3, 'Automotive'),
    (4, 'Books'),
    (5, 'Toys');


-- ---------- customers ----------
INSERT INTO customers
    (customer_id, customer_name, email, registration_date) VALUES
    (1, 'Farhan Maulana', 'farhan.maulana@mail.com', '2026-01-12'),
    (2, 'Nabila Putri', 'nabila.putri@mail.com', '2026-01-25'),
    (3, 'Yoga Prasetya', 'yoga.prasetya@mail.com', '2026-02-08'),
    (4, 'Aulia Rahma', 'aulia.rahma@mail.com', '2026-02-21'),
    (5, 'Bagas Kurniawan', 'bagas.kurniawan@mail.com', '2026-03-04');


-- ---------- products ----------
INSERT INTO products
    (product_id, product_name, price, category_id) VALUES
    (1, 'Madu Hutan 500ml', 95000, 1),
    (2, 'Pasir Kucing 10L', 62000, 2),
    (3, 'Car Vacuum Cleaner', 275000, 3),
    (4, 'Novel Senja di Kota', 89000, 4),
    (5, 'Puzzle Edukasi 500pcs', 72000, 5);


-- ---------- orders ----------
-- Customer ID 5 tidak memiliki transaksi
INSERT INTO orders
    (order_id, customer_id, order_date) VALUES
    (2001, 1, '2026-07-15 08:45:00'),
    (2002, 2, '2026-07-16 10:20:00'),
    (2003, 3, '2026-07-17 12:10:00'),
    (2004, 4, '2026-07-18 14:35:00'),
    (2005, 1, '2026-07-19 09:50:00');


-- ---------- order_details ----------
INSERT INTO order_details
    (order_id, product_id, quantity, unit_price) VALUES
    (2001, 1, 2, 95000),
    (2001, 2, 1, 62000),
    (2002, 3, 1, 275000),
    (2003, 4, 2, 89000),
    (2004, 5, 1, 72000);


-- ---------- UPDATE ----------
-- Mengubah harga produk
UPDATE products
SET price = 105000
WHERE product_id = 1;


-- ---------- DELETE ----------
-- Menghapus customer yang belum melakukan transaksi
DELETE FROM customers
WHERE customer_id = 5;


-- =====================================================================
-- STUDI KASUS 5 - ALTER TABLE
-- =====================================================================

ALTER TABLE customers
ADD COLUMN phone_number VARCHAR(20);

ALTER TABLE customers
ALTER COLUMN customer_name TYPE VARCHAR(100);


-- =====================================================================
-- FINAL CHECK
-- =====================================================================

SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;