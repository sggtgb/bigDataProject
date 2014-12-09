set hive.cli.print.header=true;

create database if not exists mighty_tigers;
use mighty_tigers;

drop table if exists perf;
create table perf (year int, quarter int, month int, dayOfMonth int, dayOfWeek int, airlineID int, carrier string, tailnum string, origin string, originState string, originStateName string, originWAC int, dest string, destState string, destStateName string, septime int, depdelayminutes int, depDelayGroups int, taxiout int, wheelsOff int, wheelsOn int, taxiIn int, arrTime int, arrDelay int, arrADelayMinutes int, cancelled string, cancellationCode string, diverted string, acutalelapsedtime int, airtime int, distance int, carrierDelay int, weatherDelay int, nasdelay int, securitydelay int, lateaircraftdelay int)
row format delimited
fields terminated by ',';

load data local inpath 'perf.csv'
overwrite into table perf;

--airline cancellations
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier,count(*) as cancellations 
from perf 
where cancelled = 1 
group by quarter,carrier 
order by cancellations desc;

--length of time for taxi
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin,taxiout 
from perf 
order by taxiout desc 
limit 5;

--average arrival delay based on carrier
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier, avg(arradelayminutes) as delay 
from perf 
group by carrier 
order by delay desc;

--number of flights from each origin
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, count(*) as origins 
from perf 
group by origin 
order by origins desc;

--number of flights by each carrier
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select carrier,count(*) as flights 
from perf 
group by carrier 
order by flights desc;

--average security delay at each origin
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, avg(securitydelay) as avgsecurityDelay 
from perf 
group by origin 
order by avgsecurityDelay desc;

--number of flights to each destination
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select dest,count(*) as flights 
from perf 
group by dest 
order by flights desc;

--average weather delay by quarter
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select quarter,avg(weatherDelay) as weatherDelay 
from perf 
group by quarter 
order by weatherDelay desc;

--average airtime from origin to destination
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, dest, avg(airtime) as airtime 
from perf 
group by origin,dest 
order by airtime desc;

--average delay time from origin to destination
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select origin, dest, avg(arradelayminutes) as delay 
from perf 
group by origin,dest 
order by delay desc;

--cancellations by month
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select month, sum(cancelled) as cancellations 
from perf 
where cancelled = 1 
group by month 
order by month asc;

--weather delays by month
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
select month, avg(weatherDelay) as weatherDelay 
from perf 
group by month 
order by month asc;

--odds of having a weather delay
--insert overwrite local directory '/home/hadoop/tmp' row format delimited fields terminated by ","
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
