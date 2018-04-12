txn = load '/home/hduser/Downloads/txns1.txt' USING PigStorage(',') AS ( txnid,date,custid,amount:double,category,product,city,state,type);

groupbytype = group txn by type;
 
typesales = foreach groupbytype generate group, ROUND_TO(SUM(txn.amount),2) as typetotal;

totalgroup = group typesales all;

totalsales = foreach totalgroup generate SUM(typesales.typetotal) as grandtotal;

final = foreach typesales generate $0, $1, (chararray) ROUND_TO(($1/totalsales.grandtotal)*100,2) as percent;

final1 = foreach final generate $0,$1,CONCAT( $2,'%');

dump final1;
