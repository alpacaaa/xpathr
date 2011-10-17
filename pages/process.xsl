<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template match="data">
	<div id="main">

		<div id="head">
			<h2>
				Result of gist 
				<a href="{$root}/view/{$gist-id}">
					#<xsl:value-of select="$gist-id" />
				</a>

				<xsl:if test="$sha1">
					@ 
					<a href="{$root}/view/{$gist-id}/{$sha1}">
						<xsl:value-of select="substring($sha1, 1, 6)" />
					</a>
				</xsl:if>
			</h2>
		</div>

		<xsl:apply-templates select="process-gist-by-id/*" />
	</div>

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
