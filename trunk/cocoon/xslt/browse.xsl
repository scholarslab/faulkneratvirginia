<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:cinclude="http://apache.org/cocoon/include/1.0" exclude-result-prefixes="cinclude">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/html"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:param name="path"/>
	<xsl:param name="q"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
			<head>
				<title><xsl:value-of select="document('../data/site_info.xml')//title"/>: Browse
					Transcriptions</title>
				<link type="text/css" href="/style.css" rel="stylesheet" media="screen,projection"/>
				<link type="text/css" href="/print.css" rel="stylesheet" media="print" />
			</head>
			<body>
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:copy-of select="descendant::browse/text"/>
						<table class="browse_table">
							<thead>
								<tr>
									<th style="width:20%" class="underline">Date</th>
									<th class="underline">Participants</th>
									<th class="underline">Reading</th>
									<th class="underline">Splices&#8224;</th>
								</tr>
							</thead>
							<xsl:apply-templates select="descendant::browse/list/item"/>
						</table>
						<hr/>
						<p>&#8224; Although most of Faulkner's public sessions lasted about 50
							minutes, a reel of tape was typically full after about half an hour.  Thus
							during Faulkner's first term as Writer-in-Residence (Spring 1957), a few
							minutes in the middle of every session went unrecorded while a fresh tape
							was loaded on the recorder.  The next year a new taping system was used,
							allowing a second 30-minute tape to begin recording as the first 30-minute
							tape was about to run out.  This allowed a whole session to be captured on
							the two tapes, but invariably, a question and answer was divided between
							the two.  For these double-taped sessions, we've taken the end of the first
							tape and spliced it into the beginning of the second, and made separate
							files of them.  These "splices" allow you to hear the exchanges without
							interruption or repetition.</p>
						
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="item">
		<xsl:variable name="uri" select="concat('../data/tei/', normalize-space(id), '.xml')"/>
		<tr>
			<td>
				<xsl:if test="not(contains(id, '_')) or number(substring-after(id, '_')) &lt; 2">
					<xsl:value-of select="document($uri)//settingDesc/setting/date"/>
				</xsl:if>
			</td>
			<td>	
				<a href="display/{document($uri)//idno[@type='digital audio filename']}">
					<xsl:value-of select="@title" />
				</a>
			</td>
			<td>
				<xsl:if test="reading">
					<xsl:choose>
						<xsl:when test="string(readingfile)">
							<a href="display/{readingfile}"><xsl:copy-of select="reading" /></a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="reading" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="splice">
				<a href="display/{splice}">
					<img src="/arrow-right-play.gif" alt="play" class="center" />
				</a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
