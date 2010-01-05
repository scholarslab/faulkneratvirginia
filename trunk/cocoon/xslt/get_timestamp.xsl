<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="xhtml" encoding="UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title/>
			</head>
			<body>
				<xsl:apply-templates select="descendant::div1[@type='event']"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="div1[@type='event']">
		<div>
			<h2>Index</h2>
			<ul>
				<xsl:for-each select="descendant::milestone[@unit='open']">
					<li>
						<a href="#{replace(@n, '([0-9])a', '$1')}">
							<xsl:value-of select="replace(@n, '([0-9])a', '$1')"/>
						</a>
					</li>
				</xsl:for-each>
			</ul>
		</div>
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="head">
		<h2>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>

	<xsl:template match="u">
		<div>
			<xsl:value-of select="@who"/>: <xsl:apply-templates/></div>
	</xsl:template>

	<xsl:template match="hi">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@rend='bold'">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="event">
		<i>[<xsl:value-of select="@desc"/>]</i>
	</xsl:template>

	<xsl:template match="milestone[@unit='open']">
		<div style="width:100%;background-color:silver;margin-top:40px;">
			<a name="{replace(@n, '([0-9])a', '$1')}"/>
			<xsl:variable name="close_n">
				<xsl:value-of select="replace(@n, '([0-9])a', '$1b')"/>
			</xsl:variable>

			<xsl:text>Start: </xsl:text>
			<xsl:value-of select="@timestamp"/>
			<br/>
			<xsl:text>End: </xsl:text>
			<xsl:value-of select="//milestone[@n=$close_n]/@timestamp"/>
			<br/>
			<xsl:text>id: </xsl:text>
			<xsl:value-of select="replace(@n, '([0-9])a', '$1')"/>
		</div>
	</xsl:template>

	<xsl:template match="milestone[@unit = 'close']"/>
</xsl:stylesheet>
