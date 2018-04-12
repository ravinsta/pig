retail = load '/home/hduser/retail' USING PigStorage(';') AS (t_date:chararray,c_id:chararray,age,area,category,p_id,qty,cost:double,sales:double);

retail1 = foreach retail generate $5, $7, $8;

grouppid = group retail1 by $0;

sumid = foreach grouppid generate $0, SUM(retail1.cost) as tcost, SUM(retail1.sales) as tsales;

profit = foreach sumid generate $0 , (tsales - tcost) as p;

orderbyprofit = order profit by $1 desc;

p = limit orderbyprofit 5;

dump p;




