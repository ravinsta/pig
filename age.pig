txn= LOAD '/home/hduser/txns1.txt' using PigStorage(',') AS (txnid,date,custid,amount:double,category,product,city,state,type);

cust = load 'home/hduser/Downloads/custs' using PigStorage(',') AS (custid,fname,lname,age:long,prof);

custlessthan50 = filter cust by age<50;

groubpycust = group txn by custid;

spendbycust = foreach groupbycust generate group, SUM(txn.amount) as total;

customerthan500 = filter spendbycust by total > 500;
--dump custmorethan500;

joined = join custmorethan500 by $0, custlessthan50 by $0;

--dump joined;

--agelessthan50 = filter joined by age < 50;

--dump agelessthan50;

final = foreach joined generate $0,$3,$4,$5,$6 ROUND_TO($1,2);

--dump final;

--store final into '/home/hduser/pigexer' using PigStorage(','); 
