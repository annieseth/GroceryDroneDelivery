-- CS4400: Introduction to Database Systems (Summer 2021)
-- Phase III: Stored Procedures & Views [v0] Monday, June 21, 2021 @ 2:10pm EDT

-- Team 3
-- Shyla Tolani stolani3
-- Owen Velkoff ovelkoff3
-- Annie Seth aseth42
-- Vedic Panda vpanda6

-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

drop database if exists grocery_drone_express;
create database if not exists grocery_drone_express;
use grocery_drone_express;

-- -----------------------------------------------
-- table structures
-- -----------------------------------------------

create table users (
uname varchar(40) not null,
first_name varchar(100) not null,
last_name varchar(100) not null,
address varchar(500) not null,
birthdate date default null,
primary key (uname)
) engine = innodb;

create table customers (
uname varchar(40) not null,
rating integer not null,
credit integer not null,
primary key (uname)
) engine = innodb;

create table employees (
uname varchar(40) not null,
taxID varchar(40) not null,
hired date not null,
service integer not null,
salary integer not null,
primary key (uname),
unique key (taxID)
) engine = innodb;

create table drone_pilots (
uname varchar(40) not null,
licenseID varchar(40) not null,
experience integer not null,
primary key (uname),
unique key (licenseID)
) engine = innodb;

create table floor_workers (
uname varchar(40) not null,
primary key (uname)
) engine = innodb;

create table items (
barcode varchar(40) not null,
iname varchar(100) not null,
weight integer not null,
primary key (barcode)
) engine = innodb;

create table orders (
orderID varchar(40) not null,
sold_on date not null,
purchased_by varchar(40) not null,
carrier_store varchar(40) not null,
carrier_tag integer not null,
primary key (orderID)
) engine = innodb;

create table stores (
storeID varchar(40) not null,
sname varchar(100) not null,
revenue integer not null,
manager varchar(40) not null,
primary key (storeID)
) engine = innodb;

create table drones (
storeID varchar(40) not null,
droneTag integer not null,
capacity integer not null,
remaining_trips integer not null,
pilot varchar(40) not null,
primary key (storeID, droneTag)
) engine = innodb;

create table order_lines (
orderID varchar(40) not null,
barcode varchar(40) not null,
price integer not null,
quantity integer not null,
primary key (orderID, barcode)
) engine = innodb;

create table employed_workers (
storeID varchar(40) not null,
uname varchar(40) not null,
primary key (storeID, uname)
) engine = innodb;

-- -----------------------------------------------
-- referential structures
-- -----------------------------------------------

alter table customers add constraint fk1 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table employees add constraint fk2 foreign key (uname) references users (uname)
	on update cascade on delete cascade;
