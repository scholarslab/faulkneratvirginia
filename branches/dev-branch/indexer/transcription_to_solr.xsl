<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

	<xsl:template match="/">
		<add>
			<xsl:apply-templates select="descendant::div2[@type='dialog']"/>
		</add>
	</xsl:template>

	<xsl:template match="div2[@type='dialog']">
		<doc>
			<field name="type">transcription</field>
			<field name="id">
				<xsl:value-of select="@id"/>
			</field>
			<field name="doc_id">
				<xsl:value-of select="//idno[@type='digital audio filename']"/>
			</field>
			<field name="tape_id">
				<xsl:value-of select="//idno[@type='analog tape']"/>
			</field>
			<xsl:if test="string(normalize-space(head))">
				<field name="head">
					<xsl:value-of select="normalize-space(head)"/>
				</field>
			</xsl:if>
			<field name="date_display">
				<xsl:value-of select="//settingDesc/setting/date"/>
			</field>
			<field name="date_sint">
				<xsl:value-of select="replace(//settingDesc/setting/date/@value, '-', '')"/>
			</field>
			<field name="location">
				<xsl:value-of select="//settingDesc/setting/locale"/>
			</field>
			<xsl:if test="string(@start)">
				<field name="start">
					<xsl:value-of select="@start"/>
				</field>
			</xsl:if>
			<xsl:if test="string(@end)">
				<field name="end">
					<xsl:value-of select="@end"/>
				</field>
			</xsl:if>
			<xsl:for-each select="descendant::u">
				<xsl:variable name="who" select="@who"/>
				<field name="u">
					<xsl:value-of select="//person/child::node()[@id=$who]"/>
					<xsl:text>: </xsl:text>
					<xsl:for-each select="descendant-or-self::text()">
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:text> </xsl:text>
					</xsl:for-each>
				</field>
			</xsl:for-each>
			<field name="fulltext">
				<xsl:for-each select="descendant-or-self::u">
					<xsl:value-of select="normalize-space(.)"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</field>
		</doc>
	</xsl:template>

</xsl:stylesheet>
