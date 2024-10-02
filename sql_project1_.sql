-- create table
create table sales(transactions_id int primary key,
				   sale_date date,
				   sale_time time,
				   customer_id int,
				   gender varchar,
				   age int,
				   category	varchar,
				   quantiy int,	
				   price_per_unit float,	
				   cogs	float,
				   total_sale float
);
-- select all columns from table
select * from sales;
-- select 10 columns from table
select * from sales limit 10;
-- select count of columns from table
select count(*) from sales;
-- Data Cleaning
-- checking the null values
select * from sales
where
transactions_id	is null
or
sale_date	is null
or
sale_time is null
or
customer_id	is null
or
gender	is null
or
age	is null
or
category is null	
or
quantiy	is null
or
price_per_unit	is null
or
cogs	is null
or
total_sale is null

-- delete columns where there are nulls
delete from sales
where
transactions_id	is null
or
sale_date	is null
or
sale_time is null
or
customer_id	is null
or
gender	is null
or
age	is null
or
category is null	
or
quantiy	is null
or
price_per_unit	is null
or
cogs	is null
or
total_sale is null

-- Data Exploration

-- How many sales we have ?
select count(*) total_sales from sales;

-- How many unique customers we have ?
select count(distinct customer_id) no_of_customers from sales;

-- what are the unique categories we have ?
select distinct category no_of_categories from sales;

-- Data Analysis key Problems and Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from sales where sale_date='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from sales where category='Clothing' and quantiy > 3 and to_char(sale_date,'yyyy-mm')='2022-11';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. 
select category,sum(total_sale) from sales group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) from sales where category = 'Beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from sales where total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender,category , count(transactions_id) from sales group by gender,category;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select year,month,avg_sale
from
(
select extract(YEAR from sale_date) as year,extract(MONTH from sale_date) as month,avg(total_sale) as avg_sale,rank() over(partition by extract(YEAR from sale_date) order by avg(total_sale)desc) as rank from sales group by 1,2
) as t1
where rank=1;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales .
select customer_id,sum(total_sale) from sales group by 1 order by 2 desc limit 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) from sales group by 1;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 & 17, Evening >17)
with CTE 
as
(select * ,
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from sales)
select shift,count(*)  total_orders from CTE  group by shift;

-- End of project
		























































































