<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:param name="sha1" select="''" />

<xsl:template match="/">
	<h2>
		Result of gist 
		<a href="{$root}/view/{$gist-id}">
			#<xsl:value-of select="$gist-id" />
		</a>

		<xsl:if test="$sha1">
			@ 
			<a href="{$root}/view/{$gist-id}/{$sha1}">
				<xsl:value-of select="$sha1" />
			</a>
		</xsl:if>
	</h2>


	<xsl:apply-templates select="data/process-gist-by-id/*" />

</xsl:template>



<xsl:template match="process-gist-by-id/result">
	<pre>
		<xsl:value-of select="text()" />
	</pre>
</xsl:template>

<xsl:template match="process-gist-by-id/message">
	<div class="error">
		<xsl:value-of select="text()" />
	</div>
</xsl:template>

<xsl:template match="process-gist-by-id/errors">
	<ul>
		<xsl:apply-templates select="error" />
	</ul>
</xsl:template>

<xsl:template match="error">
	<li>
		<xsl:value-of select="text()" />
	</li>
</xsl:template>

</xsl:stylesheet>
