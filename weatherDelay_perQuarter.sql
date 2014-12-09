set hive.cli.print.header=true;
use mighty_tigers;

--average weather delay by quarter
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select quarter,avg(weatherDelay) as weatherDelay
from perf
group by quarter
order by weatherDelay desc;
