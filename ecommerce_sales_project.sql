-- ------create database------------------------------------- 

create database ecommerce_project;

-- -----create table-------------------------------------------- 
create table customers(
c_id int primary key,
cust_name varchar(100),
city varchar(50),
state varchar(50),
signup_date date
);

--  -------insert values----------------------------------------
insert into customers(c_id,cust_name,city,state,signup_date)
values(1, 'dnyaneshwari','ahilyanagar','maharastra','2026-01-27'),
(2, 'Priya Patil', 'Mumbai', 'Maharashtra', '2025-02-15'),
(3, 'Rahul Singh', 'Delhi', 'Delhi', '2025-03-20'),
(4, 'Sneha Joshi', 'Ahilyanagar', 'Maharashtra', '2025-04-05'),
(5, 'Rohan Mehta', 'Nashik', 'Maharashtra', '2025-04-12'),
(6, 'Neha Kulkarni', 'Pune', 'Maharashtra', '2025-05-18'),
(7, 'Arjun Desai', 'Bengaluru', 'Karnataka', '2025-06-01'),
(8, 'Pooja Shah', 'Surat', 'Gujarat', '2025-06-15'),
(9, 'Karan Verma', 'Delhi', 'Delhi', '2025-07-10'),
(10, 'Anjali More', 'Mumbai', 'Maharashtra', '2025-08-22'),
(11, 'anushree','pune','maharastra','2026-09-07');

select * from customers;

select count(*) as total_customers
from customers;

create table products(
                        product_id int primary key ,
						product_name varchar(100),
						category varchar(50),
						price decimal(10,2)
);


insert into products(product_id,product_name,category,price)
values
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Electronics', 800),
(103, 'Headphones', 'Electronics', 2500),
(104, 'T-Shirt', 'Fashion', 999),
(105, 'Shoes', 'Fashion', 2499),
(106, 'Smartphone', 'Electronics', 25000),
(107, 'Watch', 'Accessories', 3500),
(108, 'Backpack', 'Accessories', 1800),
(109, 'Jeans', 'Fashion', 1999),
(110, 'Keyboard', 'Electronics', 1500),
(111,'Rings','Fasion',1600);

select * from products;

select count(*) as total_products
from products;

-- -------top five expensive produts------------------------------------------
select product_name , price
from products
order by price desc
limit 5;

create table orders(
					 order_id int primary key ,
                     c_id int ,
                     order_date date,
                     payment_method varchar(60),
                     order_status varchar(60),
					 foreign KEY (c_id) 
                       references customers(c_id)
                     );


insert into orders(order_id,c_id, order_date , payment_method , order_status)
values
(1001, 1, '2025-09-01', 'UPI', 'Delivered'),
(1002, 2, '2025-09-02', 'Card', 'Delivered'),
(1003, 3, '2025-09-05', 'Cash', 'Shipped'),
(1004, 1, '2025-09-07', 'UPI', 'Delivered'),
(1005, 4, '2025-09-10', 'Card', 'Cancelled'),
(1006, 5, '2025-09-12', 'UPI', 'Delivered'),
(1007, 6, '2025-09-15', 'Card', 'Shipped'),
(1008, 2, '2025-09-18', 'UPI', 'Delivered'),
(1009, 7, '2025-09-20', 'Cash', 'Delivered'),
(1010, 8, '2025-09-22', 'Card', 'Processing'),
(1011, 3, '2025-09-25', 'UPI', 'Delivered'),
(1012, 9, '2025-09-27', 'Card', 'Shipped'),
(1013, 10, '2025-10-01', 'UPI', 'Delivered'),
(1014, 4, '2025-10-03', 'Cash', 'Delivered'),
(1015, 1, '2025-10-05', 'Card', 'Processing');

select * from orders;

select count(*) as total_orders
from orders;

-- count order status-----------------------------------------------

select order_status,
count(*) as total_orders
from orders 
group by order_status
order by total_orders desc;


-- -------------------------------------------------

create table order_items(
							order_item_id int primary key,
                            order_id int,
                            product_id int ,
                            quantity int ,
                            foreign key (order_id)
                            references orders(order_id),
                            foreign key (product_id)
                            references products(product_id)
                            );
insert into order_items (order_item_id,order_id,product_id,quantity)
values
(1, 1001, 101, 1),
(2, 1001, 102, 2),
(3, 1002, 104, 3),
(4, 1002, 105, 1),
(5, 1003, 103, 1),
(6, 1003, 110, 1),
(7, 1004, 106, 1),
(8, 1004, 102, 1),
(9, 1005, 109, 2),
(10, 1006, 105, 2),
(11, 1007, 107, 1),
(12, 1008, 104, 2),
(13, 1008, 108, 1),
(14, 1009, 106, 1),
(15, 1010, 108, 2),
(16, 1011, 103, 2),
(17, 1012, 109, 1),
(18, 1013, 101, 1),
(19, 1014, 104, 1),
(20, 1015, 110, 2);

