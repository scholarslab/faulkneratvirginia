<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

	<xsl:template match="/">
		<add>
			<xsl:apply-templates select="descendant::page"/>
			<xsl:apply-templates select="descendant::media-content/div"/>
		</add>
	</xsl:template>

	<xsl:template match="page">
		<xsl:choose>
			<xsl:when test="section">
				<xsl:apply-templates select="section"/>
			</xsl:when>
			<xsl:otherwise>
				<doc>
					<field name="id">
						<xsl:value-of select="@id"/>
					</field>
					<field name="type">prose</field>
					<field name="page_title">
						<xsl:value-of select="@title"/>
					</field>
					<field name="fulltext">
						<xsl:for-each select="descendant-or-self::text()">
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text> </xsl:text>
						</xsl:for-each>
					</field>
				</doc>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="section">
		<doc>
			<field name="id">
				<xsl:value-of select="@id"/>
			</field>
			<field name="type">prose</field>
			<field name="page_id">
				<xsl:value-of select="parent::node()/@id"/>
			</field>
			<field name="section_title">
				<xsl:value-of select="@title"/>
			</field>
			<field name="page_title">
				<xsl:value-of select="parent::node()/@title"/>
			</field>
			<field name="fulltext">
				<xsl:for-each select="descendant-or-self::text()">
					<xsl:value-of select="normalize-space(.)"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</field>
		</doc>
	</xsl:template>

	<xsl:template match="media-content/div">
		<doc>
			<field name="id">
				<xsl:value-of select="@id"/>
			</field>
			<field name="type">prose</field>
			<field name="section_title">
				<xsl:choose>
					<xsl:when test="h3">
						<xsl:value-of select="normalize-space(h3[1])"/>
					</xsl:when>
					<xsl:when test="h4">
						<xsl:value-of select="normalize-space(h4[1])"/>
					</xsl:when>
					<xsl:otherwise>Image</xsl:otherwise>
				</xsl:choose>
			</field>
			<xsl:if test="descendant::img">
				<field name="screen_image">
					<xsl:value-of select="descendant::img[1]/@src"/>
				</field>
				<field name="thumb_image">
					<xsl:value-of select="concat(substring-before(descendant::img[1]/@src, '.jpg'), 't.jpg')"/>
				</field>
			</xsl:if>
			<field name="fulltext">
				<xsl:for-each select="descendant-or-self::text()">
					<xsl:value-of select="normalize-space(.)"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</field>
		</doc>
	</xsl:template>

</xsl:stylesheet>
