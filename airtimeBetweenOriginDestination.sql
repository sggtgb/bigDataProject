set hive.cli.print.header=true;
use mighty_tigers;

--average airtime from origin to destination
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, dest, avg(airtime) as airtime
from perf
group by origin,dest
order by airtime desc;
