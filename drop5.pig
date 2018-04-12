--Load monthly data from local into three bags
sales2000 = LOAD '/home/hduser/2000.txt' using PigStorage(',') as (prod_id:long, product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);

sales2001 = LOAD '/home/hduser/2001.txt' using PigStorage(',') as (prod_id:long, product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);

sales2002 = LOAD '/home/hduser/2002.txt' using PigStorage(',') as (prod_id:long, product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);

--Calculate annual sales by adding monthly sales of each year
totsales2000 = foreach sales2000 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2000;

totsales2001 = foreach sales2001 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2001;

totsales2002 = foreach sales2002 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2002;

alljoin = join totsales2000 by $0, totsales2001 by $0, totsales2002 by $0;

aa = limit alljoin 4;

removejoin = foreach alljoin generate $0, $1, $2, $5, $8;

alldata = foreach removejoin generate $0, $1, ($2+$3+$4);

orderbycount = order alldata by $2 desc;

ss = limit orderbycount 5;



orderbycount1 = order alldata by $2;

ll = limit orderbycount1 5;
dump ss;

dump ll;


