<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:param name="sha1" select="''" />

<xsl:param name="url-f1" select="'master.xml'" />
<xsl:param name="url-f2" select="'master.xsl'" />


<xsl:template match="data">
	<xsl:apply-templates select="gist-by-id/entry" />
</xsl:template>


<xsl:template match="gist-by-id/entry">
	<form id="main" method="post" action="">
		<div id="head">
			<h2>gist #<xsl:value-of select="$gist-id" /></h2>

			<div id="actions">
				<a href="{$root}/process/{$gist-id}/{$sha1}" class="process">Process</a>
				<input type="submit" name="action[update-gist]" value="Save" />
			</div>
		</div>

		<div id="files">
			<xsl:apply-templates select="/data/files-by-revision/entry[filename/text() = $url-f1]" />
			<xsl:apply-templates select="/data/files-by-revision/entry[filename/text() = $url-f2]" />
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

	<xsl:if test="filename != $url-f1 and filename != $url-f2">
		<li>
			<a>
				<xsl:attribute name="href">
					<xsl:variable name="s1">
						<xsl:if test="$current = $url-f1">f1</xsl:if>
						<xsl:if test="$current = $url-f2">f2</xsl:if>
					</xsl:variable>

					<xsl:variable name="s2">
						<xsl:if test="$current = $url-f1">f2</xsl:if>
						<xsl:if test="$current = $url-f2">f1</xsl:if>
					</xsl:variable>

					<xsl:variable name="other">
						<xsl:if test="$current = $url-f1">
							<xsl:value-of select="$url-f2" />
						</xsl:if>
						<xsl:if test="$current = $url-f2">
							<xsl:value-of select="$url-f1" />
						</xsl:if>
					</xsl:variable>					

					<xsl:value-of select="concat($root, '/view/', $gist-id, '/', $sha1, '?', $s1, '=', filename, '&amp;', $s2, '=', $other)" />

				</xsl:attribute>


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
