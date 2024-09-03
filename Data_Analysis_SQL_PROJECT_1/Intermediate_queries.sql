-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_datails.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_datails ON order_datails.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) as hour , count(order_id) as o_id from orders
group by hour(order_time)
order by o_id desc;

-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types
group by category;
 
-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) as Average_pizza_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_datails.quantity) AS quantity
    FROM
        orders
    JOIN order_datails ON orders.order_id = order_datails.order_id
    GROUP BY order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,
sum(order_datails.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_datails
on order_datails.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by revenue desc limit 3;

