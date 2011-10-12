<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/">
	<h1>hi!</h1>
	<p>
		This will show you the awesomeness of the xpathr extension in all its glory :)
	</p>
	
	<xsl:if test="data/params/github-access-token">
		<p>
			Looks like you are authenticated, let's create a simple gist.
		</p>

		<form action="" method="post">
			<div>
				<label>XML</label>
				<textarea name="xml"></textarea>
			</div>

			<div>
				<label>XSL</label>
				<textarea name="xsl"></textarea>
			</div>

			<input type="submit" name="action[create-gist]" />
		</form>
	</xsl:if>

	<xsl:if test="not(data/params/github-access-token)">
		<p>
			You're not yet authenticated, please <a href="{$root}/authenticate">go authenticate</a>!
		</p>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
