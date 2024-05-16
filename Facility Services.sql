create database Facility_Services;

use Facility_Services;

select * from customermaster;
select * from employee_master;
select * from locationmaster;
select * from pricemaster;
select * from productmaster;
select * from transactionmaster;



'Added New Columns for Dates'

alter table employee_master
add Hire_DT Date,
add Last_DT Date;

update employee_master
set Hire_DT =str_to_date(Hire_Date,'%Y-%c-%d');

  'Set Empty CELLS to Today s Date'
  
update employee_master
SET Last_Date_Worked = current_date()
where Last_Date_Worked =""; 
           
'Added New Columns for Dates' 

alter table transactionmaster
add Service_DT Date,
add Invoice_DT Date;

update transactionmaster
set Service_DT=Service_Date;

update transactionmaster
set Invoice_DT=Invoice_Date;


                                          ''EXERCISE	1:	COMPARISON	OPERATOR	QUERIES''

'1. From	the	TransactionMaster	table,	select	a	list	of	all	items	purchased	for	
Customer_Number	296053.	Display	the	Customer_Number,Product_Number,	and	Sales_Amount	for	this	customer.'

select Product_number from transactionmaster 
where customer_number = 296053;

select * from transactionmaster 
where customer_number = 296053;


'2. Select	all	columns	from	the LocationMaster table	for	transactions	made in the	Region	=	NORTH.'

select * from locationmaster
where region="North";


'3. Select	the	distinct	products in	the	TransactionMaster	table.	In	other words,	display	a	listing	of	each	of	the	unique	products 
from	the	TransactionMaster table.'

select distinct(Product_number) from transactionmaster ; 

'4. List	all	the	Customers	without	duplication.'

select distinct(customer_number) from customermaster;

                                            
                                            'EXERCISE	2:	AGGREGATE	FUCNTION	QUERIES'

'1. Find	the	average	Sales	Amount	for	Product	Number	30300	in	Sales	Period	
P03.'

select avg(sales_amount) from transactionmaster
where product_number="30300";

'2. Find	the	maximum	Sales	Amount	amongst	all	the	transactions.'

select max(sales_amount) from transactionmaster;

'3. Count	the	total	number	of	transactions	for	each	Product	Number	and	 display	in	descending	order.'

select product_number,count(product_number) as PD_count from transactionmaster
group by product_number
order by (PD_count)desc
;

'4. List	the	total	number	of	transactions	in	Sales	Period	P02	and	P03.'

select count(invoice_number) from transactionmaster 
where sales_period="P02" OR sales_period="P03"
;

'5. What	is	the	total	number of	rows	in	the	TransactionMaster	table?'

SELECT COUNT(invoice_number) FROM transactionmaster;

'6. Look	into	the	PriceMaster	table	to	find	the	price	of	the	cheapest	product that	was	ordered.'

select product_number,price from pricemaster
order by (Price) asc
limit 1;

                                              'EXERCISE	3:	LIKE	FUNCTION	QUERIES'

'1. Select	all	Employees	where	Employee-Status	=	“A”.'

select * from employee_master
where employee_status="A";


'2. Select	all	Employees where	Job	Description	is		“TEAMLEAD	1”.'

select * from employee_master
where Job_Title="TEAMLEAD 1";

'3. List	the	Last	name,	Employee	Status	and	Job	Title	of	all	employees	whose	names	contain	 the letter	"o"	as	the	second	letter.'

select Last_name,employee_status,job_title from employee_master
where first_name like "%o%"
;

select Last_name,employee_status,job_title from employee_master
where last_name like "%o%"
;

'4. List	the	Last	name,	Employee	Status	and	Job	Title	of	all	employees	whose First names	start	with	
the	letter	"A"	and	does	not	contain	the	letter	"i".'	

select Last_name,employee_status,job_title from employee_master
where first_name like "A%" AND first_name not like "%i%"
;

'5. List	the	First	name	and	Last	names	of	employees	with	Employee	Status	“I”	whose	Job	Code	is	not	SR2	and	SR3.'

