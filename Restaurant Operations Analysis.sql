#1. Exploring menu_items table

SELECT *
FROM menu_items;

#2. Total number of items on the menu.

SELECT
COUNT(DISTINCT item_name) AS num_items
FROM menu_items;

#3. How many items are there in each category?

SELECT category,
COUNT(DISTINCT item_name) AS total_items
FROM menu_items
GROUP BY category;

#4. What are the most expensive items on the menu?

SELECT *
FROM menu_items
ORDER BY price DESC;

#5. What are the least expensive items on the menu?

SELECT *
FROM menu_items
ORDER BY price ASC;

#6. a) What are the most and least expensive American items on the menu?

SELECT *
FROM menu_items
WHERE category = "American"
ORDER BY price DESC;

# b) What are the most and least expensive Asian items on the menu?

SELECT *
FROM menu_items
WHERE category = "Asian"
ORDER BY price DESC;

#c) What are the most and least expensive Italian items on the menu?

SELECT *
FROM menu_items
WHERE category = "Italian"
ORDER BY price DESC;

#d) What are the least and most expensive Mexican items on the menu?

SELECT *
FROM menu_items
WHERE category = "Mexican"
ORDER BY price DESC;

#7. What is the average dish price in each category?

SELECT category,
ROUND(AVG(price),2) AS average_price
FROM menu_items
GROUP BY category;

# Exploring order_details table

SELECT *
FROM order_details;

# 2. What is the date range of the table?

SELECT 
MIN(order_date) AS start_date, 
MAX(order_date) AS end_date
FROM order_details;

#3. How many orders were made within this date range?

SELECT
COUNT(DISTINCT order_id) as total_orders
FROM order_details;

#4. How many items were ordered within this date range?

SELECT
COUNT(order_details_id) AS num_items
FROM order_details;

#5. What is the maximum number of items per order?

SELECT order_id,
COUNT(item_id) as items_per_order
FROM order_details
GROUP BY order_id
ORDER BY items_per_order DESC;

# Analyzing Customer Behaviour

#1. Joining two tables using Joins.

SELECT *
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id;
 
 #2. What were the most ordered items? What categories were they in?

SELECT item_name, category,
COUNT(order_details_id) as total_orders,
(COUNT(order_details_id) / (SELECT COUNT(*) FROM order_details)) * 100 AS percentage_of_total_orders
FROM order_details as o
LEFT JOIN menu_items as m
 ON m.menu_item_id = o.item_id
GROUP BY item_name, category
ORDER BY total_orders DESC;
 
 #3. What were the least ordered items? What categories were they in?

SELECT item_name, category, price,
COUNT(order_details_id) AS total_orders
FROM order_details as o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY item_name,category, price
ORDER BY total_orders ASC;

#4.  What do the highest spending orders look like?  How much did they spend?

SELECT order_id,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY order_id
ORDER BY total_spend DESC;

#5. Which category of items were purchased the most by customers?

SELECT category, 
COUNT(item_id) as num_items
FROM order_details AS o
LEFT JOIN menu_items AS m
ON m.menu_item_id = o.item_id
GROUP BY category
ORDER BY num_items DESC;

#6. a) Which Asian dishes did customers spend the most on?

SELECT category,item_name,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY category,item_name
HAVING category = "Asian"
ORDER BY total_spend DESC;

#b) Which Italian dishes did customers spend the most on?

SELECT category,item_name,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY category,item_name
HAVING category = "Italian"
ORDER BY total_spend DESC;

#c) Which Mexican dishes did customers spend the most on?

SELECT category,item_name,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY category,item_name
HAVING category = "Mexican"
ORDER BY total_spend DESC;

#d) Which American dishes did customers spend the most on?

SELECT category,item_name,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY category,item_name
HAVING category = "American"
ORDER BY total_spend DESC;

#7) Which Italian dishes did customers spend the most on?

SELECT category,
COUNT(item_id) as num_items,
SUM(price) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
 ON m.menu_item_id = o.item_id
GROUP BY category
ORDER BY total_spend DESC;