select * from order_items;
select count(*) as total_items
from order_items;

select quantity ,
count(*) as total_items
from order_items
group by quantity
order by order_items
limit 6;

-- calculate revenue for each order item--------------------------------

SELECT
    oi.order_id,
    p.product_name,
    p.price,
    oi.quantity,
    p.price * oi.quantity AS item_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id;
    
    
--    total revenue----------------------------------------

select  
	sum(p.price*oi.quantity)as total_revenue
    from order_items oi
    join products p
       on oi.product_id=p.product_id;
       
--  total quantity sold----------------------------------------- 
       
     
select count(*)as total_quantity_sold
from order_items;

select count(*) as total_orders
from orders;


-- calculate average order value-------------------------------------------------- 
select 
		sum(p.price*oi.quantity)/count(distinct oi.order_id) as avg_order_value
        from order_items oi
		join products p
        on oi.product_id=p.product_id;
        
    
    
-- top selling products------------------------------

select 
p.product_name,
sum(oi.quantity)as total_quantity
from order_items oi
join products p
on oi.product_id=p.product_id
group by product_name
order by total_quantity desc
limit 5;


-- top5 highest revenue products---------------------

select 	
		p.product_name,
        sum(p.price*oi.quantity) as total_revenue
        from order_items oi
        join products p
        on oi.product_id=p.product_id
        group by product_name
        order by total_revenue desc
        limit 5;
        
--  quantity sold by category-------------------------------

select p.category,
       sum(oi.quantity) as total_quantity_sold
       from order_items oi
       join products p
       on oi.product_id=p.product_id
       group by p.category
       order by total_quantity_sold desc;
  
-- revenue by category--------------------------------- 
SELECT
    p.category,
    count(distinct p.product_id) as number_of_products,
    sum(oi.quantity)as total_quantity,
    sum(p.price*oi.quantity)as total_revenue
    from order_items oi
    join products p
    on oi.product_id=p.product_id
    group by p.category
    order by total_revenue desc;
    
    
select * from products;


SELECT
    category,
    COUNT(*) AS number_of_products
FROM products
GROUP BY category
ORDER BY number_of_products DESC;

    -- ----------------------------customer analysis-------------------------------------------------------- 
    
select count(*) as total_cus
from customers;
--   total orders from each customer ------------------------------------------------- 
select 
c.c_id,
c.cust_name,
count(o.order_id)as total_orders
from customers c
left join orders o
on c.c_id=o.c_id
group by c.c_id,c.cust_name
order by total_orders desc;

--   highest spending 5 customer names ------------------------------- 
select
       c.c_id,
       c.cust_name,
       sum(oi.quantity*p.price)as total_spending
       from customers c
       join orders o
            on c.c_id=o.c_id
       join order_items oi
            on o.order_id=oi.order_id
		join products p
            on oi.product_id=p.product_id
		group by c.c_id ,c.cust_name
        order by total_spending desc
        limit 5;
       
-- repeated customers-----------------------

select 
		c.c_id,
        c.cust_name,
        count(o.order_id)as total_orders
        from customers c
        join orders o
        on c.c_id=o.c_id
        join order_items oi
        on o.order_id=oi.order_id
        join products p 
        on oi.product_id=p.product_id
        group by c.c_id,c.cust_name
        having count(o.order_id)>1
        order by total_orders desc ;
        
-- now calculate total spending and orders--------------------------------------------

select 
		c.c_id,
        c.cust_name,
        count(distinct o.order_id) as total_orders,
        sum(oi.quantity)as total_items_purcased,
        sum(oi.quantity*p.price)as total_spending
        from    customers c
join    orders o
on     c.c_id=o.c_id
join    order_items oi
on     o.order_id=oi.order_id
join   products p 
on     oi.product_id=p.product_id

group by c.c_id,c.cust_name
 order by total_spending desc;    
        
        
-- ------------ customer who never ordered------------------------------

select c.c_id, c.cust_name
from customers c
left join orders o
on c.c_id=o.c_id
where o.order_id is null;

--   customer order segmentation -------------------------------------------

select c.c_id ,c.cust_name,
       count(o.order_id)as total_orders,
       case 
            when count(o.order_id)>=3 then'high value'
		    when count(o.order_id)=2 then'medium'
		    when count(o.order_id)=1 then 'new customer'
            else 'no order'
		end as customer_segment
from customers c
left join orders o 
on c.c_id=o.c_id
group by c.c_id,c.cust_name
order by total_orders desc;


