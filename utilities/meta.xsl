<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="url-f1" select="'master.xml'" />
<xsl:param name="url-f2" select="'master.xsl'" />

<xsl:template match="gist-by-id/entry" mode="meta">
	<div id="meta">
		<xsl:call-template name="user" />

		<xsl:if test="count(/data/files-by-revision/entry) &gt; 2">
			<div id="files">
				<h4>Files</h4>
				<ul class="menu">
					<xsl:apply-templates select="/data/files-by-revision/entry" mode="list" />
				</ul>
			</div>
		</xsl:if>

		<div id="revisions">
			<h4>Revisions</h4>
			<ul class="menu">
				<xsl:apply-templates select="revisions-list/revision" />
			</ul>
		</div>

		<xsl:if test="forks-list/fork">
			<div id="forks">
				<h4>Forks</h4>
				<ul class="menu">
					<xsl:apply-templates select="forks-list/fork" />
				</ul>
			</div>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="data">
	<xsl:apply-templates select="gist-by-id/entry" />
</xsl:template>

<xsl:template match="files-by-revision/entry">
	<div>
		<div class="meta">
			<h5><xsl:value-of select="filename" /></h5>

			<xsl:if test="count(/data/files-by-revision/entry) &gt; 2">
				<ul>
					<xsl:apply-templates select="/data/files-by-revision/entry" mode="list">
						<xsl:with-param name="current" select="filename" />
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</div>

		<xsl:choose>
			<xsl:when test="$owner">
				<xsl:variable name="post" 
				select="/data/events/update-gist/data/item[@key = 'files']/item[@key = current()/filename]"></xsl:variable>

				<xsl:variable name="value">
					<xsl:if test="$post"><xsl:value-of select="$post" /></xsl:if>
					<xsl:if test="not($post)"><xsl:value-of select="content" /></xsl:if>
				</xsl:variable>

				<textarea name="files[{filename}]"><xsl:value-of select="$value" /></textarea>
			</xsl:when>
			<xsl:otherwise>
				<pre><xsl:value-of select="content" /></pre>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>


<xsl:template match="files-by-revision/entry" mode="list">
	<xsl:variable name="ext" select="substring(filename, string-length(filename) -3)" />

	<li>
		<xsl:if test="(filename = $url-f1 or filename = $url-f2) and $current-page != 'process'">
			<xsl:attribute name="class">current</xsl:attribute>
		</xsl:if>
		<a>
			<xsl:attribute name="href">
				<xsl:variable name="s1">
					<xsl:if test="$ext != '.xsl'">f1</xsl:if>
					<xsl:if test="$ext = '.xsl'">f2</xsl:if>
				</xsl:variable>

				<xsl:variable name="s2">
					<xsl:if test="$ext != '.xsl'">f2</xsl:if>
					<xsl:if test="$ext = '.xsl'">f1</xsl:if>
				</xsl:variable>

				<xsl:variable name="other">
					<xsl:if test="$ext != '.xsl'">
						<xsl:value-of select="$url-f2" />
					</xsl:if>
					<xsl:if test="$ext = '.xsl'">
						<xsl:value-of select="$url-f1" />
					</xsl:if>
				</xsl:variable>

				<xsl:value-of select="concat($root, '/view/', $gist-id, '/', $sha1, '?', $s1, '=', filename, '&amp;', $s2, '=', $other)" />

			</xsl:attribute>


			<xsl:value-of select="filename" />
		</a>
	</li>
</xsl:template>

<xsl:template match="revisions-list/revision" >
	<li>
		<xsl:if test="$sha1 = @version or ($sha1 = '' and position() = 1)">
			<xsl:attribute name="class">current</xsl:attribute>
		</xsl:if>

		<a href="{$root}/view/{$gist-id}/{@version}">
			<xsl:value-of select="substring(@version, 1, 6)" />
		</a>
	</li>
</xsl:template>

<xsl:template match="forks-list/fork">
	<li>
		<a href="{$root}/view/{@id}">
			<xsl:value-of select="@user" />
		</a>
	</li>
</xsl:template>

<xsl:template match="events/update-gist">
	<div class="error">
		<xsl:value-of select="message" />
	</div>
</xsl:template>

</xsl:stylesheet>
