retail = load '/home/hduser/retail' USING PigStorage(';') AS (t_date:chararray,c_id:chararray,age,area,category,p_id,qty,cost:double,sales:double);

retail1 = foreach retail generate $4, $7, $8;

groupcat = group retail1 by $0;

sumid = foreach groupcat generate $0, SUM(retail1.cost) as tcost, SUM(retail1.sales) as tsales;

profit = foreach sumid generate $0 , (tsales - tcost) as p;

percent = foreach sumid generate $0, (double) (profit.p/sumid.tcost*100) as profit;

orderbyprofit = order percent by $1 desc;

p = limit orderbyprofit 5;

dump p;