-- --------------- order analysis ------------------------------------------------
-- calculate total orders by status-----------------------------------------------

select 
order_status ,
count(*)as total_orders
from orders
group by order_status
order by total_orders desc;

--  calculate percentage of each order

select order_status,
       count(*)as total_orders,
       round(count(*)*100.0/(select count(*)from orders),2)as percentage
       from orders
       group by order_status
       order by total_orders desc;
       
-- calculate the revenue by order_status--------------------------------------------------------

select order_status,
       sum(oi.quantity*p.price)as total_revenue
       from orders o
       join order_items oi
      on  o.order_id=oi.order_id
      join products p 
      on oi.product_id=p.product_id
      group by order_status
      order by total_revenue desc;
 
 --  cancelled order analysis------------------------
 
 select o.order_status,
		o.payment_method,
        o.order_id,
        o.order_date,
        c.cust_name
from orders o
join customers c
on o.c_id=c.c_id
where o.order_status='cancelled'

--  cancelled order revenue ---------------------------------------

select 
       sum(oi.quantity*p.price)as cancelled_value
       from orders o
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       where o.order_status='cancelled'; 
       
--  delivered or cancelled order with revenue----------------------------------------

select
      order_status,
      
      count(distinct o.order_id)as total_orders,
      sum(oi.quantity*p.price)as total_revenue
      from orders o
      join order_items oi
      on o.order_id=oi.order_id
      join products p
      on oi.product_id=p.product_id
      where order_status in('Delivered','cancelled')
      group by order_status
      order by total_orders desc;
       
--  sales analysis----------------------------------------

select date_format(order_date,'%y-%m')as month,
       count(*)as total_orders
       from orders
       group by date_format(order_date,'%y-%m')
       order by month;
       
--  monthly revenue analysis--------------------------------

select date_format(o.order_date,'%y-%m')as month,
	   count(distinct o.order_id)as total_orders,
       sum(oi.quantity * p.price)as total_revenue
       from orders o
       join order_items oi
       on o.order_id=oi.order_id
       join products p 
       on oi.product_id=p.product_id
       group by date_format(o.order_date,'%y-%m')
       order by month;
       
       
-- total average value by month----------------------------------

select date_format(o.order_date,'%y-%m')as month,
	   count(distinct o.order_id)as total_orders,
       sum(oi.quantity * p.price) as total_revenue,
       round(sum(oi.quantity * p.price)/count(distinct o.order_id),2)as total_average_value
	   from orders o
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by date_format(o.order_date,'%y-%m')
       order by month;
       
       
-- ----------------payment method analysis------------------------------------------------------------------
-- 1. which payment method is used for the highest number of order-----------------------------------------

select payment_method,
       count(*)as total_orders 
       from orders
       group by payment_method
       order by total_orders desc;


-- 2. revenue by payment method-------------------------------------------------------------

select o.payment_method,
       sum(oi.quantity * p.price)as total_revenue
       from orders o
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by o.payment_method
       order by total_revenue desc;
       
-- 3. Payment Method with Orders and Revenue and Percentage-------------------------------------

select o.payment_method ,
       count(distinct o.order_id)as total_orders,
       sum(oi.quantity * p.price)as total_revenue,
       round(count(*)*100.0/ (select count(*)from orders) ,2)as percentage
       from orders o
       join order_items oi
       on o.order_id = oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by o.payment_method
       order by total_revenue desc;
       
-- -------------customer location analysis---------------------------------------------------
-- 1. cities with highest customer base ------------------------------------

select city,
       count(*)as total_customers 
       from customers
       group by city
       order by total_customers desc;
       
-- 2. customers by state 

select state,
       count(*)as total_customers
       from customers
       group by state 
       order by total_customers desc;
       
-- 3. revenue by customer state---------------------------------------

 select c.state,
        sum(oi.quantity * p.price)as total_revenue
        from customers c
        join orders o
        on c.c_id=o.c_id
        join order_items oi
        on o.order_id=oi.order_id
        join products p
        on oi.product_id=p.product_id
        group by c.state
        order by total_revenue desc;
        
-- 4. top revenue generating city ----------------------------------------

select c.city,
       sum(oi.quantity *p.price)as total_revenue
       from customers c
       join orders o
       on c.c_id=o.c_id
       join order_items oi
       on o.order_id=oi.order_id
       join products p 
       on oi.product_id=p.product_id
       group by c.city
       order by total_revenue desc;
       
-- 5. the spending of each customer within their city------------------------------

select c.city,
       c.cust_name,
       sum(oi.quantity*p.price)as total_spending
       from customers c
       join orders o
       on c.c_id=o.c_id
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by c.city,c.cust_name
       order by total_spending desc;
       
