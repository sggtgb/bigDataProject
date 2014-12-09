set hive.cli.print.header=true;
use mighty_tigers;

--number of flights to each destination
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select dest,count(*) as flights
from perf
group by dest
order by flights desc;

