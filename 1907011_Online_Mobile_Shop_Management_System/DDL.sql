create table member(
	mem_id number(5) check(length(mem_id)=5) not null primary key,
	username varchar(50) not null,
    password varchar(20) check(length(password)>=6) not null,
    email varchar(50) unique not null,
    address varchar(50),
    phone varchar(11) check(length(phone)=11) not null
    );


create table mobile(
	pro_id number(5) check(length(pro_id)=5) not null primary key,
	pro_name varchar(50) not null,
	pro_model number(10) not null,
	pro_desc varchar(450),
	amount number(30) not null,
	color varchar(20));

create table rating(
	rating_id number(4) check(length(rating_id)=4) not null primary key,
	mem_id number(5) check(length(mem_id)=5) not null,
	pro_id number(5) check(length(pro_id)=5) not null,
	value number(2,1) not null,
	foreign key(mem_id) references member(mem_id) on delete cascade,
	foreign key(pro_id) references mobile(pro_id) on delete cascade);


create table cart(
	cart_id number(4) check(length(cart_id)=4) not null primary key,
	mem_id number(5) check(length(mem_id)=5) not null,
	pro_id number(5) check(length(pro_id)=5) not null,
	quantity number not null,
	foreign key(mem_id) references member(mem_id) on delete cascade,
	foreign key(pro_id) references mobile(pro_id) on delete cascade);


create table transaction(
	transaction_id number(4) check(length(transaction_id)=4) not null primary key,
	mem_id number(5) check(length(mem_id)=5) not null,
	cart_id number(4) check(length(cart_id)=4) not null,
	payment_amount number(20) not null,
	payment_date DATE not null,
	foreign key(mem_id) references member(mem_id) on delete cascade,
	foreign key(cart_id) references cart(cart_id) on delete cascade);


--1.add column
alter table member add name char(20);
--2.modify column
alter table member modify name varchar(50);
--3.rename column
alter table member rename column name to fullname;
--4.delete column
alter table member drop column fullname;


