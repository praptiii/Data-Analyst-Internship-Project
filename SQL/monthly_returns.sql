CREATE DATABASE ecommerce;
USE ecommerce;

DROP TABLE IF EXISTS full_ecommerce_data;

CREATE TABLE full_ecommerce_data (
    id INT,
    order_id VARCHAR(100),
    user_id VARCHAR(100),
    product_id VARCHAR(100),
    inventory_item_id VARCHAR(100),
    status VARCHAR(50),
    created_at DATETIME,
    sale_price DECIMAL(10,2),
    return_flag TINYINT,
    cost DECIMAL(10,2),
    category VARCHAR(100),
    name VARCHAR(255),
    brand VARCHAR(100),
    retail_price DECIMAL(10,2),
    department VARCHAR(100),
    sku VARCHAR(100),
    distribution_center_id VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    age INT,
    gender VARCHAR(20),
    state VARCHAR(50),
    street_address VARCHAR(255),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    country VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    traffic_source_x VARCHAR(100),
    traffic_source VARCHAR(100),
    price_margin DECIMAL(10,2),
    discount DECIMAL(10,2),
    is_discounted TINYINT,
    order_day INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/full_ecommerce_data_cleaned.csv'
INTO TABLE full_ecommerce_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, order_id, user_id, product_id, inventory_item_id, status, @created_at, sale_price, return_flag, cost, category, name, brand, retail_price, department, sku, distribution_center_id, first_name, last_name, email, @age, gender, state, street_address, postal_code, city, country, latitude, longitude, traffic_source_x, traffic_source, price_margin, discount, is_discounted, @order_day)
SET  
  created_at = STR_TO_DATE(NULLIF(@created_at, ''), '%Y-%m-%d %H:%i:%s'),
  age = NULLIF(@age, ''),
  order_day = NULLIF(@order_day, '');
  
SELECT 
    DATE_FORMAT(created_at, '%Y-%m') AS return_month,
    COUNT(*) AS total_orders,
    SUM(return_flag) AS total_returns,
    ROUND(SUM(return_flag) / COUNT(*) * 100, 2) AS return_rate_percent
FROM 
    full_ecommerce_data
WHERE 
    created_at IS NOT NULL
GROUP BY 
    return_month
ORDER BY 
    return_month;




















