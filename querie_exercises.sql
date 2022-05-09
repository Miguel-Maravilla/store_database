# Select the columns “first_name”, “last_name” and “points” from the table “Customers” in the Database 
# “store”. Also add another column in which the points of each client are divided by 10 and the 
# result is multiplied by 2 and is named "Discount_client".

USE store;
SELECT first_name, last_name, points, ((points / 10)) * 2 AS "Disccount_client"
FROM customers;



# From the “order_ítems” table get the ítems
#	- for order # 6
#	- Where the total Price is greater tan 30

USE store;
SELECT order_id, product_id, quantity, unit_price, unit_price * quantity AS total_price
FROM order_items 
WHERE order_id = 6 AND (unit_price * quantity) > 30;



# Get the customers whose addresses contain TRAIL or AVENUE
USE store;
SELECT *
FROM customers 
WHERE address LIKE "%TRAIL%" OR address LIKE "%AVENUE%";




# Combine the “order_ítems” table and the “products” table, so for each order returns its order id, 
# the product id and the product name. 

USE store;
SELECT oi.order_id, oi.product_id, p.name
FROM order_items oi
INNER JOIN products p 
	ON oi.product_id = p.product_id;




# Combine the “order_ítems” , the “products”, the “customers” table and “orders” table, so for each order 
# returns its order id, the product id, the product name, customer first name and last name and the quantity

USE store;
SELECT oi.order_id, oi.product_id, oi.quantity, p.name, o.customer_id, c.first_name, c.last_name
FROM order_items oi
INNER JOIN products p
	ON oi.product_id = p.product_id
INNER JOIN orders o
	ON oi.order_id = o.order_id
INNER JOIN customers c
	ON o.customer_id = c.customer_id;




# The “Order items” table (in store db) has a “composite primary key”. Knowing that, 
# join the “Order ítems” table with the “Order ítems notes” table

SELECT oin.note_id, oi.order_id, oi.product_id, oi.quantity, oi.unit_price, oin.note
FROM order_items oi
INNER JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;




# Combine the customes and orders table so that appear ALL the customers, even the ones that don’t have an order

USE store;
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id;





# Show all the customers; those who have an order and those who doesn’t. Also show the name of the shipper for the orders.

USE store;
SELECT c.customer_id, c.first_name, o.order_id, os.order_status_id, s.name AS Shipper_name
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN order_statuses os
	ON o.status = os.order_status_id
LEFT JOIN shippers s 
	ON o.shipper_id = s.shipper_id;




# Combine every customer of the “costumers” table, with every product of the “products” table. Sort them by customer.

USE store;
SELECT c.first_name AS Customer, p.name AS Product
FROM customers c 
INNER JOIN products p
ORDER BY c.first_name;





# Make two selections: 
# a)	All the orders after 2019  (create a status label called: “Active”) 
# b)	All the orders before 2019 (status label called “Archived”)

USE store;
SELECT order_id, customer_id, order_date, "ACTIVE" AS Status
FROM orders 
WHERE order_date > "2019-01-01"
UNION
SELECT order_id, customer_id, order_date, "ARCHIVED"
FROM orders 
WHERE order_date < "2019-01-01";




# Insert into the customers table an entire row. Do it in the two ways: short and long.
USE store;
INSERT INTO customers VALUES (DEFAULT, "Angel", "Martell", NULL, 3322176380, "Vicente Guerrero Street", "Vancuver", "VA", 4567);
INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
VALUES ("Miquel", "Martell", "1996-07-19", "Cesar 1 street", "Rome", "JA");







# Write a statemnts that allows to insert three rows in the products table (in a single query)
USE store;
INSERT INTO products (name, quantity_in_stock, unit_price) 
VALUES 	("Chaymito de Nestlé", 29, 54.0),
		("For loco", 7, 63.4),
		("Schokolade", 15, 11.10);




# Insert a row into the “Orders” and “Order items” tables, so that inmediatly after the order is created in MySQL, 
# the new “Order_id”  will be used to asign the “order ítems”.

USE store;
INSERT INTO orders VALUES (DEFAULT, 4, NOW(), 1, NULL, NULL, NULL);
INSERT INTO order_items VALUES(LAST_INSERT_ID(), 3, 10, 15.5);

