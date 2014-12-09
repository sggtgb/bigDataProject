set hive.cli.print.header=true;
use mighty_tigers;

--number of flights by each carrier
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier,count(*) as flights
from perf
group by carrier
order by flights desc;

