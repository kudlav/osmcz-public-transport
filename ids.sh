#!/bin/sh
set -e

OVERPASS="https://overpass-api.de/api/interpreter"
QUERY='[out:xml];
area[name="Česko"]->.a;
(
	rel(area.a)[route~"^(tram|bus|train|railway|subway|trolleybus)$"];
);
out meta;'

echo "Downloading OSM data from Overpass"
curl -f --compressed "$OVERPASS" --data-urlencode "data=$QUERY" -o ids.osm

echo "Processing OSM data into Wiki format"
xsltproc --stringparam current-date "$(date +%d.%m.%Y)" -o output.txt ids.xsl ids.osm

echo "Analysing data OSM Relation Analyzer"
awk -f ids.awk output.txt > outputAnalyzed.txt
rm temp.html
