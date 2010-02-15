<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
	<xsl:template name="header">
		<div id="header">
			<h1 class="alt"><xsl:value-of select="document('../data/site_info.xml')//title"/></h1>
			<div style="border-bottom:1px solid silver;display:table;width:100%;">
				<ul class="menu">
					<li>
						<a href="{$path}./">Home</a>
					</li>
					<li>
						<a href="{$path}browse">Browse</a>
					</li>
					<li>
						<a href="{$path}search">Search</a>
					</li>
					<xsl:for-each select="document('../data/site_info.xml')//page">
						<li>
							<a href="{$path}page?id={@id}">
								<xsl:value-of select="@slug"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>				
			</div>
		</div>
	</xsl:template>

</xsl:stylesheet>
