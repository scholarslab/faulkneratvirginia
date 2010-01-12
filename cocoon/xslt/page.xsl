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
	<xsl:param name="section"/>

	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>:
						<xsl:value-of select="descendant::page[@id=$id]/@title"/></title>
				<script type="text/javascript" language="javascript" src="javascript/jquery-1.3.2.min.js"/>
				<script type="text/javascript" language="javascript" src="javascript/jquery.lightbox-0.5.pack.js"/>
				<link type="text/css" href="style.css" rel="stylesheet"/>
				<link type="text/css" href="jquery.lightbox-0.5.css" rel="stylesheet"/>
				
				<script type="text/javascript" language="javascript">
					$(document).ready(function(){
						$('.essay_content a.large').lightbox({fixedNavigation:true});
					}); 
				</script>
				
				
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:if test="descendant::page[@id=$id]/section">
							<h4><xsl:value-of select="descendant::page[@id=$id]/@title"/>: Table of
								Contents</h4>
							<ul class="page_toc">
								<xsl:for-each select="descendant::page[@id=$id]/section">
									<xsl:choose>
										<xsl:when test="@id = $section">
											<li>
												<xsl:value-of select="@title"/>
											</li>
										</xsl:when>
										<xsl:otherwise>
											<li>
												<a href="page?id={parent::node()/@id}&amp;section={@id}">
													<xsl:value-of select="@title"/>
												</a>
											</li>
										</xsl:otherwise>
									</xsl:choose>									
								</xsl:for-each>
							</ul>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="string($section)">
								<xsl:copy-of
									select="descendant::page[@id=$id]/section[@id=$section]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of
									select="descendant::page[@id=$id]/*[not(name() = 'section')]"/>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
