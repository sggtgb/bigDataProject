set hive.cli.print.header=true;
use mighty_tigers;

--length of time for taxi
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin,taxiout
from perf
order by taxiout desc
limit 5;
