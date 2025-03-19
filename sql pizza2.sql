-- 1️ Retrieve the total number of orders placed.
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM table_order;

-- 2️ Calculate the total revenue generated from pizza sales.
SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- 3️ Identify the highest-priced pizza.
SELECT pizza_types.name, pizzas.price
FROM pizzas 
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC 
LIMIT 1;

-- 4️ Identify the most common pizza size ordered.
SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas 
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC 
LIMIT 1;

-- 5️ List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC 
LIMIT 5;

-- 6 Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.name,
    pizzas.pizza_type_id,
    (SUM(order_details.quantity * pizzas.price) * 100) / 
    (SELECT SUM(order_details.quantity * pizzas.price) 
     FROM pizzas 
     JOIN order_details ON pizzas.pizza_id = order_details.pizza_id) AS total_revenue_percentage
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizzas.pizza_type_id, pizza_types.name;

-- 7 Find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;
-- 8 Determine the distribution of orders by hour of the day.
SELECT HOUR(table_order.order_date) AS order_hour, COUNT(order_details.order_id) AS total_orders
FROM table_order
JOIN order_details ON table_order.order_id = order_details.order_id
GROUP BY order_hour
ORDER BY order_hour;

-- 9 Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT DATE(table_order.order_date) AS order_date, AVG(order_details.quantity) AS avg_pizzas_per_day
FROM table_order
JOIN order_details ON table_order.order_id = order_details.order_id
GROUP BY order_date
ORDER BY order_date;