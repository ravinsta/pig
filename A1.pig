retail = load '/home/hduser/retail/D11' USING PigStorage(';') AS (t_date:chararray,c_id:chararray,age,area,category,p_id,qty,cost:double,sales:double);

retail1 = foreach retail generate $0, $1, $8;



grouptotal = group retail1 all;

maxnov = foreach grouptotal generate MAX(retail1.sales);



maxcust = filter retail1 by $2 == maxnov.$0;

dump maxcust;