select First_Name,Last_Name,employee_status,JOB_CODE from employee_master
where employee_status="I" AND JOB_CODE NOT IN("SR2","SR3") 
;

'6. Find	out	details	of	employees	whose	last	name	ends	with	“N”	and	first	 name	begins	with	“A”	or	“D”.'

SELECT * from employee_master
where (last_name like"%N" AND first_name LIKE "A%") or (last_name like"%N" AND first_name LIKE "D%")
;

'7. Find	the	list	of		products	with	the	word	“Maintenance”	in	their	product	description.'

select * from productmaster 
where product_description like "%maintenance%" ;

                                             'EXERCISE	4:	DATE	FUNCTION	QUERIES'

'1. List	the	employees	who	were	hired	before	01/01/2000	(hint:	use	#	for	date	values).'

select * from employee_master 
where YEAR(Hire_DT) < 2000
;

'2. Find	the	total	number	years	of	employment	for all the	employees	who	have	retired.'

SELECT Employee_number,YEAR(LAST_DT)-year(Hire_DT) as Year_of_Employment from employee_master
where Last_Date_Worked <>"2024-05-16"
; 

'3. List	the	transactions,	which	were	performed	on	Wednesday	or	Saturdays.'

select * from transactionmaster
where weekDAY(Invoice_DT) = 2 or weekDAY(Invoice_DT) = 5
;

select * from transactionmaster
where weekDAY(Service_DT) = 2 or weekDAY(Service_DT) = 5
;

'4. Find	the	list	of	employees	who	are	still	working	at	the	present.'

SELECT * from employee_master
where Last_Date_Worked ="2024-05-16" ;

                                        'EXERCISE	5:	GROUP	BY	CLAUSE QUERIES'

'1. List	the	number	of	Customers	from	each	City	and State.'

select Firstofcity,count(customer_number) from customermaster
group by Firstofcity ;

select Firstofstate,count(customer_number) from customermaster
group by Firstofstate ;

'2. For	each	Sales	Period	find	the	average	Sales	Amount.'

select sales_period, avg(sales_amount) from transactionmaster
group by sales_period;

'3. Find	the	total	number	of	customers	in	each	Market.'

select LM.Market,count(distinct(TM.Customer_Number)) as total_Customers
from locationmaster as LM inner join transactionmaster as TM ON
LM.Branch_number =TM.Branch_number
GROUP BY LM.Market ;

select LM.Market,count(distinct(CM.Customer_Number)) as total_Customers
from locationmaster as LM inner join transactionmaster as TM ON
LM.Branch_number =TM.Branch_number
inner join customermaster as CM ON 
TM.Customer_number = CM.Customer_number
GROUP BY LM.Market ;

'4. List	the	number	of	customers	and	the	average	Sales	Amount	in	each Region.'

select LM.Region,count(distinct(TM.Customer_Number)) as total_Customers,avg(TM.Sales_amount)
from locationmaster as LM inner join transactionmaster as TM ON
LM.Branch_number =TM.Branch_number
GROUP BY LM.Region ;


'5. From	the	TransactionMaster table,	select	the	Product	number,	maximum	price,	and	minimum	price	for	each	specific	
item	in	the	table.	Hint:	The	products will	need	to	be	broken	up	into	separate groups.'

select product_number,Max(Sales_Amount),Min(Sales_Amount) from transactionmaster
group by product_number;

                                           'EXERCISE	6:	ORDER	BY	CLAUSE	QUERIES'

'1. Select	the	Name	of	customer	companies,	city,	and	state	for	all	customers	in	the	CustomerMaster	table.	
Display	the	results	in	Ascending	Order	based	on	the	Customer	Name	(company	name).'

select Firstofcustomer_name,Firstofcity,Firstofstate from customermaster 
order by (Firstofcustomer_name) asc ;

'2. Same	thing	as	question	#1,	but	display	the	results	in	descending	order.'

