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

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css" />
		<link rel='stylesheet' type="text/css" href="http://fonts.googleapis.com/css?family=Droid+Sans" />
		<link rel="stylesheet" href="{$workspace}/assets/style.php" />

		<title>Xpathr</title>
	</head>
	<body>
		<div id="header">
			<div>
				<h1>xpathr</h1>

				<ul>
					<li>
						<a href="#">new gist</a>
					</li>
					<li class="login">
						<a href="#">login</a>
					</li>
				</ul>
			</div>
		</div>

		<xsl:apply-templates select="data" />
	</body>
</html>

</xsl:template>


</xsl:stylesheet>
