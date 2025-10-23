 Pizza Sales Analysis Project

This project demonstrates *data analysis using SQL* on a pizza sales dataset. It focuses on extracting insights such as sales trends, top-selling pizzas, category-wise revenue, and cumulative revenue over time.  

The project showcases the use of *advanced SQL concepts* like JOIN, GROUP BY, WINDOW FUNCTIONS (OVER, PARTITION BY), subqueries, and aggregate functions.


## 🛠️ Tools & Technologies
- *Database:* MySQL  
- *IDE:* MySQL Workbench (or any SQL client)  
- *Skills Applied:* SQL queries, joins, aggregations, window functions, ranking, cumulative calculations  


## 📊 Project Objectives
1. Calculate the total number of orders placed.  
2. Compute total revenue generated from pizza sales.  
3. Identify the second highest-priced pizza.  
4. Find the most common pizza size ordered.  
5. List the top 5 most ordered pizza types along with their quantities.  
6. Compute total quantity of each pizza category ordered.  
7. Analyze the distribution of orders by hour of the day.  
8. Analyze category-wise distribution of pizzas.  
9. Calculate the average number of pizzas ordered per day.  
10. Identify the top 3 pizza types based on revenue.  
11. Determine the percentage contribution of each pizza category to total revenue.  
12. Calculate cumulative revenue generated over time.  
13. Identify top 3 most ordered pizza types based on revenue for each category.  


## 📂 Project Structure
- queries.sql — Contains all SQL queries for analysis.  
- data/ — (Optional) Sample datasets if allowed.  
- screenshots/ — (Optional) Screenshots of query results or charts.  


## 🔑 Key SQL Concepts Used
- *Aggregate Functions:* SUM(), COUNT(), AVG(), ROUND()  
- *JOINs:* INNER JOIN for combining tables  
- *Subqueries:* For calculating ranks, second highest values, and percentages  
- *Window Functions:* OVER (ORDER BY ...), PARTITION BY  
- *Ranking Functions:* RANK(), ROW_NUMBER()  


## 📌 Example Queries
```sql
	Total revenue generated from pizza sales
SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_sales
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
