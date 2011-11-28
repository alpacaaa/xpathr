<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/xpathr.xsl" />

<xsl:template match="data">
	<form id="main" method="post" action="">
		<div id="head">
			<h2>Create new gist</h2>

			<div id="actions">
				<input type="submit" name="action[create-gist]" value="Create" />
			</div>
		</div>

		<div id="files">
			<div>
				<div class="meta">
					<h5>XML</h5>
				</div>

				<textarea name="xml">&lt;data&gt;
	&lt;hello&gt;paste your xml here&lt;/hello&gt;
&lt;/data&gt;</textarea>
			</div>

			<div>
				<div class="meta">
					<h5>XSL</h5>
				</div>

				<textarea name="xsl">&lt;xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"&gt;

&lt;xsl:output method="xml" indent="yes" /&gt;

&lt;xsl:template match="/"&gt;
	&lt;hi&gt;
		&lt;xsl:value-of select="data/hello" /&gt;
	&lt;/hi&gt;
&lt;/xsl:template&gt;

&lt;/xsl:stylesheet&gt;</textarea>
			</div>
		</div>

	</form>
</xsl:template>
</xsl:stylesheet>
