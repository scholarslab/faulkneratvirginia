<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:cinclude="http://apache.org/cocoon/include/1.0" exclude-result-prefixes="cinclude">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/html"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:param name="path"/>
	<xsl:param name="q"/>
	<xsl:param name="rows"/>
	<xsl:param name="start"/>

	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>: Search</title>
					
				<link type="text/css" href="/style.css" rel="stylesheet" media="screen,projection"/>
				<link type="text/css" href="/print.css" rel="stylesheet" media="print" />	
				
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<h2>Search</h2>
						<p>Use the pulldown menu <em>at left</em> to search either the recordings or the archive's various  
							essays, articles and images.  When you follow the hits to a file, you may have to use Ctrl-f to highlight the word 
							or phrase you're searching for.</p>
						<fieldset>
							<form action="{$path}results">
								<select name="type">
									<option value="transcription">Tapes &amp; Transcripts</option>
									<option value="prose">Rest of Archive</option>
								</select>
								<input type="text" name="q" class="search_box" value="{$q}"/>
								<input type="submit" class="search_button" value="Search"/>
							</form>
						</fieldset>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