select Firstofcustomer_name,Firstofcity,Firstofstate from customermaster 
order by (Firstofcustomer_name) desc ;

'3. Select	the	product	number	and	sales	amount	for	all	of	the	items	in	the	TransactionMaster table	that	the	sales	
amount	is	greater	than	100.00.	Display	the	results	in	descending	order	based	on	the	price.'

select product_number,sales_amount from transactionmaster
where sales_amount>100 
order by (sales_amount) desc ;

                                            'EXERCISE	7:	HAVING	CLAUSE	QUERIES'

'1. How	many	branches are	in	each	unique	region	in	the	LocationMaster	table	that	has more	than	one	branch in	the	region?	
Select	the	region and	 display	the	number	of	branches are	in	each	if	it's 'greater	than	1.'

select region , count(branch_number) as Total_Branches from locationmaster
group by region
having Total_Branches>1 ;


'2. From	the	TransactionMaster table,	select	the	item,	maximum	sales amount,	and	minimum	sales	amount	for	each	product	number	
in	the	table.	Only	display	the	results	if	the	maximum	price	for	one	of	the	items	is	greater	than	390.00.'

select product_number,Max(Sales_Amount),Min(Sales_Amount) from transactionmaster
group by product_number
having Max(Sales_Amount) >390;

'3. How	many	orders	did	each	customer	company	make?	Use	the	TransactionMaster table.	Select	the	Customer_Number,	count	the	number	
of	orders	they	made,	and	the	sum	of	their	orders	if	they	purchased	more	than	1	item.'

Select customer_number ,count(invoice_number) as Total_Orders from transactionmaster
group by Customer_Number
having Total_Orders > 1 ;

                                           'EXERCISE	8:	IN	AND	BETWEEN	FUNCTION	QUERIES'

'1. List	all	the	employees	who	have	worked	between	22	March	2004	and	21	April	2004.'

select * from employee_master
where Hire_Date between "2004-03-22" and "2004-04-21" ;

'2. List	the	names	of	Employees	whose	Job	Code	is	in	SR1,SR2	or	SR3.'

select First_Name,Last_name,Job_code from employee_master
where job_code in("SR1","SR2","SR3");

'3. Select	the	Invoice	date,	Product	number	and	Branch	number	of	all	 transactions,	which	have	Sales	amount	ranging	from	
150.00	to	200.00.'

SELECT Invoice_date,product_number,branch_number,sales_amount from transactionmaster
where sales_amount between 150 and 200 ;

'4. Select	the	Branch	Number,	Market	and	Region	from	the	LocationMaster	
table	for	all	of	the	rows	where	the	Market	value	is	either:	Dallas,	Denver,	Tulsa,	or	Canada.'

select branch_number,Market,Region from locationmaster
where market in("Dallas","Denver","Tulsa","Canada") ;

                                                 'EXERCISE	9:	TABLE	JOINS'

'1. Write	a	query	using	a	join	to	determine	which	products were	ordered	by	each	of	the	customers in	
the	CustomerMaster table.	Select	the	Customer_Number,	FirstOfCustomer_Name,	FirstOfCity,	Product_Number,	
Invoice_Number,	Invoice_date,	and	Sales_Amount for	everything	each	customer	purchased	in	the	TransactionsMaster table.'

Select	CM.Customer_Number,CM.FirstOfCustomer_Name,CM.FirstOfCity,TM.Invoice_Number,TM.Invoice_date,TM.Sales_Amount FROM 
customermaster as CM INNER JOIN transactionmaster as TM ON
 CM.Customer_Number = TM.Customer_Number ;

'2. Repeat	question #1,	however	display	the	results	sorted	by	City in	descending	order.'

Select	CM.Customer_Number,CM.FirstOfCustomer_Name,CM.FirstOfCity,TM.Invoice_Number,TM.Invoice_date,TM.Sales_Amount FROM 
customermaster as CM INNER JOIN transactionmaster as TM ON
 CM.Customer_Number = TM.Customer_Number 
 ORDER BY  (CM.FirstOfCity) DESC;
