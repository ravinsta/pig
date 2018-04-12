retail = load '/home/hduser/retail' USING PigStorage(';') AS (t_date:chararray,c_id:chararray,age,area,category,p_id,qty,cost:double,sales:double);

retail1 = foreach retail generate $4, $7, $8;

grouppid = group retail1 by $0;

sumid = foreach grouppid generate $0, SUM(retail1.cost) as tcost, SUM(retail1.sales) as tsales;

percent1 = foreach sumid generate $0, (chararray) ROUND_TO(((tsales-tcost)/tcost*100),2) as gross ;

percent = foreach percent1 generate $0,CONCAT( $1,'%');

pp = limit percent 5;

dump pp;
