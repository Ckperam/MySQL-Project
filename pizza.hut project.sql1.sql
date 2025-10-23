-- 1.Retrieve the total number of orders placed
select count(order_id) as Total_number_of_orders from orders
-- Calculate the total revenue generated from pizza sales.
SELECT 
    Round(SUM(order_details.quantity*pizzas.price),2) AS Total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
-- Identify the 2nd highest priced pizza
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
WHERE
    pizzas.price < (SELECT 
            max(pizzas.price)
        FROM
            pizza_types
                JOIN
            pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id)
ORDER BY pizzas.price DESC
LIMIT 1;
-- Idetify most common pizza size orderd
SELECT 
    pizzas.size, COUNT(order_details.quantity)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size;

-- list the top most ordered pizzas types along with their quantities.alter.

SELECT 
    pizza_types.name, sum(order_details.quantity) as quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name limit 5;

-- join necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    sum(order_details.quantity) AS pizza_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category order by pizza_quantity desc;
-- Determine the distributio of orders by our of the day

SELECT 
    HOUR(order_time) as hour, COUNT(order_id) as order_count
FROM
    orders
GROUP BY HOUR(order_time);
-- Join the relevant tables to find the category wise distribution of pizzas
SELECT 
    pizza_types.category, COUNT(pizza_types.name)
FROM
    pizza_types
GROUP BY category
-- Group the orders by date and calculate the average number of pizzas ordered by day.
SELECT 
    ROUND(AVG(orders_per_day), 0) AS order_avg
FROM
    (SELECT 
        orders.order_date,
            SUM(order_details.quantity) AS orders_per_day
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
 -- determine the top 3 most ordered pizza types based on revenue.
 SELECT 
    pizza_types.name,
    ROUND(SUM(pizzas.price * order_details.quantity),
            0) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
-- Calulate the percentage contribution of each pizza type to toal revenue
SELECT 
    pizza_types.category,
    ROUND(SUM(pizzas.price * order_details.quantity) * 100 / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id),
            2) AS Rev_perc
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

-- analyzethe cumulative revenue generated over time
SELECT order_date, sum(revenue) over(order by order_date) from 
(Select 
   orders.order_date,
    SUM(order_details.quantity * pizzas.price) as revenue
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY orders.order_date) as sales

-- Deternmine the top 3 most ordered pizza types based on revenue for each pizza category
SELECT category, name, revenue, rn from (select category, name, revenue, rank() over(partition by category order by revenue desc) as rn from (SELECT pizza_types.category,
    pizza_types.name,
    round(SUM(pizzas.price*order_details.quantity),2) as revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) as a) as b where rn <= 3;