-- Basic:
-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
select 
round(sum(order_datails.quantity * pizzas.price),0) as total_Sales
from order_datails join pizzas
on pizzas.pizza_id = order_datails.pizza_id;

-- Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizzas join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by price desc
limit 2;

-- Identify the most common pizza size ordered.
select pizzas.size,count(order_datails.pizza_id) as count_order
from pizzas join order_datails
on pizzas.pizza_id = order_datails.pizza_id
group by pizzas.size order by count_order desc;
-- List the top 5 most ordered pizza types along with their quantities. 
select pizza_types.name,sum(order_datails.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_datails
on order_datails.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by quantity desc limit 5;

