# Skript Veřejná hromadná doprava v ČR

## Instalace (Ubuntu)
```
apt install xsltproc
```

## Spuštění

 - Stáhněte si soubory `ids.sh`, `ids.xsl` a `ids.awk`.
 - Spusťte skript `ids.sh`:
   ```
   sh ids.sh
   ```
 - Obsah souboru `outputAnalyzed.txt` vložte na stránku [Linky veřejné dopravy](https://wiki.openstreetmap.org/wiki/Cs:Linky_ve%C5%99ejn%C3%A9_dopravy) (původní obsah smažte).

---

Použitá Overpass Turbo query programem curl:
```
[out:xml];
area[name="Česko"]->.a;
(
	rel(area.a)[route=tram];
  	rel(area.a)[route=bus];
  	rel(area.a)[route=train];
  	rel(area.a)[route=railway];
  	rel(area.a)[route=subway];
  	rel(area.a)[route=trolleybus];
);
out meta;
```
