<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
	<xsl:include href="header.xsl"/>
	<xsl:include href="footer.xsl"/>

	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:param name="path"/>
	<xsl:param name="q"/>
	<xsl:param name="sort"/>
	<xsl:param name="rows">10</xsl:param>
	<xsl:param name="start"/>
	<xsl:param name="type"/>
	<xsl:variable name="start_var">
		<xsl:choose>
			<xsl:when test="string($start)">
				<xsl:value-of select="$start"/>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="numFound">
		<xsl:value-of select="//result[@name='response']/@numFound"/>
	</xsl:variable>

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="document('../data/site_info.xml')//title"/>
				</title>
					
				<link type="text/css" href="/style.css" rel="stylesheet" media="screen,projection"/>
				<link type="text/css" href="/colorbox.css" rel="stylesheet" media="screen"/>
				
				<script type="text/javascript" language="javascript" src="javascript/jquery-1.3.2.min.js"/>
				<script type="text/javascript" language="javascript" src="javascript/sort_results.js"/>				
				<script type="text/javascript" language="javascript" src="javascript/AC_Quicktime.js">//</script>
			</head>
			<body>
				
				<div id="wrap">
					<xsl:call-template name="header"/>
					<div class="content">
						<xsl:choose>
							<xsl:when test="$numFound &gt; 0">
								<xsl:call-template name="paging"/>
								<xsl:apply-templates select="descendant::doc"/>
								<xsl:call-template name="paging"/>
							</xsl:when>
							<xsl:otherwise>
								<p>No results found.</p>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="doc">
		<xsl:variable name="id" select="str[@name='id']"/>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">
					<xsl:text>result_div_even</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>result_div_odd</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="{$class}">
			<dl>
				<xsl:choose>
					<xsl:when test="$type='transcription'">
						<a href="display/{str[@name='doc_id']}#{$id}">
							<xsl:choose>
								<xsl:when test="string(str[@name='head'])">
									<xsl:value-of select="str[@name='head']"/>
								</xsl:when>
								<xsl:otherwise>[No Header]</xsl:otherwise>
							</xsl:choose>
						</a>
						<div><p>
							<script language="JavaScript" type="text/javascript">
							try {
							QT_WriteOBJECT(
							'http://qss.itc.virginia.edu/medialab/faulkner_audio/<xsl:value-of select="str[@name='doc_id']"/>.mp4', ' 300 ', ' 16 ', '',
							'autoplay', 'false',
							'scale', 'tofit',
							'starttime','<xsl:value-of select="replace(str[@name='start'], '\.', ':')"/>',
							'endtime','<xsl:value-of select="replace(str[@name='end'], '\.', ':')"/>');
							}
							catch (e) {
							//document.write(e);
							}</script></p>
						</div>
						<div>
							<dt>Date:</dt>
							<dd>
								<xsl:value-of select="str[@name='date_display']"/>
							</dd>
						</div>
						<div>
							<dt>Participants:</dt>
							<dd>
								<xsl:value-of select="str[@name='location']"/>
							</dd>
						</div>
					</xsl:when>
					<xsl:when test="$type='prose'">
						<xsl:choose>
							<xsl:when test="str[@name='page_id']">
								<xsl:choose>
									<xsl:when test="string(str[@name='section_title'])">
										<a
											href="page?id={str[@name='page_id']}&amp;section={str[@name='id']}">
											<xsl:value-of select="str[@name='section_title']"/>
										</a>
										<xsl:text>, from </xsl:text>
										<xsl:value-of select="str[@name='page_title']"/>
									</xsl:when>
									<xsl:otherwise>
										<a href="page?id={str[@name='id']}">
											<xsl:value-of select="str[@name='page_title']"/>
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="str[@name='section_title'] = 'Image'">
										<div style="float:left;width:120px;">
											<a href="media?id={str[@name='id']}">
												<img src="{str[@name='thumb_image']}" style="max-width:120px;"/>
											</a>
										</div>
										<div style="margin-left:140px;">
										<a href="media?id={str[@name='id']}">
											File
											<!--<xsl:value-of select="str[@name='section_title']"/> -->
										</a>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<a href="media?id={str[@name='id']}">
											<xsl:value-of select="str[@name='section_title']"/>
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="str[@name='section_title'] = 'Image'">
						<div style="margin-left:140px;">
							<dt>Snippet:</dt>
							<dd>
								<xsl:value-of select="//lst[@name=$id]/arr/str"
									disable-output-escaping="yes"/>
							</dd>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div>
							<dt>Snippet:</dt>
							<dd>
								<xsl:value-of select="//lst[@name=$id]/arr/str"
									disable-output-escaping="yes"/>
							</dd>
						</div>
					</xsl:otherwise>
				</xsl:choose>
				
			</dl>
		</div>
	</xsl:template>

	<xsl:template name="paging">
		<xsl:variable name="next">
			<xsl:value-of select="$start_var+$rows"/>
		</xsl:variable>

		<xsl:variable name="previous">
			<xsl:choose>
				<xsl:when test="$start_var &gt;= $rows">
					<xsl:value-of select="$start_var - $rows"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="current" select="$start_var div $rows + 1"/>
		<xsl:variable name="total" select="ceiling($numFound div $rows)"/>

		<div class="paging_div">
			<div style="float:left;">
				<b>
					<xsl:value-of select="$start_var + 1"/>
				</b>
				<xsl:text> to </xsl:text>
				<xsl:choose>
					<xsl:when test="$numFound &gt; ($start_var + $rows)">
						<b>
							<xsl:value-of select="$start_var + $rows"/>
						</b>
					</xsl:when>
					<xsl:otherwise>
						<b>
							<xsl:value-of select="$numFound"/>
						</b>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> of </xsl:text>
				<b>
					<xsl:value-of select="$numFound"/>
				</b>

				<!-- if the search is a transcription search, show sort mechanism -->
				<!-- <xsl:if test="$type = 'transcription'"> -->
					<xsl:text> sorted by </xsl:text>
					<xsl:call-template name="sort"/>
				<!-- </xsl:if> -->
			</div>

			<!-- paging functionality -->
			<div style="float:right;">
				<xsl:if test="$numFound &gt; $rows and $start_var &gt; $previous">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$previous}&amp;sort={$sort}"
								>Previous</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$previous}"
								>Previous</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>

				<!-- always display links to the first two pages -->
				<xsl:if test="$start_var div $rows &gt;= 3">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start=0&amp;sort={$sort}">
								<xsl:text>1</xsl:text>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start=0">
								<xsl:text>1</xsl:text>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="$start_var div $rows &gt;= 4">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$rows}&amp;sort={$sort}">
								<xsl:text>2</xsl:text>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$rows}">
								<xsl:text>2</xsl:text>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>

				<!-- display only if you are on page 6 or greater -->
				<xsl:if test="$start_var div $rows &gt;= 5">
					<span class="pagingSep">...</span>
				</xsl:if>

				<!-- always display links to the previous two pages -->
				<xsl:if test="$start_var div $rows &gt;= 2">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var - ($rows * 2)}&amp;sort={$sort}">
								<xsl:value-of select="($start_var div $rows) -1"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var - ($rows * 2)}">
								<xsl:value-of select="($start_var div $rows) -1"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="$start_var div $rows &gt;= 1">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var - $rows}&amp;sort={$sort}">
								<xsl:value-of select="$start_var div $rows"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var - $rows}">
								<xsl:value-of select="$start_var div $rows"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>

				<span class="pagingBtn">
					<b>
						<xsl:value-of select="$current"/>
					</b>
				</span>

				<!-- next two pages -->
				<xsl:if test="($start_var div $rows) + 1 &lt; $total">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var + $rows}&amp;sort={$sort}">
								<xsl:value-of select="($start_var div $rows) +2"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var + $rows}">
								<xsl:value-of select="($start_var div $rows) +2"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="($start_var div $rows) + 2 &lt; $total">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var + ($rows * 2)}&amp;sort={$sort}">
								<xsl:value-of select="($start_var div $rows) +3"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$start_var + ($rows * 2)}">
								<xsl:value-of select="($start_var div $rows) +3"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="$start_var div $rows &lt;= $total - 6">
					<span class="pagingSep">...</span>
				</xsl:if>

				<!-- last two pages -->
				<xsl:if test="$start_var div $rows &lt;= $total - 5">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={($total * $rows) - ($rows * 2)}&amp;sort={$sort}">
								<xsl:value-of select="$total - 1"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={($total * $rows) - ($rows * 2)}">
								<xsl:value-of select="$total - 1"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="$start_var div $rows &lt;= $total - 4">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={($total * $rows) - $rows}&amp;sort={$sort}">
								<xsl:value-of select="$total"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={($total * $rows) - $rows}">
								<xsl:value-of select="$total"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
				<xsl:if test="$numFound &gt; $rows and $next &lt; $numFound">
					<xsl:choose>
						<xsl:when test="string($sort)">
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$next}&amp;sort={$sort}"
								>Next</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="pagingBtn"
								href="results?q={$q}&amp;type={$type}&amp;start={$next}"
								>Next</a>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:if>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="sort">
		<form action="results" class="sort_results">
			<input type="text" value="{$q}" name="q"/>
			<input type="hidden" name="type" value="{$type}"/>
			<input type="hidden" name="sort"/>
			<select id="sort">
				<xsl:choose>
					<xsl:when test="$sort = 'date_sint asc'">
						<option value="relevance">Relevance</option>
						<option value="date_sint asc" selected="selected">Date, Ascending</option>
						<option value="date_sint desc">Date, Descending</option>
						<!-- <option value="location asc">Location, Ascending</option>
						<option value="location desc">Location, Descending</option> -->
					</xsl:when>
					<xsl:when test="$sort = 'date_sint desc'">
						<option value="relevance">Relevance</option>
						<option value="date_sint asc">Date, Ascending</option>
						<option value="date_sint desc" selected="selected">Date, Descending</option>
						<!-- <option value="location asc">Location, Ascending</option>
						<option value="location desc">Location, Descending</option> -->
					</xsl:when>
					<xsl:when test="$sort = 'location asc'">
						<option value="relevance">Relevance</option>
						<option value="date_sint asc">Date, Ascending</option>
						<option value="date_sint desc">Date, Descending</option>
						<!-- <option value="location asc" selected="selected">Location,
							Ascending</option>
						<option value="location desc">Location, Descending</option>-->
					</xsl:when>
					<xsl:when test="$sort = 'location desc'">
						<option value="relevance">Relevance</option>
						<option value="date_sint asc">Date, Ascending</option>
						<option value="date_sint desc">Date, Descending</option>
						<!-- <option value="location asc">Location, Ascending</option>
						<option value="location desc" selected="selected">Location,
							Descending</option> -->
					</xsl:when>
					<xsl:otherwise>
						<option value="relevance">Relevance</option>
						<option value="date_sint asc">Date, Ascending</option>
						<option value="date_sint desc">Date, Descending</option>
						<!-- <option value="location asc">Location, Ascending</option>
						<option value="location desc">Location, Descending</option> -->
					</xsl:otherwise>
				</xsl:choose>
			</select>
			<input type="submit" value="Search" id="submit_button"/>
		</form>
	</xsl:template>

</xsl:stylesheet>