alter table drone_pilots add constraint fk3 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table floor_workers add constraint fk4 foreign key (uname) references employees (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk8 foreign key (purchased_by) references customers (uname)
	on update cascade on delete cascade;
alter table orders add constraint fk9 foreign key (carrier_store, carrier_tag) references drones (storeID, droneTag)
	on update cascade on delete cascade;
alter table stores add constraint fk11 foreign key (manager) references floor_workers (uname)
	on update cascade on delete cascade;
alter table drones add constraint fk5 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table drones add constraint fk10 foreign key (pilot) references drone_pilots (uname)
	on update cascade on delete cascade;
alter table order_lines add constraint fk6 foreign key (orderID) references orders (orderID)
	on update cascade on delete cascade;
alter table order_lines add constraint fk7 foreign key (barcode) references items (barcode)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk12 foreign key (storeID) references stores (storeID)
	on update cascade on delete cascade;
alter table employed_workers add constraint fk13 foreign key (uname) references floor_workers (uname)
	on update cascade on delete cascade;

-- -----------------------------------------------
-- table data
-- -----------------------------------------------

insert into users values
('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19'),
('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28');

insert into customers values
('jstone5', 4, 40),
('sprince6', 5, 30),
('awilson5', 2, 100),
('lrodriguez5', 4, 60),
('bsummers4', 3, 110),
('cjordan5', 3, 50);

insert into employees values
('awilson5', '111-11-1111', '2020-03-15', 9, 46000),
('lrodriguez5', '222-22-2222', '2019-04-15', 20, 58000),
('tmccall5', '333-33-3333', '2018-10-17', 29, 33000),
('eross10', '444-44-4444', '2020-04-17', 10, 61000),
('hstark16', '555-55-5555', '2018-07-23', 20, 59000),
('echarles19', '777-77-7777', '2021-01-02', 3, 27000),
('csoares8', '888-88-8888', '2019-02-25', 26, 57000),
('agarcia7', '999-99-9999', '2019-03-17', 24, 41000),
('bsummers4', '000-00-0000', '2018-12-06', 17, 35000),
('fprefontaine6', '121-21-2121', '2020-04-19', 5, 20000);

insert into floor_workers values
('eross10'),
('hstark16'),
('echarles19');
 
insert into stores values
('pub', 'Publix', 200, 'hstark16'),
('krg', 'Kroger', 300, 'echarles19');

insert into employed_workers values
('pub', 'eross10'),
('pub', 'hstark16'),
('krg', 'eross10'),
('krg', 'echarles19');

insert into drone_pilots values
('awilson5', '314159', 41),
('lrodriguez5', '287182', 67),
('tmccall5', '181633', 10),
('agarcia7', '610623', 38),
('bsummers4', '411911', 35),
('fprefontaine6', '657483', 2);

insert into drones values
('pub', 1, 10, 3, 'awilson5'),
('pub', 2, 20, 2, 'lrodriguez5'),
('krg', 1, 15, 4, 'tmccall5'),
('pub', 9, 45, 1, 'fprefontaine6');

insert into items values
('pr_3C6A9R', 'pot roast', 6),
('ss_2D4E6L', 'shrimp salad', 3),
('hs_5E7L23M', 'hoagie sandwich', 3),
('clc_4T9U25X', 'chocolate lava cake', 5),
('ap_9T25E36L', 'antipasto platter', 4);

insert into orders values
('pub_303', '2021-05-23', 'sprince6', 'pub', 1),
('pub_305', '2021-05-22', 'sprince6', 'pub', 2),
('krg_217', '2021-05-23', 'jstone5', 'krg', 1),
('pub_306', '2021-05-22', 'awilson5', 'pub', 2);

insert into order_lines values
('pub_303', 'pr_3C6A9R', 20, 1),
('pub_303', 'ap_9T25E36L', 4, 1),
('pub_305', 'clc_4T9U25X', 3, 2),
('pub_306', 'hs_5E7L23M', 3, 2),
('pub_306', 'ap_9T25E36L', 10, 1),
('krg_217', 'pr_3C6A9R', 15, 2);

-- -----------------------------------------------
-- stored procedures and views
-- -----------------------------------------------

-- add customer
delimiter // 
create procedure add_customer
	(in ip_uname varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500),
    in ip_birthdate date, in ip_rating integer, in ip_credit integer)
sp_main: begin
	if ip_uname in (select uname from users) then leave sp_main; end if;
	INSERT into users VALUES(ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
    INSERT into customers VALUES(ip_uname, ip_rating, ip_credit);
end //
delimiter ;

-- add drone pilot
delimiter // 
create procedure add_drone_pilot
	(in ip_uname varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500),
    in ip_birthdate date, in ip_taxID varchar(40), in ip_hired date,
    in ip_service integer, in ip_salary integer, in ip_licenseID varchar(40),
    in ip_experience integer)
sp_main: begin
	if ip_uname in (select uname from drone_pilots) 
    OR ip_taxID in (select licenseID from drone_pilots) 
    OR ip_taxID in (select taxID from employees) then leave sp_main; end if;
    INSERT INTO users VALUES(ip_uname, ip_first_name, ip_last_name, ip_address, ip_birthdate);
	INSERT INTO employees VALUES(ip_uname, ip_taxID, ip_hired, ip_service, ip_salary); 
    INSERT INTO drone_pilots VALUES(ip_uname, ip_licenseID, ip_experience);
end //
delimiter ;

-- add item
delimiter // 
create procedure add_item
	(in ip_barcode varchar(40), in ip_iname varchar(100),
    in ip_weight integer)
sp_main: begin
	if ip_barcode in (select barcode from items) then leave sp_main; end if;
	INSERT INTO items VALUES(ip_barcode, ip_iname, ip_weight);
end //
delimiter ;

