set hive.cli.print.header=true;

create database if not exists mighty_tigers;
use mighty_tigers;

drop table if exists perf;
create table perf (year int, quarter int, month int, dayOfMonth int, dayOfWeek int, airlineID int, carrier string, tailnum string, origin string, originState string, originStateName string, originWAC int, dest string, destState string, destStateName string, septime int, depdelayminutes int, depDelayGroups int, taxiout int, wheelsOff int, wheelsOn int, taxiIn int, arrTime int, arrDelay int, arrADelayMinutes int, cancelled string, cancellationCode string, diverted string, acutalelapsedtime int, airtime int, distance int, carrierDelay int, weatherDelay int, nasdelay int, securitydelay int, lateaircraftdelay int)
row format delimited
fields terminated by ',';

load data local inpath 'perf.csv'
overwrite into table perf;
