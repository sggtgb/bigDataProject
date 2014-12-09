set hive.cli.print.header=true;
use mighty_tigers;

--odds of having a weather delay
insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select zeros.month, ((numDelays/(numZeros))*100) as oddsOfDelay,numDelays,numZeros as noDelay
FROM (
        select month,count(perf.weatherdelay) as numZeros
        from perf
        where perf.weatherdelay = 0
        group by month ) as zeros
join (
        select month,count(weatherdelay) as numDelays
        from perf
        where weatherdelay > 0
        group by month) as nonZeros on (nonZeros.month=zeros.month)
order by month asc;
