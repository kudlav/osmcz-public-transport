#!/usr/bin/env awk -f
/\$Length\$/ {

	url = "http://ra.osmsurround.org/analyzeRelation?noCache=true&_noCache=on&relationId="$3

	system("curl -f -s -H 'Accept-Language: en' -o temp.html '"url"' \
		|| (sleep 12; curl -s -H 'Accept-Language: en' -o temp.html '"url"') ")

	t = "cat temp.html | grep 'Length in KM: <' | sed 's/.*>\\(.*\\)<\\/span>/\\1/'"

	s = "cat temp.html | grep -c 'Graph&nbsp;' | sed -E 's/^0?$//'"

	a = ""
	b = ""
	t | getline a
	s | getline b
	close(t)
	close(s)
	print "| "a
	print "| "b
}
/^[^$]*$/
