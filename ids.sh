#!/bin/sh
curl 'https://overpass-api.de/api/interpreter?data=%5Bout%3Axml%5D%3B%0Aarea%5Bname%3D%22%C4%8Cesko%22%5D-%3E.a%3B%0A%28%0A%09rel%28area.a%29%5Broute%3Dtram%5D%3B%0A%20%20%09rel%28area.a%29%5Broute%3Dbus%5D%3B%0A%20%20%09rel%28area.a%29%5Broute%3Dtrain%5D%3B%0A%20%20%09rel%28area.a%29%5Broute%3Drailway%5D%3B%0A%20%20%09rel%28area.a%29%5Broute%3Dsubway%5D%3B%0A%20%20%09rel%28area.a%29%5Broute%3Dtrolleybus%5D%3B%0A%29%3B%0Aout%20meta%3B' -o ids.osm
xsltproc --stringparam current-date `date +%d.%m.%Y` -o output.txt ids.xsl ids.osm
awk -f ids.awk output.txt > outputAnalyzed.txt
rm temp.html
