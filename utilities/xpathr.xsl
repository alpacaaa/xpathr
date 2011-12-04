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
<xsl:param name="github-user" select="''" />
<xsl:param name="ui-assets" select="concat($workspace, '/assets/ui/')" />

<xsl:template match="/">
	<html lang="en">
		<head>
			<meta charset="utf-8" />
			<title>XPathr - Collaborative XSLT Development</title>
			<link rel="stylesheet" href="{$ui-assets}codemirror/lib/codemirror.css" />
			<link rel="stylesheet" href="{$ui-assets}codemirror/theme/default.css" />
			<link rel="stylesheet" href="{$ui-assets}css/xpathr.css" type="text/css" />
			<script src="{$ui-assets}codemirror/lib/codemirror.js"></script>
			<script src="{$ui-assets}codemirror/mode/xml/xml.js"></script>
		</head>
		<!--[if lt IE 7 ]><body class="source ie6"><![endif]--> 
		<!--[if !IE]><!--><body class="source"><!--<![endif]-->	 
			<div id="header">
				<h1><a href="{$root}/">XPathr</a></h1>
				<div class="help">
					<ul class="menu">
						<xsl:apply-templates select="data/events/github" />
						<li><a href="{$ui-assets}/help/index.html">Help</a></li>
					</ul>
				</div>
			</div>
			<xsl:apply-templates select="data" mode="xpathr" />
			<xsl:call-template name="codemirror" />
			<script src="{$ui-assets}js/jquery.min.js"></script>
			<script src="{$ui-assets}js/xpathr.js"></script>
		</body>
	</html>
</xsl:template>

<xsl:template match="data" mode="xpathr">
	<form id="main" method="post" action="">
		<xsl:call-template name="control" />
		<xsl:call-template name="bin" />
	</form>
</xsl:template>

<xsl:template name="control">
	<div id="control">
		<div class="control">
			<div class="buttons">
				<xsl:call-template name="buttons" />
			</div>
			<div class="actions">
				<xsl:call-template name="actions" />
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template name="buttons">
	<a class="tab button btn-xml group left" accesskey="1" href="#xml">XML</a>
	<a class="tab button btn-xslt group gap right" accesskey="2" href="#xslt">XSLT</a>
	<xsl:apply-templates select="params/gist-id" mode="process" />
</xsl:template>

<xsl:template match="params/gist-id" mode="process">
	<a class="tab button btn-result left right" accesskey="3" href="{$root}/process/{$gist-id}/">Result</a>
</xsl:template>

<xsl:template name="actions" />

<xsl:template name="bin">
	<div id="bin" class="stretch">
		<div id="source" class="binview stretch">
			<xsl:call-template name="xml-editor" />
			<xsl:call-template name="xslt-editor" />
		</div>
	</div>
</xsl:template>

<xsl:template name="xml-editor">
	<div class="code stretch xml">
		<div class="label"><p><strong>XML</strong></p></div>
		<textarea id="xml" name="xml" cols="50" rows="20"><xsl:call-template name="xml" /></textarea>
	</div>
</xsl:template>

<xsl:template name="xml">
&lt;data&gt;
  &lt;hello&gt;paste your xml here&lt;/hello&gt;
&lt;/data&gt;
</xsl:template>

<xsl:template name="xslt-editor">
	<div class="code stretch xslt">
		<div class="label"><p><strong>XSLT</strong></p></div>
		<textarea id="xslt" name="xslt" cols="50" rows="20"><xsl:call-template name="xslt" /></textarea>
	</div>
</xsl:template>

<xsl:template name="xslt">
&lt;xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"&gt;

  &lt;xsl:output method="xml" indent="yes" /&gt;

  &lt;xsl:template match="/"&gt;
    &lt;hi&gt;
      &lt;xsl:value-of select="data/hello" /&gt;
    &lt;/hi&gt;
  &lt;/xsl:template&gt;

&lt;/xsl:stylesheet&gt;
</xsl:template>

<xsl:template match="events/github">
	<xsl:if test="@logged-in = 'yes'">
		<li>
			<xsl:if test="$current-page = 'new'">
				<xsl:attribute name="class">current</xsl:attribute>
			</xsl:if>
			<a href="{$root}/">New</a>
		</li>
		<li><a href="?github-oauth-action=logout">Logout</a></li>
	</xsl:if>

	<xsl:if test="@logged-in = 'no'">
		<li><a href="{$root}/authenticate">Login</a></li>
	</xsl:if>
</xsl:template>

<xsl:template name="codemirror">
	<script>
		var xml_editor = CodeMirror.fromTextArea(document.getElementById("xml"));
		var xslt_editor = CodeMirror.fromTextArea(document.getElementById("xslt"));
	</script>
</xsl:template>

</xsl:stylesheet>
