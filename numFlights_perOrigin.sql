set hive.cli.print.header=true;
use mighty_tigers;

--number of flights from each origin
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, count(*) as origins
from perf
group by origin
order by origins desc;
