-- Branch wise total sales, total gross income, and than rank branches based on total sales in descending order
SELECT 
    dc.branch, 
    dc.city,
    round(SUM(fs.sales), 2) AS total_sales,
    round(SUM(fs.gross_income), 2) AS total_gross_income,
    COUNT(fs.invoice_id) AS total_transactions,
    RANK() OVER (ORDER BY SUM(fs.sales) DESC) AS sales_rank
FROM Fact_Sales fs
JOIN Dim_Customer dc
    ON fs.customer_id = dc.customer_id
JOIN Dim_Product dp
    ON fs.product_id = dp.product_id
GROUP BY dc.branch, dc.city
ORDER BY total_sales DESC;





-- Top 3 products for each branch based on total sales
WITH product_sales AS (
    SELECT
        dc.branch,
        dp.product_line,
        round(SUM(fs.sales), 2) AS total_sales
    FROM Fact_Sales fs
    JOIN Dim_Customer dc
        ON fs.customer_id = dc.customer_id
    JOIN Dim_Product dp
        ON fs.product_id = dp.product_id
    GROUP BY dc.branch, dp.product_line
)
SELECT *
FROM (
    SELECT
        branch,
        product_line,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY branch
            ORDER BY total_sales DESC
        ) AS rn
    FROM product_sales
)
WHERE rn <= 3
ORDER BY branch, rn;