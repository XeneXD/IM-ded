Create database subquery_Enad;
use orders;

select * from customer;
select * from product;
select * from orderheader;
select * from orderdetail;


-- 1. Who among the customers did not place any order?
select c.custLastName as 'Last Name', c.custFirstName as 'First Name'
from customer c
where c.custID not in (select oh.custID 
from orderheader oh);

-- 2. What is the total amount of each order placed by "Nene Wang"?
select o.orderID, 
(select sum(od.qtyOrdered * od.price)
from orderdetail od
where od.orderID = o.orderID) as 'Total Amount'
from orderheader o
join customer c on o.custID = c.custID
where c.custFirstName = 'Nene' and c.custLastName = 'Wang'
order by 'Total Amount' desc;


-- 3. Who among the customers ordered a product that belongs to category ‘C’? Sort the list according to last name in ascending order.
select c.custLastName, c.custFirstName
from customer c
where c.custID in (select o.custID
from orderheader o
join orderdetail od on o.orderID = od.orderID
join product p on od.prodID = p.prodID
where p.category = 'C')
order by c.custLastName asc, c.custFirstName asc;


-- 4. What categories have a product in which the unit price is less than the minimum  price of any product in category ‘A’? Include the count of products. Sort the list 
-- according to the count of products in ascending order.
select p.category, count(p.prodID) as 'Count of Products'
from product p
where p.uPrice < (select min(uPrice) from product where category = 'A')
group by p.category
order by count(p.prodID) asc; 



-- 5. How many pieces (total quantity) of “HP LaserJet 1102 Printer” has Nelly Co ordered?
select sum(od.qtyOrdered) as 'Total Qty Ordered'
from orderdetail od 
where od.prodID = (select p.prodID 
from product p
where p.prodName = 'HP LaserJet 1102 Printer')
 and od.orderID in (select oh.orderID
 from orderheader oh
 join customer c on oh.custID = c.custID
 where c.custFirstName = 'Nelly' and c.custLastName = 'Co');
 

-- 6. Customers who ordered more than once of any product in category ‘A’.
select concat(c.custLastName, ',',c.custFirstName) as 'Customer Name'
from customer c
where c.custID in (select oh.custID
from orderheader oh
where oh.orderID in (select od.orderID
from orderdetail od
where od.prodID in (select p.prodID
from product p 
where category = 'A'))
 group by oh.custID
 having count(oh.orderID) > 1);
