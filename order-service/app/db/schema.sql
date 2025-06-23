CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    user_id TEXT NOT NULL,
    user_email TEXT NOT NULL,
    user_address TEXT NOT NULL,
    product_id INT NOT NULL,
    qty INT NOT NULL,
    creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);