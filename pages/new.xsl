<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/xpathr.xsl" />

<xsl:template name="actions">
	<input type="submit" name="action[create-gist]" value="Create" />
</xsl:template>

<xsl:template name="meta">
	<div id="meta">
		<xsl:call-template name="user" />
		<xsl:apply-templates select="/data/gists-by-user" />
	</div>
</xsl:template>

<xsl:template match="gists-by-user">
	<h4><xsl:if test="$github-user != ''">My </xsl:if>Recent Gists</h4>
	<ul class="menu">
		<xsl:apply-templates select="entry" mode="gists-by-user" />
	</ul>
</xsl:template>

<xsl:template match="entry" mode="gists-by-user">
	<li>
		<a href="{$root}/view/{gist-id}/">
			<xsl:if test="title">
				<xsl:attribute name="title"><xsl:value-of select="title" /></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="gist-id" />
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
