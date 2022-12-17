<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" omit-xml-declaration="yes" />

	<!-- Global template -->
	<xsl:template match="/osm">
		<xsl:text>Informace o mapování naleznete v článku [[Cs:Veřejná doprava|Veřejná doprava]].

'''Níže uvedené tabulky se generují ručně pomocí [[User:Kudlac/Skript Veřejná hromadná doprava v ČR|skriptu]].'''

Data OSM ke dni </xsl:text><xsl:value-of select="$current-date"/><xsl:text>.

</xsl:text>
		<xsl:apply-templates select="relation[tag[@k = 'network']]" mode="all_networks">
			<xsl:sort select="tag[@k='network']/@v" data-type="text" order="ascending"/>
		</xsl:apply-templates>
		<xsl:text>== Ostatní ==
</xsl:text>
		<xsl:apply-templates select="relation[not(tag[@k = 'network']/@v)]" mode="other_networks">
			<xsl:sort select="tag[@k='operator']/@v" data-type="text" order="ascending"/>
		</xsl:apply-templates>
		<xsl:text>

[[Category:Cs:Česká dokumentace|Verejna hromadna doprava v CR]]
</xsl:text>
	</xsl:template>

	<xsl:template match="relation" mode="all_networks">
		<xsl:if test="current()[not(tag[@k = 'network']/@v = preceding-sibling::relation/tag[@k = 'network']/@v)]/tag[@k = 'network']/@v">
			<xsl:text>
== </xsl:text><xsl:value-of select="tag[@k = 'network']/@v" /><xsl:text> ==
</xsl:text>

			<xsl:variable name='network' select="tag[@k = 'network']/@v" />
			<xsl:variable name='operator' select="tag[@k = 'operator']/@v" />
			<xsl:apply-templates select="../relation[tag[@k = 'network']/@v = $network]" mode="all_routes">
				<xsl:with-param name="network"><xsl:value-of select="$network" /></xsl:with-param>
				<xsl:sort select="tag[@k='route']/@v" data-type="text" order="ascending"/>
			</xsl:apply-templates>

		</xsl:if>
	</xsl:template>

	<xsl:template match="relation" mode="other_networks">
		<xsl:if test="current()[not(tag[@k = 'operator']/@v = preceding-sibling::relation/tag[@k = 'operator']/@v)]/tag[@k = 'operator']/@v">
			<xsl:text>=== </xsl:text><xsl:value-of select="tag[@k = 'operator']/@v" /><xsl:text> ===
</xsl:text>
			<xsl:variable name='operator' select="tag[@k = 'operator']/@v" />
			<xsl:apply-templates select="../relation[tag[@k = 'operator']/@v = $operator]" mode="other_operators">
				<xsl:with-param name="operator"><xsl:value-of select="$operator" /></xsl:with-param>
				<xsl:sort select="tag[@k='route']/@v" data-type="text" order="ascending"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="relation" mode="all_routes">
		<xsl:param name="network" />
		<xsl:if test="current()[not(tag[@k = 'route']/@v = preceding-sibling::relation[tag[@k = 'network']/@v = $network]/tag[@k = 'route']/@v)]">
			<xsl:choose>
				<xsl:when test="tag[@k = 'route']/@v = 'bus'">
					<xsl:text>==== Autobusy ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'railway'">
					<xsl:text>==== Vlaky ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'train'">
					<xsl:text>==== Vlakové spoje ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'tram'">
					<xsl:text>==== Tramvaje ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'trolleybus'">
					<xsl:text>==== Trolejbusy ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'subway'">
					<xsl:text>==== Metro ====
</xsl:text>
				</xsl:when>
			</xsl:choose>

			<xsl:text>{| class="wikitable sortable" style="width: auto; text-align: center; font-size: smaller; table-layout: fixed;"
|-
! Linka
! Relace
! Síť
! Dopravce
! Verze
! Délka [km]
! Segmentů
! Kompletní
</xsl:text>
			<xsl:variable name='route' select="tag[@k = 'route']/@v" />
			<xsl:apply-templates select="../relation[tag[@k = 'route']/@v = $route and tag[@k = 'network']/@v = $network]" mode='row'>
				<xsl:sort select="tag[@k='ref']/@v" data-type="number" order="ascending"/>
				<xsl:sort select="tag[@k='operator']/@v" data-type="text" order="ascending"/>
			</xsl:apply-templates>
			<xsl:text>|}
</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="relation" mode="other_operators">
		<xsl:param name="operator" />
		<xsl:if test="current()[not(tag[@k = 'route']/@v = preceding-sibling::relation[tag[@k = 'operator']/@v = $operator]/tag[@k = 'route']/@v)]">
			<xsl:choose>
				<xsl:when test="tag[@k = 'route']/@v = 'bus'">
					<xsl:text>==== Autobusy ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'train'">
					<xsl:text>==== Vlaky ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'tram'">
					<xsl:text>==== Tramvaje ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'trolleybus'">
					<xsl:text>==== Trolejbusy ====
</xsl:text>
				</xsl:when>
				<xsl:when test="tag[@k = 'route']/@v = 'subway'">
					<xsl:text>==== Metro ====
</xsl:text>
				</xsl:when>
			</xsl:choose>

			<xsl:text>{| class="wikitable sortable" style="width: auto; text-align: center; font-size: smaller; table-layout: fixed;"
|-
! Linka
! Relace
! Síť
! Dopravce
! Verze
! Délka [km]
! Segmentů
! Kompletní
</xsl:text>
			<xsl:variable name='route' select="tag[@k = 'route']/@v" />
			<xsl:apply-templates select="../relation[tag[@k = 'operator']/@v = $operator and tag[@k = 'route']/@v = $route]" mode='row'>
				<xsl:sort select="tag[@k='ref']/@v" data-type="number" order="ascending"/>
			</xsl:apply-templates>
			<xsl:text>|}
</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match='relation' mode='row'>
<xsl:text>|-
| </xsl:text><xsl:if test="tag[@k = 'colour']">
    <xsl:text disable-output-escaping="yes"><![CDATA[<span style="background:]]></xsl:text>
    <xsl:value-of select="tag[@k = 'colour']/@v" />
    <xsl:text disable-output-escaping="yes"><![CDATA[">&emsp;</span> ]]></xsl:text>
  </xsl:if>
  <xsl:value-of select="tag[@k = 'ref']/@v" /><xsl:text>
| {{Relation|</xsl:text><xsl:value-of select="@id" /><xsl:text>}}
| </xsl:text><xsl:value-of select="tag[@k = 'network']/@v" /><xsl:text>
| </xsl:text><xsl:value-of select="tag[@k = 'operator']/@v" /><xsl:text>
| </xsl:text><xsl:value-of select="@version" /><xsl:text>
| $Length$ </xsl:text><xsl:value-of select="@id" /><xsl:text>
| $Segments$ </xsl:text><xsl:value-of select="@id" /><xsl:text>
| </xsl:text>
	<xsl:choose>
		<xsl:when test="tag[@k = 'complete']/@v= 'yes'">ano</xsl:when>
		<xsl:when test="tag[@k = 'complete']/@v = 'no'">ne</xsl:when>
	</xsl:choose><xsl:text>
</xsl:text>
	</xsl:template>

</xsl:stylesheet>