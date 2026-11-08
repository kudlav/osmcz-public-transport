#!/usr/bin/env awk -f
/\$Length\$/ {

	url = "http://ra.osmsurround.org/analyzeRelation?noCache=true&_noCache=on&relationId="$3

	# Try up to 3 times with backoff
	for (i = 1; i <= 3; i++) {
			ret = system("curl -f -s -H 'Accept-Language: en' -o temp.html '"url"'")
			if (ret == 0) break
			system("sleep " (i * 7))
	}

	if (ret != 0) {
			print "ERROR! URL: " url > "/dev/stderr"
			next
	}

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
