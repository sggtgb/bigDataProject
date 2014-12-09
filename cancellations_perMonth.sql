set hive.cli.print.header=true;
use mighty_tigers;

--cancellations by month
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select month, sum(cancelled) as cancellations
from perf
where cancelled = 1
group by month
order by month asc;
