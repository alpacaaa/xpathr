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
	<xsl:apply-templates select="data/gist-by-id/entry" />
</xsl:template>


<xsl:template match="gist-by-id/entry">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css" />
		<link rel='stylesheet' type="text/css" href="http://fonts.googleapis.com/css?family=Droid+Sans" />
		<link rel="stylesheet" href="{$workspace}/assets/style.php" />

		<title>Xpathr</title>
	</head>
	<body>
		<form id="main" method="post" action="">
			<div id="head">
				<h2>gist #<xsl:value-of select="$gist-id" /></h2>

				<div id="actions">
					<a href="{$root}/process/{$gist-id}/{$sha1}" class="process">Process</a>
					<input type="submit" name="action[update-gist]" value="Save" />
				</div>
			</div>

			<div id="files">
				<xsl:apply-templates select="/data/files-by-revision/entry[filename/text() = 'master.xml' or filename/text() = 'master.xsl']" />
			</div>

			<div id="meta">
				<div id="user">
					<img src="https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png" />
					<a href="#user">
						<xsl:value-of select="user" />
					</a>
				</div>

				<div id="revisions">
					<h4>Revisions</h4>
					<ul>
						<xsl:apply-templates select="revisions-list/revision" />
					</ul>
				</div>

				<xsl:if test="forks-list/fork">
					<div id="forks">
						<h4>Forks</h4>
						<ul>
							<xsl:apply-templates select="forks-list/fork" />
						</ul>
					</div>
				</xsl:if>
			</div>

		</form>
	</body>
</html>
</xsl:template>


<xsl:template match="files-by-revision/entry">
	<div>
		<div class="meta">
			<h5><xsl:value-of select="filename" /></h5>
			<ul>
				<xsl:apply-templates select="/data/files-by-revision/entry" mode="list">
					<xsl:with-param name="current" select="filename" />
				</xsl:apply-templates>
			</ul>
		</div>

		<textarea name="files[{filename}]"><xsl:value-of select="content" /></textarea>
	</div>
</xsl:template>


<xsl:template match="files-by-revision/entry" mode="list">
	<xsl:param name="current" />

	<xsl:if test="$current != filename">
		<li>
			<a href="#">
				<xsl:value-of select="filename" />
			</a>
		</li>
	</xsl:if>
</xsl:template>



<xsl:template match="revisions-list/revision" >
	<li>
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

</xsl:stylesheet>
