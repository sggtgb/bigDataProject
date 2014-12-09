set hive.cli.print.header=true;
use mighty_tigers;

--weather delays by month
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select month, avg(weatherDelay) as weatherDelay
from perf
group by month
order by month asc;
