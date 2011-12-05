<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/xpathr.xsl" />
<xsl:import href="../utilities/meta.xsl" />

<xsl:template name="xml-editor">
	<xsl:apply-templates select="files-by-revision/entry[filename/text() = $url-f1]" mode="view-xml" />
</xsl:template>

<xsl:template name="xslt-editor">
	<xsl:apply-templates select="files-by-revision/entry[filename/text() = $url-f2]" mode="view-xslt" />
</xsl:template>

<xsl:template match="files-by-revision/entry" mode="view-xml">
	<div class="code stretch xml">
		<xsl:call-template name="editor-textarea">
			<xsl:with-param name="label" select="'XML'" />
			<xsl:with-param name="type" select="'xml'" />
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template match="files-by-revision/entry" mode="view-xslt">
	<div class="code stretch xslt">
		<xsl:call-template name="editor-textarea">
			<xsl:with-param name="label" select="'XSLT'" />
			<xsl:with-param name="type" select="'xslt'" />
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template name="editor-textarea">
	<xsl:param name="label" />
	<xsl:param name="type" />
	<xsl:variable name="post" 
	select="/data/events/update-gist/data/item[@key = 'files']/item[@key = current()/filename]" />

	<xsl:variable name="value">
		<xsl:if test="$post"><xsl:value-of select="$post" /></xsl:if>
		<xsl:if test="not($post)"><xsl:value-of select="content" /></xsl:if>
	</xsl:variable>
	<div class="label">
		<p>
			<strong><xsl:value-of select="$label" /></strong>
			<span>
				<a href="https://gist.github.com/{$gist-id}">gist: <xsl:value-of select="$gist-id" /></a>
				<a href="https://gist.github.com/{$gist-id}#file_{filename}"><xsl:value-of select="filename" /></a>
			</span>
		</p>
	</div>
	<textarea id="{$type}" name="files[{filename}]" cols="50" rows="20"><xsl:value-of select="$value" /></textarea>
</xsl:template>

<xsl:variable name="owner" select="$github-user = /data/gist-by-id/entry/user"></xsl:variable>

<xsl:template name="actions">
	<xsl:choose>
		<xsl:when test="$owner">
			<input type="submit" name="action[update-gist]" value="Save" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$github-user">
				<input type="submit" name="action[fork-gist]" value="Fork" />
			</xsl:if>

			<xsl:if test="$github-user = ''">
				<span class="authenticate"><a href="{$root}/authenticate">Login</a> to fork</span>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="meta">
	<xsl:apply-templates select="data/gist-by-id/entry" mode="meta" />
</xsl:template>

</xsl:stylesheet>
