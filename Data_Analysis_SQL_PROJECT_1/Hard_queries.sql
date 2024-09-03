-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category,
       ROUND(SUM(order_datails.quantity * pizzas.price) /
             (SELECT round(SUM(order_datails.quantity * pizzas.price),2) As total_Sales
              FROM order_datails
              JOIN pizzas ON pizzas.pizza_id = order_datails.pizza_id) * 100, 0) AS revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_datails ON order_datails.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- Analyze the cumulative revenue generated over time.
SELECT order_date,
       SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM (
    SELECT orders.order_date,
           SUM(order_datails.quantity * pizzas.price) AS daily_revenue
    FROM order_datails JOIN pizzas
    ON order_datails.pizza_id = pizzas.pizza_id
    join orders
    on orders.order_id = order_datails.order_id
    GROUP BY orders.order_date
) AS daily_revenue_data
ORDER BY order_date;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

