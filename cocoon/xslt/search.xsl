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
				
				<script type="text/javascript" language="javascript" src="javascript/jquery-1.3.2.min.js">//</script>
				
				<script type="text/javascript">
					$(document).ready(function(){
						var default_text = "Search the site...";
						var searchbox = $(".search_box");
						
						searchbox.focus(function(){
							if($(this).attr("value") == default_text) $(this).attr("value", "");
						});
						
						searchbox.blur(function(){
							if($(this).attr("value") == "") $(this).attr("value", default_text);
						});
					});
				</script>
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<h2>Search</h2>
						<p>The transcriptions of William Faulkner's audio tapes may be searched as
							well as the prose sections that give context to the collection.</p>
						<form action="{$path}results">
							<input type="text" name="q" class="search_box" value="{$q}"/>
							<select name="type">
								<option value="transcription">Audio Transcriptions</option>
								<option value="prose">Articles</option>
							</select>
							<input type="submit" value="Search"/>
						</form>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
