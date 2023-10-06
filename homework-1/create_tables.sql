-- Создание таблицы customers_table
CREATE TABLE IF NOT EXISTS customers_table (
    customer_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255),
    contact_name VARCHAR(255)
);

-- Создание таблицы employees_table
CREATE TABLE IF NOT EXISTS employees_table (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    title VARCHAR(255),
    birth_date DATE,
    notes TEXT
);

-- Создание таблицы orders_table
CREATE TABLE IF NOT EXISTS orders_table (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers_table (customer_id),
    employee_id INTEGER REFERENCES employees_table (employee_id),
    order_date DATE,
    ship_city VARCHAR(255)
);
