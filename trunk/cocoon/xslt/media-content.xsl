<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:cinclude="http://apache.org/cocoon/include/1.0" exclude-result-prefixes="cinclude">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/html"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:param name="path"/>
	<xsl:param name="id"/>
	<xsl:param name="q"/>

	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>:
					Media</title>
				<link type="text/css" href="/{$path}style.css" rel="stylesheet" media="screen,projection"/>
				<link type="text/css" href="/{$path}print.css" rel="stylesheet" media="print"/>
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:copy-of select="//media-content/div[@id=$id]/*"/>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