-- -----------------------------Advanced Customer Analysis--------------------------------------------- 
-- 1. Find the Highest-Spending Customer--------------------------------------------------- 

select c.c_id,c.cust_name,
       sum(oi.quantity * p.price) as total_spending
       from customers c
       join orders o 
       on c.c_id=o.c_id
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by c.c_id,c.cust_name
       order by total_spending desc
       limit 1;

-- 2. Customers Spending Above Average using a subquery------------------------------------

 select c.c_id,c.cust_name,
       sum(oi.quantity * p.price) as total_spending
       from customers c
       join orders o 
       on c.c_id=o.c_id
       join order_items oi
       on o.order_id=oi.order_id
       join products p
       on oi.product_id=p.product_id
       group by c.c_id,c.cust_name
having sum(oi.quantity * p.price)>( select avg(customer_spending) from
       ( select o.c_id,
       sum(oi.quantity *p.price)as customer_spending
       from customers c
       join orders o
       on c.c_id=o.c_id
       join order_items oi
       on o.order_id=oi.order_id
       join products p 
       on oi.product_id=p.product_id
       group by o.c_id)as customer_totals)
order by total_spending desc;

-- 3.identify the most purchased product----------------------------------

select p.product_id,
       p.product_name,
       sum(oi.quantity)as total_quantity_sold
       from products p
       join order_items oi
       on p.product_id=oi.product_id
       group by p.product_id,p.product_name
	   order by total_quantity_sold desc
       limit 1;
       
-- 4. most revenue generting product

select p.product_id,
       p.product_name,
       sum(oi.quantity *p.price)as total_revenue
       from products p
       join order_items oi
       on p.product_id=oi.product_id
       group by p.product_id,p.product_name
       order by total_revenue desc
       limit 1;
       
-- 5. Products That Have Never Been Sold---------------------
 
 select p.product_id,
        p.product_name,
        p.price,
        p.category
        from products p
        left join order_items oi
        on p.product_id=oi.product_id
        where oi.product_id is null;
        
-- 6. find which products generate less revenue than the average product revenue (subquary)----------------------- 

select p.product_id,p.product_name,
       sum(oi.quantity * p.price)as total_revenue
       from products p
       join order_items oi
       on p.product_id=oi.product_id
       group by p.product_id,p.product_name
       having sum(oi.quantity*p.price)< (select avg(product_revenue)
       from (select oi.product_id,
					sum(oi.quantity*p.price)as product_revenue
                    from products p
                    join order_items oi
                    on p.product_id=oi.product_id
                    group by oi.product_id
                    )as product_totals)
		order by total_revenue asc;
        
--  8. rank products from highest revenue to lowest revenue---------------------------------------------

select p.product_id , p.product_name,
       sum(oi.quantity*p.price)as total_revenue,
       Rank() over(
                    order by sum(oi.quantity*p.price)desc)as revenue_rank
	   from products p
       join order_items oi
       on p.product_id=oi.product_id
       group by p.product_id,p.product_name
       order by revenue;
       
       
-- 9.summary---------------------------------------------------------------------------------------------

select 
	 count(distinct o.order_id)as total_orders,
     count(distinct o.c_id)as total_customers,
	 sum(oi.quantity)as total_quantity_sold,
     sum(oi.quantity*p.price)as total_revenue,
     round (sum(oi.quantity*p.price)/count(distinct o.order_id),2)as Avg_value
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id ;


-- 10. Calculate Delivered Orders Revenue--------------------------------------

select 
      count(distinct o.order_id) as delivered_orders,
      sum(oi.quantity) as total_units_sold,
      sum(oi.quantity*p.price)as delivered_revenue
      from orders o
      join order_items oi
      on o.order_id=oi.order_id
      join products p
      on oi.product_id=p.product_id
      where o.order_status='delivered'
      
-- 11. Revenue by Order Status------------------------------------------------



select  
      o.order_status,
      count(distinct o.order_id)as total_orders,
      sum(oi.quantity)as total_units,
      sum(oi.quantity *p.price)as total_value
      from orders o 
      join order_items oi
      on o.order_id=oi.order_id
      join products p
      on oi.product_id=p.product_id
      group by o.order_status
      order by total_value desc;
      
-- 12. revenue contribution percentage by category----------------------------------------

select 
      p.category,
      sum(oi.quantity*p.price) as category_revenue,
      round( sum(oi.quantity*p.price)/
      (select sum(oi2.quantity*p2.price)
      from order_items oi2
      join products p2
      on oi2.product_id=p2.product_id)*100,2
      )as revenue_percentage
      from order_items oi
      join products p 
      on oi.product_id=p.product_id
      group by p.category
      order by category_revenue desc ;