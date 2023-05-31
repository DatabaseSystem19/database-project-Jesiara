--1.PL/SQL variable declaration and print value
set serveroutput on
declare 
mem_id member.mem_id%type;
username member.username%type;
email member.email%type;
begin
select mem_id,username,email into mem_id,username,email from member where mem_id=11111;
dbms_output.put_line('Mem_id: '||mem_id|| ' Username: '||username || ' Email: '||email);
end;
/

--2.Insert and set default value
set serveroutput on
declare 
mem_id member.mem_id%type:=12121;
username member.username%type:='Mim';
password member.password%type:='1234456';
email member.email%type:='mim@gmail.com';
address member.address%type:='Khulna';
phone member.phone%type:='01788355555';
begin
insert into member values(mem_id, username, password, email, address, phone);
end;
/

--3.Row type
set serveroutput on
declare 
mem_row member%rowtype;
begin
select mem_id,username,email into mem_row.mem_id,mem_row.username,mem_row.email from member where mem_id=11111;
end;
/

--4.Cursor and Row count
set serveroutput on
declare 
cursor c is select * from member;
mem_row member%rowtype;
begin
open c;
fetch c into mem_row.mem_id,mem_row.username,mem_row.password,mem_row.email,mem_row.address,mem_row.phone;
while c%found loop
dbms_output.put_line('Mem_id: '||mem_row.mem_id|| ' Username: '||mem_row.username || ' Email: '||mem_row.email);
dbms_output.put_line('Row count: '|| c%rowcount);
fetch c into mem_row.mem_id,mem_row.username,mem_row.password,mem_row.email,mem_row.address,mem_row.phone;
end loop;
close c;
end;
/
--5.with extent() function
set serveroutput on
declare 
  counter number;
  pro_name2 mobile.pro_name%type;
  TYPE NAMEARRAY IS VARRAY(5) OF mobile.pro_name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY();
begin
  counter:=1;
  for x in 10001..10003 
  loop
    select pro_name into pro_name2 from mobile where pro_id=x;
    A_NAME.EXTEND();
    A_NAME(counter):=pro_name2;
    counter:=counter+1;
  end loop;
  counter:=1;
  WHILE counter<=A_NAME.COUNT 
    LOOP 
    DBMS_OUTPUT.PUT_LINE(A_NAME(counter)); 
    counter:=counter+1;
  END LOOP;
end;
/

--6.without extend() function
set serveroutput on
declare 
  counter number;
  pro_name2 mobile.pro_name%type;
  TYPE NAMEARRAY IS VARRAY(3) OF mobile.pro_name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY('pro 1', 'pro 2', 'pro 3'); 
begin
  counter:=1;
  for x in 10001..10003 
  loop
    select pro_name into pro_name2 from mobile where pro_id=x;
    A_NAME(counter):=pro_name2;
    counter:=counter+1;
  end loop;
  counter:=1;
  WHILE counter<=A_NAME.COUNT 
    LOOP 
    DBMS_OUTPUT.PUT_LINE(A_NAME(counter)); 
    counter:=counter+1;
  END LOOP;
end;
/

--7.if-else
set serveroutput on
declare 
  counter number;
  pro_name2 mobile.pro_name%type;
  TYPE NAMEARRAY IS VARRAY(3) OF mobile.pro_name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY('pro 1', 'pro 2', 'pro 3'); 
begin
  counter:=1;
  for x in 10001..10003 
  loop
    select pro_name into pro_name2 from mobile where pro_id=x;
    if pro_name2='Oppo F19 pro+' 
        then
        dbms_output.put_line(pro_name2||' is '||'best');
      elsif pro_name2='Xiaomi Redmi Note 12'  
        then
        dbms_output.put_line(pro_name2||' is a '||'good one');
      else 
        dbms_output.put_line(pro_name2||' is '||'not so good');
        end if;
  END LOOP;
end;
/

--8.Procedure
CREATE OR REPLACE PROCEDURE proc2(
  var1 IN NUMBER,
  var2 OUT VARCHAR2,
  var3 IN OUT NUMBER
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  SELECT pro_name INTO var2 FROM mobile WHERE amount=var1;
  var3 := var1 + 1; 
  DBMS_OUTPUT.PUT_LINE(t_show || var2 || ' amount is ' || var1 || ' In out parameter: ' || var3);
END;
/



set serveroutput on
declare 
amount mobile.amount%type:=19000;
pro_name mobile.pro_name%type;
extra number;
begin
proc2(amount,pro_name,extra);
end;
/

--9.Function
set serveroutput on
create or replace function fun(var1 in varchar) return varchar AS
value member.username%type;
begin
  select username into value from member where mem_id=var1; 
   return value;
end;
/
set serveroutput on
declare 
value varchar(20);
begin
value:=fun(11111);
dbms_output.put_line(value);
end;
/