-- add drone
delimiter // 
create procedure add_drone
	(in ip_storeID varchar(40), in ip_droneTag integer,
    in ip_capacity integer, in ip_remaining_trips integer,
    in ip_pilot varchar(40))
sp_main: begin
	if ip_pilot in (select pilot from drones) 
	OR ip_storeID NOT in (select storeID from stores) 
    OR ip_droneTag in (select droneTag from drones where storeID = ip_storeID) 
    then leave sp_main; end if;
    INSERT INTO drones VALUES(ip_storeID, ip_droneTag, ip_capacity, ip_remaining_trips, ip_pilot);
end //
delimiter ;

-- increase customer credits
delimiter // 
create procedure increase_customer_credits
	(in ip_uname varchar(40), in ip_money integer)
sp_main: begin
	if ip_money < 0 then leave sp_main; end if;
	update customers set credit = credit + ip_money where uname = ip_uname;
end //
delimiter ;

-- swap drone control
delimiter // 
create procedure swap_drone_control
	(in ip_incoming_pilot varchar(40), in ip_outgoing_pilot varchar(40))
sp_main: begin
	if ip_incoming_pilot not in (select uname from drone_pilots) or ip_incoming_pilot in (select pilot from drones) 
    or ip_outgoing_pilot not in (select pilot from drones) then leave sp_main; end if;
	update drones set pilot = ip_incoming_pilot where pilot = ip_outgoing_pilot;
end //
delimiter ;

-- repair and refuel a drone
delimiter // 
create procedure repair_refuel_drone
	(in ip_drone_store varchar(40), in ip_drone_tag integer,
    in ip_refueled_trips integer)
sp_main: begin
	if ip_refueled_trips < 0 then leave sp_main; end if;
	update drones set remaining_trips = remaining_trips + ip_refueled_trips where storeID = ip_drone_store
    and droneTag = ip_drone_tag;
end //
delimiter ;

