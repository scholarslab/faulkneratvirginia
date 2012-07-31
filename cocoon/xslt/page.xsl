<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:cinclude="http://apache.org/cocoon/include/1.0" exclude-result-prefixes="cinclude">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/html"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:param name="path"/>
	<xsl:param name="id"/>
	<xsl:param name="q"/>
	<xsl:param name="section"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
			<head>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>:
						<xsl:value-of select="descendant::page[@id=$id]/@title"/></title>
						
				<script type="text/javascript" language="javascript" src="javascript/jquery-1.3.2.min.js">//</script>
				
				<script type="text/javascript" language="javascript" src="javascript/jquery.colorbox-min.js">//</script>
				<script type="text/javascript" src="{$path}javascript/AC_Quicktime.js">//</script>
				<script type="text/javascript" src="{$path}javascript/jquery.qtp.js">//</script>
				<script type="text/javascript" src="{$path}javascript/jquery.jqprint-0.3.js">//</script>
		
				<link type="text/css" href="/style.css" rel="stylesheet" media="screen, projection"/>
				<link type="text/css" href="/colorbox.css" rel="stylesheet" media="screen, projection"/>
				<link type="text/css" href="/print.css" rel="stylesheet" media="print" />
				
				<script type="text/javascript" language="javascript">
				$(document).ready(function() { 
					// attach a printer
					$('.hidden').prepend('<img class="print_hidden" src="/printer.png" />');				
				
					// enable the plumbing for printing
					$('.print_hidden').click(function(){
						$(this).parent().jqprint({operaSupport: true, importCSS: true});
					});
					
					//hide inline content
					$("a.inline").each(function(i){
						loc = $(this).attr('href');
						img_title = $(this).children('img').attr('title');
						$(this).colorbox({
							inline: 'true',
							href: loc,
							title: img_title,
							maxWidth: '60%',
							onOpen: function(){
								loc = $(this).attr('href');
								$(loc).toggleClass('hidden');
							},
							onClosed: function(){
								loc = $(this).attr('href');
								$(loc).toggleClass('hidden');
							}
						});
					});		
					
					// gallery code		
					$(".gallery a").each(function(i){
						img_title = $(this).children('img').attr('title');
						$(this).colorbox({
							title: img_title
						});
					});
				});
				</script>
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:if test="descendant::page[@id=$id]/section">
							<xsl:if test="$id != 'clips'">
								
							<h4><xsl:value-of select="descendant::page[@id=$id]/@title"/></h4>
							
							<ul class="page_toc">
								<xsl:for-each select="descendant::page[@id=$id]/section">
									<xsl:choose>
										<xsl:when test="$section = 'use'"><li class="use-li"><!-- hide me --></li></xsl:when>
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
						</xsl:if>
						<xsl:choose>
							<xsl:when test="string($section)">
								<xsl:copy-of
									select="descendant::page[@id=$id]/section[@id=$section]"/>
								<xsl:for-each select="descendant::page[@id=$id]/section[@id=$section]//a">
									<xsl:if test="contains(@href, '#')">
										<xsl:variable name="id" select="substring-after(@href, '#')"/>
										<xsl:copy-of select="//media-content/div[@id=$id]"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of
									select="descendant::page[@id=$id]/*[not(name() = 'section')]"/>
								<xsl:for-each select="descendant::page[@id=$id]/section[@id=$section]//a">
									<xsl:if test="contains(@href, '#')">
										<xsl:variable name="id" select="substring-after(@href, '#')"/>
											<xsl:copy-of select="//media-content/div[@id=$id]"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
