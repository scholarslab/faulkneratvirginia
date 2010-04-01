<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 9, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> wsg4w</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:strip-space elements="*"/>
    <xsl:template match="/media-content/div">
       
        <p><xsl:value-of select="@id" /></p>
        
    </xsl:template>
    
</xsl:stylesheet>
