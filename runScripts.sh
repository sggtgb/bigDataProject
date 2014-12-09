#!/bin/bash

scripts[0]="numCancellation_perCarrier"
scripts[1]="origin_taxioutTop5"
scripts[2]="avgArrivalDelay_perCarrier"
scripts[3]="numFlights_perOrigin"
scripts[4]="numFlights_perCarrier"
scripts[5]="avgSecurityDelay_perOrigin"
scripts[6]="numFlights_perDestination"
scripts[7]="weatherDelay_perQuarter"
scripts[8]="airtimeBetweenOriginDestination"
scripts[9]="cancellations_perMonth"
scripts[10]="avgWeatherDelays_perMonth"
scripts[11]="oddsOfWeatherDelay_perMonth"

outputPath=$HOME/output
mkdir $outputPath

hive -f init.sql

i=0;
for i in {0..11} 
do

	#run the query
	hive -f ${scripts[$i]}.sql
	#get the data out
	out="$outputPath/${scripts[$i]}.csv"
	sudo mv /home/hadoop/tmp/000000_0 $out
	#path="${scripts[$i]}.sql"
	#touch $path
done

sudo tar -czvf output.tar.gz $outputPath
rm -R $outputPath
rm -R /home/hadoop/tmp

exit
