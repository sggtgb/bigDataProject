use mighty_tigers;
set hive.cli.print.header=true;

--airline cancellations
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier,count(*) as cancellations
from perf
where cancelled = 1
group by quarter,carrier
order by cancellations desc;
