<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:variable name="id">
		<xsl:value-of select="//publicationStmt/idno[@type='digital audio filename']"/>
	</xsl:variable>

	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<link rel="stylesheet" type="text/css" href="../style.css"/>
			</head>
			<body>
				<div id="wrap">
					<xsl:apply-templates select="descendant::div1[@type='event']"/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="div1[@type='event']">
		<xsl:for-each select="u">
			<div class="section">
				<xsl:apply-templates select="."/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="head">
		<h2>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>

	<xsl:template match="u">
		<xsl:variable name="who" select="@who"/>
		<div class="u">
			<!--<xsl:value-of select="position()"/>-->
			<h3>
				<xsl:value-of select="//particDesc/person/descendant::node()[@id = $who]"/>
			</h3>
			<!--<xsl:if test="string(@open)">
				<div style="float:right;">
					<object id="interviewTrack" classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"
						height="128" width="200" codetype="audio/mpeg"
						codebase="http://www.apple.com/qtactivex/qtplugin.cab">
						<param name="enablejavascript" value="true"/>
						<param name="controller" value="true"/>
						<param name="loop" value="false"/>
						<param name="scale" value="aspect"/>
						<param name="bgcolor" value="silver"/>
						<param name="src"
							value="rtsp://qss.itc.virginia.edu/medialab/ethan/01_T140begins.m4a"/>
						<param name="autoplay" value="true"/>
						<param name="STARTTIME" value="{@open}"/>
						<param name="ENDTIME" value="{following-sibling::u[string(@open)][1]/@open}"/>
						<embed name="interviewTrack" startime="{@open}" endtime="{following-sibling::u[string(@open)][1]/@open}"
							src="rtsp://qss.itc.virginia.edu/medialab/ethan/01_T140begins.m4a"
							pluginspage="http://www.apple.com/quicktime/download/"
							allowembedtagoverrides="true" enablejavascript="true" TYPE="audio/mpeg"
							height="128" width="200" autoplay="false" loop="false" controller="true"
							scale="aspect" cgcolor="silver" starttime="{@open}"/> 
					</object>
					<br/>
					<label>
						<xsl:value-of select="@open"/><xsl:text> - </xsl:text>
						<xsl:value-of select="following-sibling::u[string(@open)][1]/@open"/>
					</label>
				</div>
			</xsl:if>-->

			<div style="width:500px;">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="hi">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@rend='bold'">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="event">
		<i>[<xsl:value-of select="@desc"/>]</i>
	</xsl:template>

	<xsl:template match="milestone[@unit = 'close']"/>
</xsl:stylesheet>
