-- Customer Dimension 
CREATE TABLE Dim_Customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_type TEXT,
    gender TEXT,
    branch TEXT,
    city TEXT,
    created_at DATETIME
);



-- Product Dimension
CREATE TABLE Dim_Product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_line TEXT,
    unit_price REAL,
    created_at DATETIME 
);



-- Fact Sales Table
CREATE TABLE Fact_Sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    invoice_id TEXT,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    tax REAL,
    sales REAL,
    cogs REAL,
    gross_margin_percentage REAL,
    gross_income REAL,
    rating REAL,
    payment TEXT,
    date TEXT,
    time TEXT,
    created_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Dim_Product(product_id)
);