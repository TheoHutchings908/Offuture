SELECT * FROM address; 	   --- TO export address TABLE TO tableau
-----------------

SELECT * FROM "order";     --- TO export order TABLE TO tableau
-----------------

SELECT * FROM order_item;  --- TO export order_item TABLE TO tableau
-----------------

SELECT                     --- TO export customer TABLE INNER joined WITH ORDER TABLE so that customer_id matches AND we can have a relational KEY
	DISTINCT customer_id,
	customer_name,
	segment
FROM
	customer AS c
INNER JOIN
	"order" AS o	
	ON c.customer_id_long = o.customer_id;
-----------------

SELECT 
	*						--- this sorts by category and sub_category as there are many product names.					
FROM 
	offuture.product AS pd
INNER JOIN 
	offuture.order_item AS otm  
	ON pd.PRODUCT_ID = otm.PRODUCT_ID
INNER JOIN 
	offuture.order AS od ON otm.order_id = od.order_id
order by 
	category, sub_category ASC;
-----------------

SELECT 
	*						--- checking FOR orders WITH the same ship_modes
FROM 
	offuture.product AS pd
INNER JOIN
	offuture.order_item AS otm  
	ON pd.PRODUCT_ID = otm.PRODUCT_ID
INNER JOIN 
	offuture.order AS od 
	ON otm.order_id = od.order_id
order by 
	ship_mode ASC;
-----------------

SELECT                     --- ROW count checks
	count(customer_id_short) AS row_count
FROM
    offuture.customer;

---
SELECT 
	count(order_id) AS row_count
FROM
    offuture.order;

---
SELECT 
	count(order_id) AS row_count
FROM
    offuture.order_item;

---
SELECT 
	count(product_id) AS row_count
FROM
    offuture.product;

---
SELECT 
	count(address_id) AS row_count
FROM
    offuture.address;

-----------------

SELECT                     --- shows each products sales desc
    *
FROM 
    offuture.order_item
ORDER BY 
    sales DESC;
-----------------

SELECT 						--- checks how many NULLS ON postal code
    COUNT(*) 
FROM 
    offuture.address 
WHERE 
    postal_code IS NULL OR 
    postal_code =  '';
-----------------
							---total sales per year
SELECT
    LEFT(TO_CHAR(o.order_date,
    'YYYY-MM-DD'), 4) 
    order_year,
    SUM(oi.sales) total_sales_per_year
FROM
    offuture.order_item oi
INNER JOIN 
    offuture.ORDER o ON
    oi.order_id = o.order_id
GROUP BY
    LEFT(TO_CHAR(o.order_date,
    'YYYY-MM-DD'), 4)
ORDER BY
    order_year;
-----------------
							---total profit per year
SELECT
    LEFT(TO_CHAR(o.order_date,
    'YYYY-MM-DD'), 4) 
    order_year,
    SUM(oi.profit) total_profit
FROM
    offuture.order_item oi
INNER JOIN 
    offuture.ORDER o ON
    oi.order_id = o.order_id
GROUP BY
    LEFT(TO_CHAR(o.order_date,
    'YYYY-MM-DD'), 4)
ORDER BY
    total_profit DESC;
-----------------
	
SELECT 						--- calculating total profit across different product name AND category AND sub cat
	product_name,
	profit,category,
	sub_category,
	ship_mode,
	region,
	order_priority 
FROM 
	offuture.product AS pd
INNER JOIN 	
	offuture.order_item AS otm  
	ON  pd.PRODUCT_ID = otm.PRODUCT_ID
LEFT JOIN 
	offuture.order AS od
	ON otm.order_id = od.order_id
order by 
	profit asc;
-----------------

select 
	COUNT (sub_category),  	--- counting how many items IN EACH category
	category
from 
	offuture.product
GROUP BY 
	category
ORDER BY 
	COUNT(sub_category);

-----------------
select 						--- calculating which priority has highest profit
	sum(profit),
	order_priority
from 
	offuture.product as pd
INNER JOIN 
	offuture.order_item AS otm  
	ON  pd.PRODUCT_ID = otm.PRODUCT_ID
LEFT JOIN 
	offuture.order AS od 
	ON otm.order_id = od.order_id
group by 
	order_priority
order by 
	sum(profit) ASC;
-----------------

SELECT						--- best performing product BY profit
	product_name,
	sum(profit) AS total_profit
FROM
	order_item AS oi
INNER JOIN
	product AS p
	ON oi.product_id = p.product_id
GROUP BY
	product_name
ORDER BY
	total_profit DESC
LIMIT
	1;
-----------------

SELECT						--- worst performing product BY profit
	product_name,
	sum(profit) AS total_profit
FROM
	order_item AS oi
INNER JOIN
	product AS p
	ON oi.product_id = p.product_id
GROUP BY
	product_name
ORDER BY
	total_profit asc
LIMIT
	1;
-----------------

SELECT						--- worst performing product BY sales
	product_name,
	sum(sales) AS total_sales
FROM
	order_item AS oi
INNER JOIN
	product AS p
	ON oi.product_id = p.product_id
GROUP BY
	product_name
ORDER BY
	total_sales asc
LIMIT
	1;
-----------------

SELECT						--- best performing product BY sales
	product_name,
	sum(sales) AS total_sales
FROM
	order_item AS oi
INNER JOIN
	product AS p
	ON oi.product_id = p.product_id
GROUP BY
	product_name
ORDER BY
	total_sales desc
LIMIT
	1;
-----------------


	







































