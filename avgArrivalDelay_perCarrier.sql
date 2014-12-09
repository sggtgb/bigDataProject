set hive.cli.print.header=true;
use mighty_tigers;

--average arrival delay based on carrier
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier, avg(arradelayminutes) as delay
from perf
group by carrier
order by delay desc;