-- begin order
delimiter // 
create procedure begin_order
	(in ip_orderID varchar(40), in ip_sold_on date,
    in ip_purchased_by varchar(40), in ip_carrier_store varchar(40),
    in ip_carrier_tag integer, in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
	if ip_purchased_by not in (select uname from customers) or ip_orderID in (select orderID from orders) or
    (ip_carrier_store, ip_carrier_tag) not in (select storeID, droneTag from drones) or ip_barcode not in 
    (select barcode from items) then leave sp_main; end if;
    if ip_price < 0 or ip_quantity <= 0 then leave sp_main; end if;
    if (select credit from customers where uname = ip_purchased_by) < ip_price then leave sp_main; end if;
    if (select capacity from drones where (storeID, droneTag) = (ip_carrier_store, ip_carrier_tag)) <
    (ip_quantity * (select weight from items where barcode = ip_barcode)) 
    + (select curr_weight_carrying from (select carrier_store, carrier_tag, sum(curr_weight_carrying) as curr_weight_carrying from (select orderID, sum(quantity*weight) as curr_weight_carrying 
	from order_lines join items on order_lines.barcode = items.barcode group by orderID) as tableQ 
	join orders on tableQ.orderID = orders.orderID group by carrier_store, carrier_tag) as tableR 
	where carrier_store = ip_carrier_store AND carrier_tag = ip_carrier_tag) then leave sp_main; end if;
	insert into orders values(ip_orderID, ip_sold_on, ip_purchased_by, ip_carrier_store, ip_carrier_tag);
    insert into order_lines values(ip_orderID, ip_barcode, ip_price, ip_quantity);
end //
delimiter ;

-- add order line
delimiter // 
create procedure add_order_line
	(in ip_orderID varchar(40), in ip_barcode varchar(40),
    in ip_price integer, in ip_quantity integer)
sp_main: begin
	if ip_orderID NOT in (select orderID from orders) OR ip_barcode NOT IN
	(SELECT barcode FROM items) then leave sp_main; end if;
    if (ip_orderID, ip_barcode) in (select orderID, barcode from order_lines) then leave sp_main; end if;
    if ip_price < 0 OR ip_quantity <= 0 then leave sp_main; end if;
    if (SELECT credit FROM customers WHERE uname = (SELECT purchased_by FROM orders WHERE orderID = ip_orderID)) 
    < ((SELECT sum(quantity * price) FROM order_lines WHERE orderID = ip_orderID) +
    ip_price * ip_quantity) then leave sp_main; end if;
	if (select capacity from drones where (droneTag, storeID) in 
    (SELECT carrier_tag, carrier_store FROM orders where orderID = ip_orderID)) < (((SELECT weight
	FROM items WHERE barcode = ip_barcode) * ip_quantity) + (select sum(quantity * weight) from items join order_lines
    on items.barcode = order_lines.barcode where orderID in (SELECT orderID FROM orders 
    WHERE (carrier_store, carrier_tag) IN (SELECT carrier_store, carrier_tag FROM orders WHERE orderID = ip_orderID))))
    then leave sp_main; end if;
	INSERT INTO order_lines VALUES(ip_orderID, ip_barcode, ip_price, ip_quantity);
end //
delimiter ;

-- deliver order
delimiter // 
create procedure deliver_order
	(in ip_orderID varchar(40))
sp_main: begin
	if ip_orderID not in (select orderID from orders) then leave sp_main; 
	end if;
	if (select remaining_trips from drones where (storeID, droneTag) in (select carrier_store, carrier_tag 
    from orders where ip_orderID = orders.orderId)) < 1 then leave sp_main; end if;
    update drones set remaining_trips = remaining_trips - 1 where (storeID, dronetag) in (select carrier_store, carrier_tag
    from orders where ip_orderID = orders.orderID);
	update drone_pilots set experience = experience + 1 where uname in (select pilot from drones
    where (storeID, droneTag) in (select carrier_store, carrier_tag from orders where ip_orderID = orders.orderID));
    update stores set revenue = revenue + (select sum(quantity * price) from order_lines where ip_orderID = order_lines.orderID)
    where storeID = (select carrier_store from orders where ip_orderID = orders.orderID);
	update customers set credit = credit - (select sum(quantity * price) from order_lines where ip_orderID = order_lines.orderID)
    where uname = (select purchased_by from orders where ip_orderID = orders.orderID);
	if (select sum(quantity * price) from order_lines where ip_orderID = order_lines.orderID) > 25 and 
    (select rating from customers where uname = (select purchased_by from orders where ip_orderID = orders.orderID)) < 5
    then update customers set rating = rating + 1 where uname = (select purchased_by from orders where ip_orderID = orders.orderID); 
	end if;
	delete from orders where ip_orderID = orders.orderID ;
end //
delimiter ;

-- cancel an order
delimiter // 
create procedure cancel_order
	(in ip_orderID varchar(40))
sp_main: begin
	if ip_orderID not in (select orderID from orders) then leave sp_main; end if;
	update customers set rating = rating - 1 where uname in (select purchased_by from orders where orderID = ip_orderID) and rating > 1;
	delete from orders where orderID = ip_orderID;
	delete from order_lines where orderID = ip_orderID;
end //
delimiter ;

-- display persons distribution across roles
create or replace view role_distribution (category, total) as
select "users" as category, count(*) as total from users union 
select "customers" as category, count(*) as total from customers union 
select "employees" as category, count(*) as total from employees union 
select "customer_employer_overlap" as category, count(*) as total from employees inner join customers where customers.uname = employees.uname union 
select "drone_pilots" as category, count(*) as total from drone_pilots union 
select "floor_workers" as category, count(*) as total from floor_workers union 
select "other_employee_roles" as category, count(*) as total from employees where uname not in (select uname from drone_pilots union select uname from floor_workers); 


-- display customer status and current credit and spending activity
create or replace view customer_credit_check (customer_name, rating, current_credit,
	credit_already_allocated) as
-- replace
select uname, rating, credit, ifnull(sum(price * quantity), 0) from customers left join orders on uname = purchased_by
left join order_lines on orders.orderID = order_lines.orderID group by uname;

-- display drone status and current activity
create or replace view drone_traffic_control (drone_serves_store, drone_tag, pilot,
	total_weight_allowed, current_weight, deliveries_allowed, deliveries_in_progress) as
select drones.storeID as drone_serves_store, drones.droneTag as drone_tag, drones.pilot as pilot,
drones.capacity as total_weight_allowed, ifnull(current_carrying_weight, 0) as current_weight, remaining_trips as deliveries_allowed, ifNull(currDeliveries, 0) as deliveries_in_progress from drones
left join
(select tableZ.carrier_store, tableZ.carrier_tag, currDeliveries, current_carrying_weight from (select carrier_tag, carrier_store, sum(total_weight) as current_carrying_weight 
from (select orderID, sum(total_weight) as total_weight from (select orderID, order_lines.barcode, (order_lines.quantity * items.weight) as total_weight 
from order_lines join items 
on order_lines.barcode = items.barcode) as tableA group by orderID) as tableB 
join orders on tableB.orderID = orders.orderID group by carrier_tag, carrier_store) as tableC 
join 
(select carrier_store, carrier_tag, sum(numDeliveries) as currDeliveries from (select tableX.orderID, carrier_store, carrier_tag, numDeliveries from (select order_lines.orderID, count(distinct order_lines.orderID) as numDeliveries from order_lines join items 
on order_lines.barcode = items.barcode group by order_lines.orderID) as tableX join orders on tableX.orderID = orders.orderID) as tableY group by carrier_store, carrier_tag) as tableZ on tableC.carrier_tag = tableZ.carrier_tag AND tableC.carrier_store = tableZ.carrier_store) 
as tableFinal ON drones.storeID = tableFinal.carrier_store AND drones.droneTag = tableFinal.carrier_tag;

-- display item status and current activity including most popular items
create or replace view most_popular_items (barcode, item_name, weight, lowest_price,
	highest_price, lowest_quantity, highest_quantity, total_quantity) as
SELECT items.barcode, iname, weight, min(price) as lowest_price, max(price) as highest_price, COALESCE(min(quantity), 0) as lowest_quantity, COALESCE(max(quantity), 0) as highest_quantity, COALESCE(sum(quantity), 0) as total_quantity 
FROM grocery_drone_express.order_lines right join items on order_lines.barcode = items.barcode group by barcode;

-- display drone pilot status and current activity including experience
create or replace view drone_pilot_roster (pilot, licenseID, drone_serves_store,
	drone_tag, successful_deliveries, pending_deliveries) as
select uname, licenseID, storeID, droneTag, experience, count(orderID) from drone_pilots left join drones on uname = pilot
left join orders on (storeID, droneTag) = (carrier_store, carrier_tag) group by uname;
# 34

-- display store revenue and activity
create or replace view store_sales_overview (store_id, sname, manager, revenue,
	incoming_revenue, incoming_orders) as
select storeID, sname, manager, revenue, sum(price * quantity), count(distinct orders.orderID) from stores left join orders on storeID = carrier_store
left join order_lines on orders.orderID = order_lines.orderID group by storeID;
# 35

-- display the current orders that are being placed/in progress
create or replace view orders_in_progress (orderID, cost, num_items, payload,
	contents) as
select orders.orderID, sum(price*quantity) as cost, count(items.barcode) as num_items, 
sum(weight * quantity) as payload, GROUP_CONCAT(iname) as content from orders join order_lines on orders.orderID = order_lines.orderID 
join items on order_lines.barcode = items.barcode group by orderID; 

-- remove customer
delimiter // 
create procedure remove_customer
	(in ip_uname varchar(40))
sp_main: begin
	if ip_uname in (select purchased_by from orders) then leave sp_main; end if;
	delete from customers where uname = ip_uname;
    if ip_uname in (select uname from employees) then leave sp_main; end if;
    delete from users where uname = ip_uname;
end //
delimiter ;

-- remove drone pilot
delimiter // 
create procedure remove_drone_pilot
	(in ip_uname varchar(40))
sp_main: begin
	if ip_uname in (select pilot from drones) then leave sp_main; end if;
    delete from employees where uname = ip_uname;
    if ip_uname in (select uname from customers) then leave sp_main; end if;
    delete from users where uname = ip_uname;
end //
delimiter ;

-- remove item
delimiter // 
create procedure remove_item
	(in ip_barcode varchar(40))
sp_main: begin
	if ip_barcode in (select barcode from order_lines) then leave sp_main; end if;
	delete from items where barcode = ip_barcode;
end //
delimiter ;

-- remove drone
delimiter // 
create procedure remove_drone
	(in ip_storeID varchar(40), in ip_droneTag integer)
sp_main: begin
	if (ip_storeID, ip_droneTag) in (select carrier_store, carrier_tag from orders) then leave sp_main; end if;
	delete from drones where storeID = ip_storeID and droneTag = ip_droneTag;
end //
delimiter ;

