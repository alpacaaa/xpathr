<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/xpathr.xsl" />
<xsl:import href="../utilities/meta.xsl" />

<xsl:param name="url-f2" />

<xsl:template name="bin">
	<div id="bin" class="stretch">
		<div id="source" class="binview stretch">
			<div class="code stretch result">
				<div class="label">
					<p>
						<strong>Result</strong>
						<span>
							<a href="https://gist.github.com/{$gist-id}">gist: <xsl:value-of select="$gist-id" /></a>
						</span>
					</p>
				</div>
				<xsl:apply-templates select="process-gist-by-id/*" />
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template name="codemirror">
	<script>
		var result_editor = CodeMirror.fromTextArea(document.getElementById("result"), {lineNumbers: true});
	</script>
</xsl:template>

<xsl:template name="buttons">
	<a class="tab button left right gap" accesskey="1" href="{$root}/view/{$gist-id}/{$sha1}/" id="btn-code">Code</a>
	<xsl:apply-templates select="params/gist-id" mode="process" />
</xsl:template>

<xsl:template match="params/gist-id" mode="process">
	<a class="tab button left right current" accesskey="3" href="{$root}/process/{$gist-id}/{$sha1}/" id="btn-result">Result</a>
</xsl:template>

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

<xsl:template name="meta">
	<xsl:apply-templates select="data/gist-by-id/entry" mode="meta" />
</xsl:template>

<xsl:template match="process-gist-by-id/result">
	<textarea id="result" name="result" cols="50" rows="20"><xsl:value-of select="text()" /></textarea>
</xsl:template>

<xsl:template match="process-gist-by-id/message">
	<div class="error">
		<xsl:value-of select="text()" />
	</div>
</xsl:template>

<xsl:template match="process-gist-by-id/errors">
	<ul class="errors">
		<xsl:apply-templates select="error" />
	</ul>
</xsl:template>

<xsl:template match="error">
	<li>
		<xsl:value-of select="text()" />
	</li>
</xsl:template>

</xsl:stylesheet>
