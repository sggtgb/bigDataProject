set hive.cli.print.header=true;
use mighty_tigers;

--average security delay at each origin
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, avg(securitydelay) as avgsecurityDelay
from perf
group by origin
order by avgsecurityDelay desc;
