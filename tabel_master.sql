WITH customer_temp AS (
    SELECT 
        CustomerID AS customer_id,
        CustomerEmail AS customer_email,
        CustomerCity AS customer_city 
    FROM Customer
),
product_temp AS (
    SELECT 
        p.ProdNumber AS product_number,
        p.ProdName AS product_name,
        p.Price AS product_price,
        pc.CategoryName AS category_name
    FROM Product p
    LEFT JOIN productcategory pc
        ON p.CategoryID = pc.CategoryID
),
order_temp AS (
    SELECT 
        o.OrderID AS order_id,
        o.Date AS order_date,
        o.CustomerID AS customer_id,
        o.ProdNumber AS product_number,
        o.Quantity AS order_quantity
    FROM `order` o
)
SELECT 
    ot.order_id,
    ot.order_date,
    ct.customer_email,
    ct.customer_city,
    pt.product_name,
    pt.product_price,
    pt.category_name,
    ot.order_quantity,
    (pt.product_price * ot.order_quantity) AS total_price
FROM order_temp ot
LEFT JOIN customer_temp ct 
    ON ot.customer_id = ct.customer_id
LEFT JOIN product_temp pt 
    ON ot.product_number = pt.product_number
ORDER BY ot.order_date ASC;
