<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:cinclude="http://apache.org/cocoon/include/1.0" exclude-result-prefixes="cinclude">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/html"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:param name="path"/>
	<xsl:param name="q"/>

	<xsl:template match="/">
		<html>
			<head>
				<link type="text/css" href="style.css" rel="stylesheet"/>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>: Browse
					Transcriptions</title>
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:copy-of select="descendant::browse/text"/>
						<table class="browse_table">
							<thead>
								<tr>
									<th style="width:20%" class="underline">Date</th>
									<th class="underline">Participants</th>
									<th class="underline">Reading</th>
								</tr>
							</thead>
							<xsl:apply-templates select="descendant::browse/list/item"/>
						</table>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="item">
		<xsl:variable name="uri" select="concat('../data/tei/', normalize-space(id), '.xml')"/>
		<tr>
			<td>
				<xsl:if test="not(contains(id, '_')) or number(substring-after(id, '_')) &lt; 2">
					<xsl:value-of select="document($uri)//settingDesc/setting/date"/>
				</xsl:if>
			</td>
			<td>	
				<a href="display/{document($uri)//idno[@type='digital audio filename']}">
					<xsl:value-of select="@title" />
				</a>
			</td>
			<td>
				<xsl:copy-of select="reading" />
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
