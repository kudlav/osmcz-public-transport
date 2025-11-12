#!/bin/sh
set -e

echo "Downloading OSM data from Overpass"
curl --compressed -o ids.osm "https://overpass-api.de/api/interpreter?data=%5Bout%3Axml%5D%3B%0Aarea%5Bname%3D%22%C4%8Cesko%22%5D-%3E.a%3B%0A%28%0A%09rel%28area.a%29%5Broute~%22%5E%28tram%7Cbus%7Ctrain%7Crailway%7Csubway%7Ctrolleybus%29%24%22%5D%3B%0A%29%3B%0Aout%20meta%3B"

echo "Processing OSM data into Wiki format"
xsltproc --stringparam current-date `date +%d.%m.%Y` -o output.txt ids.xsl ids.osm

echo "Analysing data OSM Relation Analyzer"
awk -f ids.awk output.txt > outputAnalyzed.txt
rm temp.html
